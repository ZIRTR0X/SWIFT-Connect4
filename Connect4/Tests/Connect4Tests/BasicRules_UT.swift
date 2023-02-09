import Foundation
import XCTest
@testable import Connect4

final class BasicRules_UT: XCTestCase {

    func testIsEnd() throws {

        //isEnd(withBoard board: Board, andPlayer1 player1: Player, andPlayer2 player2: Player) -> (isEnd: Bool, winner: Player?, isWin: Bool)

        func expect(withBoard board: Board, andPlayer1 player1: Player, andPlayer2 player2: Player, andEnd end: EndType, andWinner winner: Player?) {
            let endResult: EndType
            let winnerResult: Player?

            (endResult, winnerResult) = BasicRules().isEnd(withBoard: board, andPlayer1: player1, andPlayer2: player2)

            XCTAssertEqual(end, endResult)
            XCTAssertEqual(winner, winnerResult)
        }
        let board = Board(nbRows: 6, nbColumns: 7)
        let menu = MenuDisplay()
        let player1 = Human(withName: "Player 1", andId: 1, andMenu: menu)
        let player2 = Human(withName: "Player 2", andId: 2, andMenu: menu)
        //bard vide sans gagnant
        expect(withBoard: board!, andPlayer1: player1!, andPlayer2: player2!, andEnd: EndType.NotEnd, andWinner: nil)

        //board rempli sans gagnant
        let grid1 = [
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 2, 1, 2, 2, 1],
            [2, 1, 2, 2, 1, 2, 1],
            [1, 2, 1, 2, 2, 1, 2],
            [2, 1, 2, 1, 2, 1, 2]]
        let board1 = Board(grid: grid1)
        expect(withBoard: board1!, andPlayer1: player1!, andPlayer2: player2!, andEnd: EndType.EndWithoutWin, andWinner: nil)

        //board rempli avec gagnant
        let grid2 = [
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2]]
        let board2 = Board(grid: grid2)
        expect(withBoard: board2!, andPlayer1: player1!, andPlayer2: player2!, andEnd: EndType.EndWithWin, andWinner: player1!)

        //board non rempli avec gagnant colonne
        let grid3 = [
            [1, 2, 2, nil, nil, 2, nil],
            [1, 2, 2, nil, 2, 1, nil],
            [1, 2, 1, nil, 1, 1, nil],
            [1, 1, 2, nil, 2, 1, nil],
            [1, 2, 2, 1, 2, 2, 1],
            [2, 1, 2, 1, 2, 1, 2]]
        let board3 = Board(grid: grid3)
        expect(withBoard: board3!, andPlayer1: player1!, andPlayer2: player2!, andEnd: EndType.EndWithWin, andWinner: player1!)

        //board non rempli avec gagnant ligne
        let grid4 = [
            [1, 2, 2, nil, nil, 2, nil],
            [1, 2, 2, nil, 2, 1, nil],
            [2, 1, 1, nil, 1, 1, nil],
            [1, 1, 2, nil, 2, 1, nil],
            [1, 2, 2, 2, 2, 2, 1],
            [2, 1, 2, 1, 2, 1, 2]]
        let board4 = Board(grid: grid4)
        expect(withBoard: board4!, andPlayer1: player1!, andPlayer2: player2!, andEnd: EndType.EndWithWin, andWinner: player2!)

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
        expect(withBoard: board5!, andPlayer1: player1!, andPlayer2: player2!, andEnd: EndType.EndWithWin, andWinner: player1!)

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
        expect(withBoard: board6!, andPlayer1: player1!, andPlayer2: player2!, andEnd: EndType.EndWithWin, andWinner: player1!)

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
        expect(withBoard: board7!, andPlayer1: player1!, andPlayer2: player2!, andEnd: EndType.EndWithWin, andWinner: player1!)

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
        expect(withBoard: board8!, andPlayer1: player1!, andPlayer2: player2!, andEnd: EndType.EndWithWin, andWinner: player2!)
    }

    func testCreateboard(){
        let rules = BasicRules()
        let board = rules.createBoard()
        XCTAssertEqual(board.grid.count, 6)
        XCTAssertEqual(board.grid[0].count, 7)

        for i in 0..<board.grid.count{
            for j in 0..<board.grid[i].count{
                XCTAssertNil(board.grid[i][j])
            }
        }
    }

    func testIsValideMove(){

        func expect(withBoard board: Board, andColumn column: Int, andIsValide isValide: Bool){
            let rules = BasicRules()
            let result = rules.isValideMove(withBoard: board, andColumn: column)
            if !isValide {
                XCTAssertFalse(result)
                return
            }
            XCTAssertTrue(result)
        }

        //board full
        let grid1 = [
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2]]
        let board1 = Board(grid: grid1)
        expect(withBoard: board1!, andColumn: 0, andIsValide: false)

        //good move
        let grid2 = [
            [nil, 2, 1, 2, 1, 2, 1],
            [nil, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [1, 1, 2, 1, 2, 1, 2]]
        let board2 = Board(grid: grid2)
        expect(withBoard: board2!, andColumn: 0, andIsValide: true)

        //in out of range column -1
        let grid3 = [
            [nil, nil, nil, 2, 1, 2, 1],
            [nil, 1, 2, 1, 2, 1, 2],
            [nil, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [1, 1, 2, 1, 2, 1, 2]]
        let board3 = Board(grid: grid3)
        expect(withBoard: board3!, andColumn: -1, andIsValide: false)

        //in out of range column 7
        let grid4 = [
            [nil, nil, nil, 2, 1, 2, 1],
            [nil, 1, 2, 1, 2, 1, 2],
            [nil, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [1, 1, 2, 1, 2, 1, 2]]
        let board4 = Board(grid: grid4)
        expect(withBoard: board4!, andColumn: 7, andIsValide: false)

        //in out of row column -1
        let grid5 = [
            [nil, nil, nil, 2, 1, 2, 1],
            [nil, 1, 2, 1, 2, 1, 2],
            [nil, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [1, 1, 2, 1, 2, 1, 2]]
        let board5 = Board(grid: grid5)
        expect(withBoard: board5!, andColumn: 0, andIsValide: true)

        //in out of row column 7
        let grid6 = [
            [nil, nil, nil, 2, 1, 2, 1],
            [nil, 1, 2, 1, 2, 1, 2],
            [nil, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [1, 1, 2, 1, 2, 1, 2]]
        let board6 = Board(grid: grid6)
        expect(withBoard: board6!, andColumn: 0, andIsValide: true)

        //in full column
        let grid7 = [
            [nil, nil, nil, 2, 1, 2, 1],
            [nil, 1, 2, 1, 2, 1, 2],
            [nil, 2, 1, 2, 1, 2, 1],
            [2, 1, 2, 1, 2, 1, 2],
            [1, 2, 1, 2, 1, 2, 1],
            [1, 1, 2, 1, 2, 1, 2]]
        let board7 = Board(grid: grid7)
        expect(withBoard: board7!, andColumn: 3, andIsValide: false)

    }
}
