//
//  ViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/16/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
    
    private var searchVC = UISearchController(searchResultsController: SearchResultsViewController())
    
    private var viewModels = [[HomeFeedCellType]]()

    private var collectionView: UICollectionView?
    
    private var observer: NSObjectProtocol?
    
    private var allPosts: [(post: Post, owner: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        (searchVC.searchResultsController as? SearchResultsViewController)?.delegate = self
        searchVC.searchBar.placeholder = "Search..."
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
        configureCollectionView()
        fetchPosts()
        
        observer = NotificationCenter.default.addObserver(
            forName: .didPostNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.viewModels.removeAll()
            self?.fetchPosts()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsVC = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return
        }
        
        DatabaseManager.shared.findUsers(with: query) { results in
            DispatchQueue.main.async {
                resultsVC.update(with: results)
            }
        }
    }
    
    private func fetchPosts() {
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            return
        }
        guard let firstName = UserDefaults.standard.string(forKey: "firstName") else {
            return
        }
        guard let lastName = UserDefaults.standard.string(forKey: "lastName") else {
            return
        }
        
        let userGroup = DispatchGroup()
        userGroup.enter()
        
        var allPosts: [(post: Post, owner: String)] = []
        
        
        DatabaseManager.shared.getAllUsers(for: email) { emails in
            defer {
                userGroup.leave()
            }
            
            
            let users = emails
            
            for current in users {
                userGroup.enter()
                DatabaseManager.shared.posts(for: current) { result in
                    DispatchQueue.main.async {
                        defer {
                            userGroup.leave()
                        }
                        switch result {
                        case .success(let posts):
                            allPosts.append(contentsOf: posts.compactMap({
                                (post: $0, owner: current)
                            }))
                            
                            
                        case .failure:
                            break
                        }
                    }
                }
            }
        }
        
        userGroup.notify(queue: .main) {
            let group = DispatchGroup()
            self.allPosts = allPosts
            allPosts.forEach { model in
                group.enter()
                DatabaseManager.shared.returnFN(for: model.owner) { fn in
                    DatabaseManager.shared.returnLN(for: model.owner) { ln in
                        self.createViewModel(model: model.post,
                                             email: model.owner,
                                             firstName: fn,
                                             lastName: ln,
                                             completion: { success in
                                                defer {
                                                    group.leave()
                                                }
                                                if !success {
                                                    print("failed to create VM")
                                                }
                                            })
                    }
                }
                
            }
            group.notify(queue: .main) {
                self.sortData()
                self.collectionView?.reloadData()
            }
            
            /*group.notify(queue: .main) {
                self.collectionView?.reloadData()
            }*/
        }
    }
    
    private func sortData() {
        allPosts = allPosts.sorted(by: { first, second in
            let date1 = first.post.date
            let date2 = second.post.date
            
            if let date1 = date1, let date2 = date2 {
                return date1 > date2
            }
            
            return false
        })
        
        
        viewModels = viewModels.sorted(by: { first, second in
            var date1: Date?
            var date2: Date?
            first.forEach { type in
                switch type {
                case .timestamp(let vm):
                    date1 = vm.date
                default:
                    break
                }
            }
            second.forEach { type in
                switch type {
                case .timestamp(let vm):
                    date2 = vm.date
                default:
                    break
                }
            }
            
            if let date1 = date1, let date2 = date2 {
                return date1 > date2
            }
            return false
        })
    }
    
    private func createViewModel(model: Post, email: String, firstName: String, lastName: String, completion: @escaping (Bool) -> Void) {
        //mock data
        let group = DispatchGroup()
        group.enter()
        
        guard let postURL = URL(string: model.postURLString) else {
            return
        }
    
        let postData: [HomeFeedCellType] = [
            .poster(viewModel: PosterCollectionViewCellViewModel(firstName: firstName, lastName: lastName)),
        
            .post(viewModel: PostCollectionViewCellViewModel(postUrl: postURL)),
            
            .title(viewModel: PostTitleCollectionViewCellViewModel(title: model.title)),
            
            .author(viewModel: PostAuthorCollectionViewCellViewModel(author: model.author)),
            
            .isbn(viewModel: PostISBNCollectionViewCellViewModel(isbn: model.isbn)),
            
            .schoolClass(viewModel: PostClassCollectionViewCellViewModel(schoolClass: model.schoolClass)),
            
            .subject(viewModel: PostSubjectCollectionViewCellViewModel(subject: model.subject)),
            
            .timestamp(viewModel: PostDatetimeCollectionViewCellViewModel(date: DateFormatter.formatter.date(from: model.postedDate) ?? Date()))
            
        ]
    
        self.viewModels.append(postData)
        completion(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModels.count
    }
    
    let colors: [UIColor] = [
        .red,
        .green,
        .blue,
        .yellow,
        .orange,
        .systemPink,
        .brown
    ]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = viewModels[indexPath.section][indexPath.row]
        switch cellType {
        case .poster(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
                fatalError()
            }
            cell.delegate = self
            cell.configure(with: viewModel)
            return cell
            
        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .title(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostTitleCollectionViewCell.identifier, for: indexPath) as? PostTitleCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .author(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostAuthorCollectionViewCell.identifier, for: indexPath) as? PostAuthorCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .isbn(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostISBNCollectionViewCell.identifier, for: indexPath) as? PostISBNCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .schoolClass(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostClassCollectionViewCell.identifier, for: indexPath) as? PostClassCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .subject(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostSubjectCollectionViewCell.identifier, for: indexPath) as? PostSubjectCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .timestamp(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDatetimeCollectionViewCell.identifier, for: indexPath) as? PostDatetimeCollectionViewCell else {
                        fatalError()
                }
            cell.configure(with: viewModel)
            return cell
        }
    }
}

