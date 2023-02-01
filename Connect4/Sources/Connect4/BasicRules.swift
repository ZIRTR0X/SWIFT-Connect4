//
// Created by etudiant on 31/01/2023.
//

import Foundation
public struct BasicRules : Rules {
    public var columnsMax: Int = 7
    public var columnsMin: Int = 1

    public var rowsMax: Int = 6
    public var rowsMin: Int = 1

    public var nbPiecesToWin: Int = 4

    public func isEnd(withBoard board: Board, andPlayer1 player1: Player, andPlayer2 player2: Player) -> (isEnd: Bool, winner: Player?, isWin: Bool) {
        if board.isFull() && !isWinn(withGrid: board.grid, andPlayer1: player1, andPlayer2: player2, andNbPiecesToWin: nbPiecesToWin){
            return (true, nil, false)
        }
        if checkWin(withGrid: board.grid, andSymbol: player1.id, andNbPiecesToWin: nbPiecesToWin) {
             return (true, player1, true)
        }
        if checkWin(withGrid: board.grid, andSymbol: player2.id, andNbPiecesToWin: nbPiecesToWin) {
            return (true, player2, true)
        }
        return (false, nil, false)
    }

    private func isWinn(withGrid grid: [[Int?]], andPlayer1 player1: Player, andPlayer2 player2: Player, andNbPiecesToWin nbPiecesToWin: Int) -> Bool {
        if checkWin(withGrid: grid, andSymbol: player1.id, andNbPiecesToWin: nbPiecesToWin) || checkWin(withGrid: grid, andSymbol: player2.id, andNbPiecesToWin: nbPiecesToWin) {
            return true
        }
        return false
    }

    private func checkWin(withGrid grid: [[Int?]], andSymbol symbol: Int, andNbPiecesToWin nbPiecesToWin: Int) -> Bool {
        // Vérifie les lignes
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

        // Vérifie les colonnes
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

        // Vérifie les diagonales
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