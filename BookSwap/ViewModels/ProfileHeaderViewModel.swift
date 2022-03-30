//
//  ProfileHeaderViewModel.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/29/22.
//

import Foundation

enum ProfileButtonType {
    case edit
    case hidden
}

struct ProfileHeaderViewModel {
    let name: String
    let email: String
    let phone: String
    let buttonType: ProfileButtonType
}
