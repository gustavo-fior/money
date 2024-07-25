//
//  Item.swift
//  Money
//
//  Created by Gustavo Fior on 25/07/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
