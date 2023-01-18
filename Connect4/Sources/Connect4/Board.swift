import Foundation

public struct Board
{
    private let nbRows: Int
    private let nbColumns: Int
    private var grid: [[Int?]]

    private static let descriptionMappping: [Int?: String] = [
        0: " ",
        1: "X",
        2: "O"
    ]

    public var description: String {
        var string = String()

        for row in 0..<nbRows {
            for column in 0..<nbColumns {
                string.append("\(grid[row][column] ?? 0) ")
            }
            string.append("\n")
        }
        return string
    }

    public init(nbRows: Int, nbColumns: Int) {
        grid = Array(repeating: Array(repeating: nil, count: nbColumns), count: nbRows)
        self.nbColumns = nbColumns
        self.nbRows = nbRows
    }

    public init?(grid: [[Int?]]) {
        guard grid.count > 0 && grid[0].count > 0 else {return nil}
        for row in grid {
            guard row.count == grid[0].count else {return nil}
        }
        self.grid = grid.map { row in
            row.map { value in
                Board.descriptionMappping[value ?? 0] as? Int
            }
        }
        nbColumns = grid[0].count
        nbRows = grid.count
    }
    
    // avec gravité
    public mutating func insertPiece(id: Int, columns: Int) -> Bool {

        var rows = nbRows
        
        do {
            try checkInsertPiece(id: id, gravity: true,  columns: columns, rows: rows)
        } catch let error as OutOfRangeError where error.message != "Error : " {
            print(error.message)
            return false
        } catch {
            print("An unknown error occurred")
            return false
        }
        
        if rows + 1 > nbRows && grid[columns][rows + 1] == nil {
            //descendre pièce à une ligne inférieur
            return self.insertPiece(id: id, columns: columns, rows: rows + 1)
        }
        
        grid[columns][rows] = Board.descriptionMappping[id]
        return true
    }
    
    // sans gravité
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

        grid[columns][rows] = id
        return true
    }

    public mutating func removePiece(columns: Int, rows: Int) -> Bool {
        do {
            try checkRemovePiece(columns: columns, rows: rows)
        } catch let error as OutOfRangeError where error.message != "Error : " {
            print(error.message)
            return false
        } catch {
            print("An unknown error occurred")
            return false
        }

        grid[columns][rows] = nil
        return true
    }

    private mutating func movesPartsAfterDelete(columns: Int, rows: Int) {
        for i in (0...rows).reversed() {
            if i - 1 > 0 && grid[columns][i - 1] != nil {
                grid[columns][i] = grid[columns][i - 1]
            } else {
                grid[columns][i] = nil
            }
        }
    }

    //whithout gravity
    private mutating func removePieceWithoutGravity(columns: Int, rows: Int) -> Bool {
        do {
            try checkRemovePiece(columns: columns, rows: rows)
        } catch let error as OutOfRangeError where error.message != "Error : " {
            print(error.message)
            return false
        } catch {
            print("An unknown error occurred")
            return false
        }

        grid[columns][rows] = nil
        return true
    }
    
    private func checkInsertPiece(id: Int, gravity: Bool, columns: Int, rows: Int?) throws {

        if gravity {
            if grid[columns].allSatisfy({ $0 != nil }) {
                throw OutOfRangeError("The column is full.")
            }
        } else {
            if grid[columns][rows!] != nil {
                throw OutOfRangeError("The place is already taken.")
            }
        }

        if columns < 0 || columns > nbColumns {
            throw OutOfRangeError("The column is out of range [0,\(nbRows)].")
        }
        
        if rows ?? 0 < 0 || rows ?? 0 > nbRows {
            throw OutOfRangeError("The line is out of range [0,\(nbRows)].")
        }
    
        if id != 1 && id != 2 {
            throw OutOfRangeError("The id is out of range [1,2].")
        }

        if grid.allSatisfy({ $0.allSatisfy({ $0 != nil }) }) {
            throw OutOfRangeError("The grid is full.")
        }
    }

    private func checkRemovePiece(columns: Int, rows: Int) throws {
        if columns < 0 || columns > nbColumns {
            throw OutOfRangeError("The column is out of range [0,\(nbRows)].")
        }

        if rows < 0 || rows > nbRows {
            throw OutOfRangeError("The line is out of range [0,\(nbRows)].")
        }

        if grid[columns][rows] == nil {
            throw OutOfRangeError("The place is empty.")
        }
    }

    public func isFull() -> Bool {
        grid.allSatisfy({ $0.allSatisfy({ $0 != nil }) })
    }

    public func showGrid() {
        for row in 0..<nbRows {
            for column in 0..<nbColumns {
                print("\(grid[row][column] ?? 0) ", terminator: "")
            }
            print("")
        }
    }
    
}
