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
    
    let storage = Storage.storage()
}
