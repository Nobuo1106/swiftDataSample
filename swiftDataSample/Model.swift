//
//  Model.swift
//  swiftDataSample
//
//  Created by 五十嵐伸雄 on 2023/12/01.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String

    init(name: String) {
        self.name = name
    }
}

enum Section {
    case users
}
