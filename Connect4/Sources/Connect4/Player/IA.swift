//
//  File.swift
//  
//
//  Created by etudiant on 26/01/2023.
//

import Foundation

public class IA: Player {
    public func random(withBoard board: Board, andRules rules : Rules) -> Board {
        var newBoard = board
        var randomValue = Int.random(in: 0..<newBoard.nbColumns)
        while !rules.isValideMove(withBoard: newBoard, andColumn: randomValue) {
            randomValue = Int.random(in: 0..<newBoard.nbColumns)
        }
        newBoard.insertPiece(id: id, columns: randomValue)
        return newBoard;
    }
}
