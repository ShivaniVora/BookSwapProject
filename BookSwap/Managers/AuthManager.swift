//
//  AuthManager.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import FirebaseAuth
import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    let auth = Auth.auth()
    
    enum AuthError: Error {
        case newUserCreation
        case signInFailed
    }
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    public func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        DatabaseManager.shared.findUser(with: email) { [weak self] user in
            guard let user = user else {
                completion(.failure(AuthError.signInFailed))
                return
            }
            
            self?.auth.signIn(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    completion(.failure(AuthError.signInFailed))
                    return
                }
                
                UserDefaults.standard.setValue(user.email, forKey: "email")
                UserDefaults.standard.setValue(user.firstName, forKey: "firstName")
                UserDefaults.standard.setValue(user.lastName, forKey: "lastName")
                completion(.success(user))
                
            }
        }
    }
    
    public func signUp(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        let newUser = User(firstName: firstName, lastName: lastName, email: email)
                           
        auth.createUser(withEmail: email, password: password) { (result, error) in
            guard result != nil, error == nil else {
                completion(.failure(AuthError.newUserCreation))
                return
            }
            
            DatabaseManager.shared.createUser(newUser: newUser) { success in
                if success {
                    completion(.success(newUser))
                }
                else {
                    completion(.failure(AuthError.newUserCreation))
                }
            }
            
        }
        
    }
    
    public func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try auth.signOut()
            completion(true)
        }
        catch {
            print(error)
            completion(false)
        }
    }
}
