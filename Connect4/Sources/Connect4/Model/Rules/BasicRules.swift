//
// Created by etudiant on 31/01/2023.
//

import Foundation
public struct BasicRules : Rules {
    public var columnsMax: Int = 7
    public var columnsMin: Int = 1

    public var rowsMax: Int = 6
    public var rowsMin: Int = 1

    public var baseRows: Int = 6
    public var baseColumns: Int = 7

    public var nbPiecesToWin: Int = 4


    public func createBoard() -> Board {
        Board(nbRows: rowsMax, nbColumns: columnsMax)!
    }

    public func isValideMove(withBoard board: Board, andColumn column: Int) -> Bool {
        if board.isFull() {
            print("Le plateau est plein")
            return false
        }
        if column < 0 || column >= baseColumns {
            print("Entrer une colonne entre \(columnsMin) et \(columnsMax)")
            return false
        }
        if board.grid[0][column] != nil {
            print("La colonne est pleine")
            return false
        }
        return true
    }

    public func isEnd(withBoard board: Board, andPlayer1 player1: Player, andPlayer2 player2: Player?) -> (end: EndType, winner: Player?) {
        if board.isFull() && !isWinn(withGrid: board.grid, andPlayer1: player1, andPlayer2: player2, andNbPiecesToWin: nbPiecesToWin){
            return (EndType.EndWithoutWin, nil)
        }
        if checkWin(withGrid: board.grid, andSymbol: player1.id, andNbPiecesToWin: nbPiecesToWin) {
             return (EndType.EndWithWin, player1)
        }
        if checkWin(withGrid: board.grid, andSymbol: player2?.id ?? 2, andNbPiecesToWin: nbPiecesToWin) {
            return (EndType.EndWithWin, player2)
        }
        return (EndType.NotEnd, nil)
    }

    private func isWinn(withGrid grid: [[Int?]], andPlayer1 player1: Player, andPlayer2 player2: Player?, andNbPiecesToWin nbPiecesToWin: Int) -> Bool {
        if checkWin(withGrid: grid, andSymbol: player1.id, andNbPiecesToWin: nbPiecesToWin) || checkWin(withGrid: grid, andSymbol: player2?.id, andNbPiecesToWin: nbPiecesToWin) {
            return true
        }
        return false
    }

    private func checkWin(withGrid grid: [[Int?]], andSymbol symbol: Int?, andNbPiecesToWin nbPiecesToWin: Int) -> Bool {
        if symbol == nil {return false}

        // Verify the rows
        for row in grid {
            var count = 0
            for item in row {
                if item == symbol {
                    count += 1
                    if count == nbPiecesToWin {
                        return true
                    }
                } else {
                    count = 0
                }
            }
        }

        // Verify the columns
        for col in 0..<grid[0].count {
            var count = 0
            var column = [Int?]()
            for row in grid {
                column.append(row[col])
            }
            for item in column {
                if item == symbol {
                    count += 1
                    if count == nbPiecesToWin {
                        return true
                    }
                } else {
                    count = 0
                }
            }
        }

        // Verify the diagonals
        var diagonal1 = [Int?]()
        var diagonal2 = [Int?]()
        for i in 0..<grid.count {
            diagonal1.append(grid[i][i])
            diagonal2.append(grid[i][grid.count - 1 - i])
        }
        var count = 0
        for item in diagonal1 {
            if item == symbol {
                count += 1
                if count == nbPiecesToWin {
                    return true
                }
            } else {
                count = 0
            }
        }
        count = 0
        for item in diagonal2 {
            if item == symbol {
                count += 1
                if count == nbPiecesToWin {
                    return true
                }
            } else {
                count = 0
            }
        }

        return false
    }
}
