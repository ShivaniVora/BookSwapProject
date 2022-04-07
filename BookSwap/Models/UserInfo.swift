//
//  UserInfo.swift
//  BookSwap
//
//  Created by Shivani Vora on 4/2/22.
//

import Foundation

class UserInfo: Codable {
    var phone: String
    
    init(phone: String) {
        self.phone = phone
    }
}
