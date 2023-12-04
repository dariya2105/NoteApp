//
//  Settings.swift
//  lesson 4
//
//  Created by Dariya on 6/12/23.
//

import Foundation
enum Types {
    case none
    case configure
}

struct Settings {
    var image: String
    var title: String
    var type: Types
}
