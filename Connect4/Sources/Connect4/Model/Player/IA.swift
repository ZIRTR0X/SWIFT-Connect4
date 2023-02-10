//
//  File.swift
//  
//
//  Created by etudiant on 26/01/2023.
//

import Foundation

public class IA: Player {

    /// Play a random move
    /// - Parameters:
    ///   - board: the board
    ///   - rules: the rules
    /// - Returns:
    ///  - Board: the new board with the move
    public func random(withBoard board: Board, andRules rules : Rules) -> Board {
        if(board.isFull()) {return board}
        var newBoard = board
        var randomValue = Int.random(in: 0..<newBoard.nbColumns)
        while !rules.isValideMove(withBoard: newBoard, andColumn: randomValue) {
            randomValue = Int.random(in: 0..<newBoard.nbColumns)
        }
        newBoard.insertPiece(id: id, columns: randomValue)
        return newBoard;
    }
}
