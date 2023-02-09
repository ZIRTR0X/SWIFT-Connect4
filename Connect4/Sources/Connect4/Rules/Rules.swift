//
// Created by etudiant on 31/01/2023.
//

import Foundation

public protocol Rules {

    var columnsMax: Int { get }
    var columnsMin: Int { get }

    var rowsMax: Int { get }
    var rowsMin: Int { get }

    var baseRows: Int { get }
    var baseColumns: Int { get }

    var nbPiecesToWin: Int { get }

    func isEnd(withBoard board: Board, andPlayer1 player1: Player, andPlayer2 player2: Player) -> (end: EndType, winner: Player?)

    func createBoard() -> Board
    
    func isValideMove(withBoard board: Board, andColumn column: Int) -> Bool
}
