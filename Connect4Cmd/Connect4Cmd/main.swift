import Foundation
import Connect4

print("Hello, World!")

var board: Board? = Board(nbRows: 6, nbColumns: 7 )
board?.insertPiece(id: 1, columns: 1)
board?.insertPiece(id: 2, columns: 1)
board?.insertPiece(id: 1, columns: 2)
board?.insertPiece(id: 2, columns: 0)
board?.insertPiece(id: 2, columns: 1)
print(board)
board?.removePiece(columns: 1, rows: 5)
print(board)
print(board?.isFull())
