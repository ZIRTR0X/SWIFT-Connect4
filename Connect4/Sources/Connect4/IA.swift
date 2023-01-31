//
//  File.swift
//  
//
//  Created by etudiant on 26/01/2023.
//

import Foundation

public class IA: Player {
    public func random() -> Bool {
        if board.isFull() {return false}
        var randomValue = Int.random(in: 0..<board.nbColumns)
        while !playInColumn(withColumn: randomValue) {
            randomValue = Int.random(in: 0..<board.nbColumns)
        }
        return true
    }
}
