//
//  PostViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//
//
import UIKit

class PostViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private let post: Post
    
    private var viewModels: [HomeFeedCellType] = []

    private var collectionView: UICollectionView?
        
    private var allPosts: [(post: Post, owner: String)] = []
    
    private let owner: String
    private let firstN: String
    private let lastN: String
    
    
    init(post: Post, owner: String, firstN: String, lastN: String){
        self.owner = owner
        self.firstN = firstN
        self.lastN = lastN
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Post"
            view.backgroundColor = .systemBackground
            configureCollectionView()
            fetchPost()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            collectionView?.frame = view.bounds
        }
        
        private func fetchPost() {
            let email = owner
            let lastName = lastN
            let firstName = firstN
            DatabaseManager.shared.getPost(with: post.id, from: email) { [weak self] post in
                guard let post = post else {
                    return
                }
                
                self?.createViewModel(model: post, email: email, firstName: firstName, lastName: lastName, completion: { success in
                                        guard success else {
                                            print("failed to create VM")
                                            return
                                        }
                    
                    DispatchQueue.main.async {
                        self?.collectionView?.reloadData()
                    }
                    
                })
                
            }
            
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
                
                .subject(viewModel: PostSubjectCollectionViewCellViewModel(subject: model.subject))
                
            ]
        
            self.viewModels = postData
            completion(true)
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
            let cellType = viewModels[indexPath.row]
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

extension PostViewController: PosterCollectionViewCellDelegate {
    func posterCollectionViewCellDidTapName(_ cell: PosterCollectionViewCell, index: Int) {
            DatabaseManager.shared.findUser(with: owner) { [weak self] user in
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

    extension PostViewController {
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
            
            self.collectionView = collectionView
        }
    }