extension HomeViewController: PosterCollectionViewCellDelegate {
    func posterCollectionViewCellDidTapName(_ cell: PosterCollectionViewCell, index: Int) {
        let email = allPosts[index].owner
        DatabaseManager.shared.findUser(with: email) { [weak self] user in
                    DispatchQueue.main.async {
                        guard let user = user else {
                            return
                        }
                        let vc = ProfileViewController(user: user)
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
            }
    }
}

extension HomeViewController {
    func configureCollectionView() {
        let sectionHeight: CGFloat = 277 + view.width
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { index, _ -> NSCollectionLayoutSection? in
            
            let posterItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45)))
            
            let postItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)))
            
            let titleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(52)))
            
            let authorItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45)))
            
            let isbnItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45)))
            
            let classItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45)))
            
            let subjectItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45)))
            
            //cell for poster
            //cell for post
            //cell for caption(title/author/isbn/class/subject)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(sectionHeight)), subitems: [posterItem, postItem, titleItem, authorItem, isbnItem, classItem, subjectItem])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 10)
            
            return section
            
        }))
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        
        collectionView.register(PostTitleCollectionViewCell.self, forCellWithReuseIdentifier: PostTitleCollectionViewCell.identifier)
        
        collectionView.register(PostAuthorCollectionViewCell.self, forCellWithReuseIdentifier: PostAuthorCollectionViewCell.identifier)
        
        collectionView.register(PostISBNCollectionViewCell.self, forCellWithReuseIdentifier: PostISBNCollectionViewCell.identifier)
        
        collectionView.register(PostClassCollectionViewCell.self, forCellWithReuseIdentifier: PostClassCollectionViewCell.identifier)
        
        collectionView.register(PostSubjectCollectionViewCell.self, forCellWithReuseIdentifier: PostSubjectCollectionViewCell.identifier)
        
        collectionView.register(PostDatetimeCollectionViewCell.self, forCellWithReuseIdentifier: PostDatetimeCollectionViewCell.identifier)
        
        self.collectionView = collectionView
    }
}

extension HomeViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewController(_ vc: SearchResultsViewController, didSelectResultWith user: User) {
        let vc = ProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}

