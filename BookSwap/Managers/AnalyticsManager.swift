//
//  AnalyticsManager.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import FirebaseAnalytics
import Foundation

final class AnalyticsManager {
    static let shared = AnalyticsManager()
    
    private init() {}
    
    func logEvent() {
        Analytics.logEvent("", parameters: [:])
    }
}
