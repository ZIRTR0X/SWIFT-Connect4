import Foundation
import Connect4

print("Hello, World!")

var board: Board? = Board(nbRows: 6, nbColumns: 7 )
print(board?.insertPiece(id: 1, columns: 1))
print(board?.insertPiece(id: 2, columns: 1))
print(board?.insertPiece(id: 1, columns: 2))
print(board?.insertPiece(id: 2, columns: 0))
print(board?.insertPiece(id: 2, columns: 1))
print(board)
print(board?.removePiece(row: 5, column: 1))
print(board)
print(board?.isFull())

let grid = [
    [nil, nil, nil, nil, 1],
    [nil, nil, nil, 2, 2],
    [nil, nil, 1, 2, 2],
    [nil, 1, 2, 1, 2]]
var board2 = Board(grid: grid)
board2?.removePiece(row: 3, column: 4)
print(board2)


