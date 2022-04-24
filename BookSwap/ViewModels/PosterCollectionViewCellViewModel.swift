//
//  PosterCollectionViewCellViewModel.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/20/22.
//

import Foundation

enum DeleteButtonUser {
    case edit
    case hidden
}

struct PosterCollectionViewCellViewModel {
    let firstName: String
    let lastName: String
    let deleteButton: DeleteButtonUser
}
