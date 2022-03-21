//
//  ViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/16/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var viewModels = [[HomeFeedCellType]]()

    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        configureCollectionView()
        fetchPosts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func fetchPosts() {
        //mock data
        let postData: [HomeFeedCellType] = [
            .poster(viewModel: PosterCollectionViewCellViewModel(firstName: "Joe", lastName: "Smith")),
            
            .post(viewModel: PostCollectionViewCellViewModel(postUrl: URL(string: "https://iosacademy.io/assets/images/brand/icon.jpg")!)),
            
            .title(viewModel: PostTitleCollectionViewCellViewModel(title: "Book Title")),
            
            .author(viewModel: PostAuthorCollectionViewCellViewModel(author: "Book Author")),
            
            .isbn(viewModel: PostISBNCollectionViewCellViewModel(isbn: "1234567891")),
            
            .schoolClass(viewModel: PostClassCollectionViewCellViewModel(schoolClass: "Class that book is for")),
            
            .subject(viewModel: PostSubjectCollectionViewCellViewModel(subject: "Class Subject"))
            
        ]
        
        viewModels.append(postData)
        collectionView?.reloadData()
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
        }
        
    }
}

extension HomeViewController: PosterCollectionViewCellDelegate {
    func posterCollectionViewCellDidTapName(_ cell: PosterCollectionViewCell) {
        let vc = ProfileViewController(user: User(firstName: "Joe", lastName: "Smith", email: "joesmith@email.com"))
        navigationController?.pushViewController(vc, animated: true)
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
        
        self.collectionView = collectionView
    }
}

