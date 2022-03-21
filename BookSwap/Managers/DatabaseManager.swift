//
//  DatabaseManager.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import FirebaseFirestore
import Foundation

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    public func findUser(with email: String, completion: @escaping (User?) -> Void) {
        let ref = database.collection("users")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }), error == nil else {
                completion(nil)
                return
            }
            
            let user = users.first(where: { $0.email == email } )
            completion(user)
        }
    }
    
    public func createUser(newUser: User, completion: @escaping (Bool) -> Void) {
        let reference = database.document("users/\(newUser.email)")
        guard let data = newUser.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
    }
}
