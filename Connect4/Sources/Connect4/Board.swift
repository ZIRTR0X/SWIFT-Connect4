import Foundation

/// The board of the game
public struct Board : CustomStringConvertible
{
    public let nbRows: Int
    public let nbColumns: Int
    public var grid: [[Int?]]

    /// Convert numerical values from the grid to characters
    /// - Returns: The grid as a string
    /// - Note:
    ///  - 1: X
    ///  - 2: O
    ///  - nil: -
    private static let descriptionMappping: [Int?: String] = [
        nil: "-",
        1: "X",
        2: "O"
    ]

    /// Displays the status of the grid as a string
    public var description: String {
        var string = String()

        for row in 0..<nbRows {
            for column in 0..<nbColumns {
                string.append("\(String(describing: Board.descriptionMappping[grid[row][column]] ??  "-" )) ")
            }
            string.append("\n")
        }
        return string
    }

    /// Init a board with a number of rows and columns
    /// - Parameters:
    ///   - nbRows: The number of rows
    ///   - nbColumns: The number of columns
    public init?(nbRows: Int, nbColumns: Int) {
        guard nbRows > 0 && nbColumns > 0 else {
            print("Error : The number of rows and columns must be greater than 0")
            return nil
        }
        grid = Array(repeating: Array(repeating: nil, count: nbColumns), count: nbRows)
        self.nbColumns = nbColumns
        self.nbRows = nbRows
    }

    /// Init a board with a grid
    /// - Parameters :
    ///  - grid: The grid
    public init?(grid: [[Int?]]) {
        guard grid.count > 0 && grid[0].count > 0 else {return nil}
        for row in grid {
            guard row.count == grid[0].count else {return nil}
        }
        for row in grid {
            for column in row {
                guard column == nil || column == 1 || column == 2 else {return nil}
            }
        }
        self.grid = grid
        nbColumns = grid[0].count
        nbRows = grid.count
    }

    /// Insert a piece in the board (with gravity)
    /// - Parameters:
    ///   - id: The id of the piece (1:X or 2:O)
    ///   - columns: The column where the piece will be inserted
    /// - Returns: True if the piece is inserted, false otherwise
    public mutating func insertPiece(id: Int, columns: Int) -> Bool {
        var rows = 0
        
        do {
            try checkInsertPiece(id: id, gravity: true,  columns: columns, rows: rows)
        } catch let error as OutOfRangeError where error.message != "Error : " {
            print(error.message)
            return false
        } catch {
            print("An unknown error occurred")
            return false
        }
        for i in 0..<nbRows {
            if grid[i][columns] == nil {
                rows = i
            }
        }

        if(!insertPiece(id: id, columns: columns, rows: rows)) {
            return false
        }
        return true
    }
    
    /// Insert a piece in the board (without gravity)
    /// - Parameters:
    ///   - id: The id of the piece (1:X or 2:O)
    ///   - columns: The column where the piece will be inserted
    ///   - rows: THe row where the piece will be inserted
    /// - Returns: True if the piece is inserted, false otherwise
    private mutating func insertPiece(id: Int, columns: Int, rows: Int) -> Bool {
        do {
            try checkInsertPiece(id: id, gravity: false, columns: columns, rows: rows)
        } catch let error as OutOfRangeError where error.message != "Error : " {
            print(error.message)
            return false
        } catch {
            print("An unknown error occurred")
            return false
        }

        grid[rows][columns] = id
        return true
    }

    /// Check if the piece can be inserted in the board (with gravity)
    /// - Parameters:
    ///   - column: The column where the piece will be inserted
    ///   - row: The row where the piece will be inserted
    /// - Returns: True if the piece can be inserted, false otherwise
    public mutating func removePiece(row: Int, column: Int) -> Bool {
        do {
            try checkRemovePiece(row: row, column: column)
        } catch let error as OutOfRangeError where error.message != "Error : " {
            print(error.message)
            return false
        } catch {
            print("An unknown error occurred")
            return false
        }

        grid[row][column] = nil
        movesPartsAfterDelete(row: row, column: column)
        return true
    }

    /// Check if the piece can be inserted in the board (without gravity)
    /// - Parameters:
    ///   - column: The column where the piece will be inserted
    ///   - row: The row where the piece will be inserted
    private mutating func movesPartsAfterDelete(row: Int, column: Int) {
        for i in (0...row).reversed() {
            if i - 1 >= 0 && grid[i - 1][column] != nil {
                grid[i][column] = grid[i - 1][column]
            } else {
                grid[i][column] = nil
            }
        }
    }

    /// Check if the piece can be inserted in the board (without gravity)
    /// - Parameters:
    ///   - column: The column where the piece will be inserted
    ///   - row: The row where the piece will be inserted
    /// - Returns: True if the piece can be inserted, false otherwise
    private mutating func removePieceWithoutGravity(column: Int, row: Int) -> Bool {
        do {
            try checkRemovePiece(row: row, column: column)
        } catch let error as OutOfRangeError where error.message != "Error : " {
            print(error.message)
            return false
        } catch {
            print("An unknown error occurred")
            return false
        }

        grid[row][column] = nil
        return true
    }

    /// Check if the piece can be inserted in the board
    /// - Parameters:
    ///   - id: The id of the piece (1:X or 2:O)
    ///   - gravity: True if the piece is inserted with gravity, false otherwise
    ///   - columns: The column where the piece will be inserted
    ///   - rows: The row where the piece will be inserted
    /// - Throws: OutOfRangeError if the piece can't be inserted
    private func checkInsertPiece(id: Int, gravity: Bool, columns: Int, rows: Int?) throws {
        if columns < 0 || columns > nbColumns {
            throw OutOfRangeError("The column is out of range [0,\(nbRows)].")
        }
        if rows ?? 0 < 0 || rows ?? 0 > nbRows {
            throw OutOfRangeError("The row is out of range [0,\(nbRows)].")
        }
        if id != 1 && id != 2 {
            throw OutOfRangeError("The id is out of range [1,2].")
        }
        if grid.allSatisfy({ $0.allSatisfy({ $0 != nil }) }) {
            throw OutOfRangeError("The grid is full.")
        }
        if gravity {
            if grid[0][columns] != nil {
                throw OutOfRangeError("The column is full.")
            }
        } else {
            if grid[rows!][columns] != nil {
                throw OutOfRangeError("The place is already taken.")
            }
        }
    }

    /// Check if the piece can be removed in the board
    /// - Parameters:
    ///   - column: The column where the piece will be removed
    ///   - row: The row where the piece will be removed
    /// - Throws: OutOfRangeError if the piece can't be removed
    private func checkRemovePiece(row: Int, column: Int) throws {
        if column < 0 || column > nbColumns - 1{
            throw OutOfRangeError("The column is out of range [0,\(nbRows)].")
        }
        if row < 0 || row > nbRows - 1 {
            throw OutOfRangeError("The row is out of range [0,\(nbRows)].")
        }
        if grid[row][column] == nil {
            throw OutOfRangeError("The place is empty.")
        }
    }

    /// Check if the grid is full
    /// - Returns: True if the grid is full, false otherwise
    public func isFull() -> Bool {
        grid.allSatisfy({ $0.allSatisfy({ $0 != nil }) })
    }
    
}
