//
//  StorageManager.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import FirebaseStorage
import Foundation

final class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    public func uploadPost(data: Data?, id: String, completion: @escaping (Bool) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: "email"), let data = data else {
            return
        }
        storage.child("\(email)/posts/\(id).png").putData(data, metadata: nil) { _, error in
            completion(error == nil)
        }
    }
}
