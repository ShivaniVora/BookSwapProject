//
//  PostTitleCollectionViewCell.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/20/22.
//

import UIKit

class PostTitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostTitleCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tSize = titleLabel.sizeThatFits(CGSize(width: contentView.bounds.size.width-12, height: contentView.bounds.size.height))
        titleLabel.frame = CGRect(x: 12, y: 10, width: tSize.width, height: tSize.height)
        let size = label.sizeThatFits(CGSize(width: contentView.bounds.size.width-12, height: contentView.bounds.size.height))
        label.frame = CGRect(x: titleLabel.right + 3, y: 10, width: size.width, height: size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        label.text = nil
    }
    
    func configure(with viewModel: PostTitleCollectionViewCellViewModel) {
        titleLabel.text = "Title:"
        label.text = "\(viewModel.title ?? "")"
    }
}
