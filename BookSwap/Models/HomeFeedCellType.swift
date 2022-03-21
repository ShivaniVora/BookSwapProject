//
//  HomeFeedCellType.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/20/22.
//

import Foundation

enum HomeFeedCellType {
    case poster(viewModel: PosterCollectionViewCellViewModel)
    case post(viewModel: PostCollectionViewCellViewModel)
    case title(viewModel: PostTitleCollectionViewCellViewModel)
    case author(viewModel: PostAuthorCollectionViewCellViewModel)
    case isbn(viewModel: PostISBNCollectionViewCellViewModel)
    case schoolClass(viewModel: PostClassCollectionViewCellViewModel)
    case subject(viewModel: PostSubjectCollectionViewCellViewModel)
}
