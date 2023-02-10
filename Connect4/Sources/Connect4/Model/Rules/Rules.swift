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

    /**
     * Check if the game is end
     * - Parameters:
     *   - board: the board of the game
        *   - player1: the first player
        *   - player2: the second player
        * - Returns: the end type and the winner
     */
    func isEnd(withBoard board: Board, andPlayer1 player1: Player, andPlayer2 player2: Player?) -> (end: EndType, winner: Player?)

    /**
     * Create a board with the rules
     * @return the board
     */
    func createBoard() -> Board

    /**
     * Check if the move is valide
     * @param board - the board of the game
     * @param column - the column of the move
     * @return true if the move is valide
     */
    func isValideMove(withBoard board: Board, andColumn column: Int) -> Bool
}
