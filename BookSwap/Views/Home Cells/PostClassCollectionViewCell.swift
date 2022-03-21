//
//  PostClassCollectionViewCell.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/20/22.
//

import UIKit

class PostClassCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostClassCollectionViewCell"
    
    private let classLabel: UILabel = {
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
        contentView.addSubview(classLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tSize = classLabel.sizeThatFits(CGSize(width: contentView.bounds.size.width-12, height: contentView.bounds.size.height))
        classLabel.frame = CGRect(x: 12, y: 3, width: tSize.width, height: tSize.height)
        let size = label.sizeThatFits(CGSize(width: contentView.bounds.size.width-12, height: contentView.bounds.size.height))
        label.frame = CGRect(x: classLabel.right + 3, y: 3, width: size.width, height: size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        classLabel.text = nil
        label.text = nil
    }
    
    func configure(with viewModel: PostClassCollectionViewCellViewModel) {
        classLabel.text = "Class:"
        label.text = "\(viewModel.schoolClass ?? "")"
    }
}
