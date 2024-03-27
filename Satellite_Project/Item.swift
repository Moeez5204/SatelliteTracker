//
//  Item.swift
//  Satellite_Project
//
//  Created by Abdul-Moeez Hameed on 16/12/2023.
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
