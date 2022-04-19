//
//  SettingsModels.swift
//  BookSwap
//
//  Created by Shivani Vora on 4/18/22.
//

import Foundation
import UIKit

struct SettingsSection {
    let title: String
    let option: [SettingOption]
}

struct SettingOption {
    let title: String
    let image: UIImage?
    let color: UIColor
    let handler: (() -> Void)
}
