//
//  ProfileViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import UIKit

class ProfileViewController: UIViewController {

    private let user: User
    
    private var posts: [Post] = []
    
    private var isCurrentUser: Bool {
        return user.email.lowercased() == UserDefaults.standard.string(forKey: "email")?.lowercased() ?? ""
    }
    
    private var collectionView: UICollectionView?
    
    private var headerViewModel: ProfileHeaderViewModel?
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(user.firstName) \(user.lastName)"
        view.backgroundColor = .systemBackground
        configureNavBar()
        configureCollectionView()
        fetchProfileInfo()
    }
    
    
    private func fetchProfileInfo() {
        //name, email, profile
        
        var buttonType: ProfileButtonType = .edit
        var firstName: String = ""
        var lastName: String = ""
        var name: String = ""
        var email: String = ""
        var phone: String = ""
        
        let group = DispatchGroup()
        
        DatabaseManager.shared.getUserInfo(email: user.email) { [weak self] userInfo, user in
            phone = userInfo?.phone ?? ""
            email = user?.email ?? ""
            firstName = user?.firstName ?? ""
            lastName = user?.lastName ?? ""
            name = "\(firstName) \(lastName)"
            
            if !(self?.isCurrentUser ?? false) {
                buttonType = .hidden
            }
            
            self?.headerViewModel = ProfileHeaderViewModel(name: name, email: email, phone: phone, buttonType: buttonType)
            
            self?.collectionView?.reloadData()
        }
        
        
        
        group.enter()
        
        if !isCurrentUser {
            group.enter()
            buttonType = .hidden
        }
        
        //Fetch posts
        DatabaseManager.shared.posts(for: email) { [weak self] result in
            defer {
                group.leave()
            }
            
            /*group.notify(queue: .main) {
                self.headerViewModel = ProfileHeaderViewModel(name: name, email: email, phone: phone ?? "", buttonType: buttonType)
            }*/
            
            switch result {
            case .success(let posts):
                self?.posts = posts
            case .failure:
                break
            }
        }
    }
            
            
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func configureNavBar() {
        if isCurrentUser {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        }
    }
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError()
        }
        
        cell.configure(with: UIImage(named: "test"))
        //cell.configure(with: URL(string: posts[indexPath.row].postURLString))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier, for: indexPath) as? ProfileHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        //Uncomment to access the data from fetchUserInfo (and comment two lines below)
        if let viewModel = headerViewModel {
            headerView.configure(with: viewModel)
        }
        
        /*let viewModel = ProfileHeaderViewModel(name: "Joe Smith", email: "joesmith@email", phone: "(123)-456-789", buttonType: self.isCurrentUser ? .edit : .hidden)
        headerView.configure(with: viewModel)*/
        
        headerView.delegate = self
        
        //let viewModel = ProfileHeaderViewModel(name: "Joey Smith", email: "jsmith@email.com", phone: "123-456-789", buttonType: self.isCurrentUser ? .edit : .hidden)
        //headerView.configure(with: viewModel)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let post = posts[indexPath.row]
        let vc = PostViewController(post: post)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ProfileViewController {
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: {index, _ -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3)), subitem: item, count: 3)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/2)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
            
            return section
            
        }))
        
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.register(ProfileHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        self.collectionView = collectionView
    }
}

extension ProfileViewController: ProfileHeaderCollectionReusableViewDelegate {
    func profileHeaderCollectionViewDidTapEditProfile(_ reusableView: ProfileHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.completion = { [weak self] in
            self?.headerViewModel = nil
            self?.fetchProfileInfo()
        }
        
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
}
