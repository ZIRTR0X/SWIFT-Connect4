//
//  File.swift
//  
//
//  Created by etudiant on 26/01/2023.
//

import Foundation

public class IA: Player {
    public func random() -> Bool {
        
        var randomValue = Int.random(in: 0..<board.nbColumns)
        
        
        return false
    }
    
    public override func playInColumn(withColumn column: Int) -> Bool {
        return false
    }
}
