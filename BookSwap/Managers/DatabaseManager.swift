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
    
    public func findUsers(with firstNamePrefix: String, completion: @escaping ([User]) -> Void) {
        let ref = database.collection("users")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }), error == nil else {
                completion([])
                return
            }
            
            let subset = users.filter({
                $0.firstName.lowercased().hasPrefix(firstNamePrefix.lowercased())
            })
            
            completion(subset)
        }
    }
    
    /*public func findUserPosts(with titlePrefix: String, completion: @escaping ([User]) -> Void) {
        let ref = database.collection("users")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }), error == nil else {
                completion([])
                return
            }
            
            let subset = users.filter({
                $0.title.lowercased().hasPrefix(titlePrefix.lowercased())
            })
            
            completion(subset)
        }
    }
     
     public func getPost(
             with identifer: String,
             from username: String,
             completion: @escaping (Post?) -> Void
         ) {
             let ref = database.collection("users")
                 .document(username)
                 .collection("posts")
                 .document(identifer)
             ref.getDocument { snapshot, error in
                 guard let data = snapshot?.data(),
                       error == nil else {
                     completion(nil)
                     return
                 }

                 completion(Post(with: data))
             }
         }
     
     */
    
    public func posts(for email: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        let ref = database.collection("users").document(email).collection("posts")
        
        ref.getDocuments { snapshot, error in
            guard let posts = snapshot?.documents.compactMap({
                Post(with: $0.data())
            }), error == nil else {
                return
            }
            
            completion(.success(posts))
        }
    }
    
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
    
    public func createPost(newPost: Post, completion: @escaping (Bool) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            completion(false)
            return
        }
        let reference = database.document("users/\(email)/posts/\(newPost.id)")
        guard let data = newPost.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
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
    
    public func getUserInfo(email: String, completion: @escaping (UserInfo?, User?) -> Void) {
        let ref = database.collection("users").document(email).collection("information").document("basic")
        let userRef = database.collection("users").document(email)
        
        ref.getDocument { snapshot, error in
            guard let data = snapshot?.data(), let userInfo = UserInfo(with: data) else {
                completion(nil, nil)
                return
            }
            
            userRef.getDocument { snapshot2, error2 in
                guard let userData = snapshot2?.data(),
                        let user = User(with: userData) else {
                        completion(userInfo, nil)
                        return
                    }
                
                    completion(userInfo, user)
                }
        }
        
    }
    
    public func setUserInfo(userInfo: UserInfo, user: User, completion: @escaping (Bool) -> Void) {
        let email = user.email
        guard let data = userInfo.asDictionary(), let userData = user.asDictionary() else {
            return
        }
        
        let ref = database.collection("users").document(email).collection("information").document("basic")
        let userRef = database.collection("users").document(email)
        
        ref.setData(data) { error in
            completion(error == nil)
        }
        
        userRef.setData(userData) { error in
            completion(error == nil)
        }
    }
    
    
}
