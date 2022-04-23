//
//  Post.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import Foundation

struct Post: Codable {
    let id: String
    let title: String
    let author: String
    let isbn: String
    let schoolClass: String
    let subject: String
    let postURLString: String
    let postedDate: String
    
    var date: Date? {
            guard let date = DateFormatter.formatter.date(from: postedDate) else { fatalError() }
            return date
    }
    
    var storageReference: String? {
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            return nil
        }
        return "\(email)/posts/\(id).png"
    }
}
