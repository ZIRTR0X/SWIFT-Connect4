//
//  main.swift
//  Connect4Cmd
//
//  Created by etudiant on 17/01/2023.
//

import Foundation
import Connect4

print("Hello, World!")

var board: Board = Board(nbRows: 6, nbColumns: 7 )
board.insertPiece(id: 1, columns: 1)
board.insertPiece(id: 1, columns: 2)
board.insertPiece(id: 2, columns: 0)
board.insertPiece(id: 1, columns: 1)
print(board)
