//
//  User.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import Foundation

class User: Codable {
    var firstName: String
    var lastName: String
    var email: String
    
    init(firstName: String, lastName: String, email: String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
