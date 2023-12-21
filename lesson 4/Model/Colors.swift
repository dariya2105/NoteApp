//
//  Colors.swift
//  lesson 4
//
//  Created by Dariya on 20/12/23.
//

import Foundation
enum CustomColor: String {
    case customBlue
    case customYellow
    case lightPurple
    case azure
    case lightGreen 
    
    static let allColors: [CustomColor] = [.customBlue, .customYellow, .lightPurple, .azure, .lightGreen]

    static func random() -> CustomColor {
        return allColors.randomElement() ?? .customBlue
    }
}
