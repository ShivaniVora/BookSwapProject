//
//  ProfileHeaderCollectionReusableView.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/29/22.
//

import UIKit


protocol ProfileHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderCollectionViewDidTapEditProfile(_ header: ProfileHeaderCollectionReusableView)
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    weak var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    private var action = ProfileButtonType.edit
    
    static let identifier = "ProfileHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(nameLabel)
        addSubview(emailLabel)
        addSubview(phoneLabel)
        addSubview(actionButton)
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonHeight = width/10
        nameLabel.frame = CGRect(x: 5, y: 5, width: width-10, height: 50)
                
        emailLabel.frame = CGRect(x: 5, y: 3 + nameLabel.bottom, width: width-10, height: buttonHeight)
                
        phoneLabel.frame = CGRect(x: 5, y: 3 + emailLabel.bottom, width: width-10, height: buttonHeight)
                
        actionButton.frame = CGRect(x: 10, y: 5 + phoneLabel.bottom, width: width-20, height: buttonHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        emailLabel.text = nil
        phoneLabel.text = nil
        actionButton.isHidden = false
    }
    
    public func configure(with viewModel: ProfileHeaderViewModel) {
        self.action = viewModel.buttonType
        
        switch viewModel.buttonType {
        case .edit:
            actionButton.isHidden = false
            actionButton.backgroundColor = .secondarySystemBackground
            actionButton.setTitle("Edit Profile", for: .normal)
            actionButton.setTitleColor(.label, for: .normal)
            actionButton.layer.borderWidth = 0.5
            actionButton.layer.borderColor = UIColor.tertiaryLabel.cgColor
        case .hidden:
            actionButton.isHidden = true
        }
        nameLabel.text = viewModel.name
        emailLabel.text = viewModel.email
        phoneLabel.text = viewModel.phone
    }
    
    private func addActions() {
        actionButton.addTarget(self, action: #selector(didTapEditProfile), for: .touchUpInside)
    }
    
    @objc func didTapEditProfile() {
        switch action {
        case .edit:
            delegate?.profileHeaderCollectionViewDidTapEditProfile(self)
        case .hidden:
            break
        }
    }
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.isHidden = false
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Joe Smith"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "joe@gmail.com"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "(123)-456-7890"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
}
