//
//  Array+Extensions.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import Foundation

extension Array {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
