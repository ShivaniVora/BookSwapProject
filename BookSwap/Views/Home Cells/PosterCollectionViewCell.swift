//
//  PosterCollectionViewCell.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/20/22.
//

import UIKit

protocol PosterCollectionViewCellDelegate: AnyObject {
    func posterCollectionViewCellDidTapDelete(_ cell: PosterCollectionViewCell, index: Int)
    func posterCollectionViewCellDidTapName(_ cell: PosterCollectionViewCell, index: Int)
}

final class PosterCollectionViewCell: UICollectionViewCell {
    static let identifier = "PosterCollectionViewCell"
    
    private var action = DeleteButtonUser.edit
    
    private var index = 0
    
    weak var delegate: PosterCollectionViewCellDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let deleteButton: UIButton = {
            let button = UIButton()
            button.tintColor = .systemRed
            let image = UIImage(systemName: "trash",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
            button.setImage(image, for: .normal)
            return button
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(nameLabel)
        contentView.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapName))
        nameLabel.isUserInteractionEnabled = true
        nameLabel.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func didTapName() {
        delegate?.posterCollectionViewCellDidTapName(self, index: index)
    }
    
    @objc func didTapDelete() {
        switch action {
        case .edit:
            delegate?.posterCollectionViewCellDidTapDelete(self, index: index)
        case .hidden:
            break
        }
            
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: 12, y: 0, width: nameLabel.width, height: contentView.height)
        deleteButton.frame = CGRect(x: contentView.width-55,
                                          y: (contentView.height-50)/2,
                                          width: 50,
                                          height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
    
    func configure(with viewModel: PosterCollectionViewCellViewModel) {
        nameLabel.text = "\(viewModel.firstName) \(viewModel.lastName)"
            
        switch viewModel.deleteButton {
        case .edit:
            deleteButton.isHidden = false
        
        case .hidden:
            deleteButton.isHidden = true
        }
    }
}

