//
//  DatabaseManager.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//
//
import FirebaseFirestore
import Foundation

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    //just made this function, not tested
    public func getAllUsers(for email: String, completion: @escaping ([String]) -> Void) {
        let ref = database.collection("users")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ $0.documentID }), error == nil else {
                completion([])
                return
            }
            completion(users)
        }
    }
    
    public func deletePost(for id: String, email: String, completion: @escaping (Bool) -> Void){
        let ref = database.collection("users").document(email).collection("posts").document(id).delete()
            
    }
    
    
    public func returnFN(for email: String, completion: @escaping (String) -> Void) {
        let ref = database.document("users/\(email)")
        ref.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            completion(data["firstName"] as? String ?? "")
        }
    }
    
    public func returnLN(for email: String, completion: @escaping (String) -> Void) {
        let ref = database.document("users/\(email)")
        ref.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            completion(data["lastName"] as? String ?? "")
        }
    }
    
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
    
    //not functioning
    //want to implement to be able to search posts by title at the very least
    public func findUserPosts(with titlePrefix: String, completion: @escaping ([User]) -> Void) {
        let ref = database.collection("users")
        
        
        
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ $0.documentID }), error == nil else {
                completion([])
                return
            }
            
            
            //allPosts should be collecting all of the posts available but it doesn't seem to be
            var allPosts: [(post: Post, owner: String, id: String)] = []
            
            for current in users {
                self.posts(for: current) { result in
                            switch result {
                            case .success(let posts):
                                allPosts.append(contentsOf: posts.compactMap({
                                    (post: $0, owner: current, id: $0.id)
                                }))
                                

                            case .failure:
                                break
                            }
                        }
                    }
            
            var subset: [String] = []
            
            for post in allPosts {
                if post.post.title.lowercased().hasPrefix(titlePrefix.lowercased()) {
                    subset.append(post.owner)
                }
            }
            
            var results: [User] = []
            
            for email in subset {
                self.findUser(with: email, completion: { user in
                    guard let user = user else {
                        return
                    }
                    results.append(user)
                })
            }
            
            completion(results)
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
     
     
    
    
    public func posts(
            for email: String,
            completion: @escaping (Result<[Post], Error>) -> Void
        ) {
            
            guard let email = email as String? else {
                return
            }
            
            let ref = database.collection("users/\(email)/posts")
            
            ref.getDocuments { snapshot, error in
                guard error == nil else {
                    //ref.setData(["": ""], merge: true)
                    return
                    }
                }
            
            ref.getDocuments { snapshot, error in
                guard let posts = snapshot?.documents.compactMap({
                    Post(with: $0.data())
                }).sorted(by: {
                    return $0.date! > $1.date!
                }),
                error == nil else {
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
    
        
        let ref = database.document("users/\(email)/information/basic")
        let userRef = database.collection("users").document(email)
        
        ref.getDocument { snapshot, error in
            guard let data = snapshot?.data(), let userInfo = UserInfo(with: data) else {
                ref.setData(["phone": ""], merge: true)
                return
                }
            }
            
        
        
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
        
        let ref = database.document("users/\(email)/information/basic")
        let userRef = database.collection("users").document(email)
        
        ref.setData(data) { error in
            completion(error == nil)
        }
        
        userRef.setData(userData) { error in
            completion(error == nil)
        }
    }
}
