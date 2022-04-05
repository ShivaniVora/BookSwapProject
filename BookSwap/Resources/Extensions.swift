//
//  Extensions.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import Foundation
import UIKit

extension UIView {
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        frame.origin.y+height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        frame.origin.x+width
    }
    
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
}

extension Decodable {
    init?(with dictionary: [String: Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
            return nil
        }
        guard let result = try? JSONDecoder().decode(Self.self, from: data) else {
            return nil
        }
        self = result
    }
    
    /*func fromDictionary(with dictionary: [String: Any]) -> AnyObject {
        guard let json = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) as? [String: Any]
        
        guard let data = try? JSONDecoder().decode(Self.self, from: json) else {
            return nil
        }
        
        return json
    }*/
}

extension Encodable {
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return json
    }
    
}
