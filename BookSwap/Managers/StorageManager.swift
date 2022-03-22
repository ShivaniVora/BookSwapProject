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
    
    public func uploadPost(data: Data?, id: String, completion: @escaping (URL?) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: "email"), let data = data else {
            return
        }
        let ref = storage.child("\(email)/posts/\(id).png")
        ref.putData(data, metadata: nil) { _, error in
            ref.downloadURL { url, _ in
                completion(url)
            }
        }
    }
    
    public func downloadURL(for post: Post, completion: @escaping (URL?) -> Void) {
        guard let ref = post.storageReference else {
            completion(nil)
            return
        }
        
        storage.child(ref).downloadURL { url, _ in
            completion(url)
        }
    }
}
