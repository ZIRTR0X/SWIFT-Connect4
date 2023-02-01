import Foundation
import XCTest
@testable import Connect4

final class BasicRules_UT: XCTestCase {

    func testIsEnd() throws {

        //isEnd(withBoard board: Board, andPlayer1 player1: Player, andPlayer2 player2: Player) -> (isEnd: Bool, winner: Player?, isWin: Bool)

        func expect(withBoard board: Board, andPlayer1 player1: Player, andPlayer2 player2: Player, andIsEnd isEnd: Bool, andWinner winner: Player?, andIsWin isWin: Bool) {
            let isEndResult: Bool
            let winnerResult: Player?
            let isWinResult: Bool

            (isEndResult, winnerResult, isWinResult) = BasicRules().isEnd(withBoard: board, andPlayer1: player1, andPlayer2: player2)

            XCTAssertEqual(isEnd, isEndResult)
            XCTAssertEqual(winner, winnerResult)
            XCTAssertEqual(isWin, isWinResult)
        }
        let board = Board(nbRows: 6, nbColumns: 7)
        let player1 = Human(withName: "Player 1", andId: 1, andBoard: board!)
        let player2 = Human(withName: "Player 2", andId: 2, andBoard: board!)
        //bard vide sans gagnant
        expect(withBoard: board!, andPlayer1: player1!, andPlayer2: player2!, andIsEnd: false, andWinner: nil, andIsWin: false)

        //board rempli sans gagnant
        let grid1 = [
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 2, 1, 2, 2, 1],
            [2, 1, 2, 2, 1, 2, 1],
            [1, 2, 1, 2, 2, 1, 2],
            [2, 1, 2, 1, 2, 1, 2]]
        let board1 = Board(grid: grid1)
        expect(withBoard: board1!, andPlayer1: player1!, andPlayer2: player2!, andIsEnd: true, andWinner: nil, andIsWin: false)

        //board rempli avec gagnant
        let grid2 = [
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2]]
        let board2 = Board(grid: grid2)
        expect(withBoard: board2!, andPlayer1: player1!, andPlayer2: player2!, andIsEnd: true, andWinner: player1!, andIsWin: true)

        //board non rempli avec gagnant colonne
        let grid3 = [
            [1, 2, 2, nil, nil, 2, nil],
            [1, 2, 2, nil, 2, 1, nil],
            [1, 2, 1, nil, 1, 1, nil],
            [1, 1, 2, nil, 2, 1, nil],
            [1, 2, 2, 1, 2, 2, 1],
            [2, 1, 2, 1, 2, 1, 2]]
        let board3 = Board(grid: grid3)
        expect(withBoard: board3!, andPlayer1: player1!, andPlayer2: player2!, andIsEnd: true, andWinner: player1!, andIsWin: true)

        //board non rempli avec gagnant ligne
        let grid4 = [
            [1, 2, 2, nil, nil, 2, nil],
            [1, 2, 2, nil, 2, 1, nil],
            [2, 1, 1, nil, 1, 1, nil],
            [1, 1, 2, nil, 2, 1, nil],
            [1, 2, 2, 2, 2, 2, 1],
            [2, 1, 2, 1, 2, 1, 2]]
        let board4 = Board(grid: grid4)
        expect(withBoard: board4!, andPlayer1: player1!, andPlayer2: player2!, andIsEnd: true, andWinner: player2!, andIsWin: true)

        //board non rempli avec gagnant diagonale
        let grid5 = [
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, 1, nil, nil, nil, nil],
            [nil, nil, 2, 1, nil, nil, nil],
            [nil, nil, 2, 2, 1, nil, nil],
            [nil, nil, 1, 2, 2, 1, nil]
        ]
        let board5 = Board(grid: grid5)
        expect(withBoard: board5!, andPlayer1: player1!, andPlayer2: player2!, andIsEnd: true, andWinner: player1!, andIsWin: true)

        //board rempli avec gagnant colonne
        let grid6 = [
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 1]
        ]
        let board6 = Board(grid: grid6)
        expect(withBoard: board6!, andPlayer1: player1!, andPlayer2: player2!, andIsEnd: true, andWinner: player1!, andIsWin: true)

        //board rempli avec gagnant ligne
        let grid7 = [
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [1, 1, 1, 1, 1, 2, 2]
        ]
        let board7 = Board(grid: grid7)
        expect(withBoard: board7!, andPlayer1: player1!, andPlayer2: player2!, andIsEnd: true, andWinner: player1!, andIsWin: true)

        //board rempli avec gagnant diagonale
        let grid8 = [
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 2, 1, 2, 2],
            [1, 2, 1, 1, 2, 1, 2],
            [2, 1, 2, 2, 1, 1, 1]
        ]
        let board8 = Board(grid: grid8)
        expect(withBoard: board8!, andPlayer1: player1!, andPlayer2: player2!, andIsEnd: true, andWinner: player2!, andIsWin: true)
    }
}
