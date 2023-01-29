import Foundation
import XCTest
@testable import Connect4

final class Board_UT: XCTestCase {


    func testInit() throws {

        func expect(iniBoardWithNbRows nbRows: Int, andNbColumns nbColumns: Int, shouldBeNotNil notNil: Bool) {
            let board = Board(nbRows : nbRows, nbColumns: nbColumns)
            if !notNil {
                XCTAssertNil(board)
                return
            }
            XCTAssertNotNil(board)
            XCTAssertEqual(nbRows, board?.nbRows)
            XCTAssertEqual(nbColumns, board?.nbColumns)
            XCTAssertEqual(nbRows, board?.grid.count)
            XCTAssertEqual(nbColumns, board?.grid[0].count)
            for i in 0..<nbRows {
                for j in 0..<nbColumns {
                    XCTAssertEqual(nil, board?.grid[i][j])
                }
            }
        }

        expect(iniBoardWithNbRows: 0, andNbColumns: 0, shouldBeNotNil: false)
        expect(iniBoardWithNbRows: 0, andNbColumns: 1, shouldBeNotNil: false)
        expect(iniBoardWithNbRows: 1, andNbColumns: 0, shouldBeNotNil: false)
        expect(iniBoardWithNbRows: 6, andNbColumns: -7, shouldBeNotNil: false)
        expect(iniBoardWithNbRows: -6, andNbColumns: 7, shouldBeNotNil: false)
        expect(iniBoardWithNbRows: 6, andNbColumns: 7, shouldBeNotNil: true)
    }

    func testInitWithGrid() throws {

        func expect(iniBoardWithGrid grid: [[Int?]], shouldBeNotNil notNil: Bool) {
            let board = Board(grid: grid)
            if !notNil {
                XCTAssertNil(board)
                return
            }
            XCTAssertNotNil(board)
            XCTAssertEqual(grid.count, board?.nbRows)
            XCTAssertEqual(grid[0].count, board?.nbColumns)
            XCTAssertEqual(grid.count, board?.grid.count)
            XCTAssertEqual(grid[0].count, board?.grid[0].count)

            for i in 0..<grid.count {
                XCTAssertEqual(grid[i].count, board?.grid[i].count)
            }

            for i in 0..<grid.count {
                for j in 0..<grid[i].count {
                    XCTAssertEqual(grid[i][j], board?.grid[i][j])
                }
            }
        }

        expect(iniBoardWithGrid: [], shouldBeNotNil: false)
        expect(iniBoardWithGrid: [[]], shouldBeNotNil: false)
        expect(iniBoardWithGrid: [[1]], shouldBeNotNil: true)
        let grid1: [[Int?]] = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
        expect(iniBoardWithGrid: grid1, shouldBeNotNil: true)
        let grid2: [[Int?]]  = [[nil, nil, nil], [nil, nil, nil], [nil, nil]]
        expect(iniBoardWithGrid: grid2, shouldBeNotNil: false)
        let grid3: [[Int?]]  = [[1, 1, nil], [nil, 1, 2], [2, 2, 2, 2]]
        expect(iniBoardWithGrid: grid3, shouldBeNotNil: false)
        let grid4: [[Int?]]  = [[1, 1, nil], [nil, 1, 2], [2, 2, 2]]
        expect(iniBoardWithGrid: grid4, shouldBeNotNil: true)
        let grid5: [[Int?]]  = [[1, 1, nil], [nil, 1, 2], [2, 2]]
        expect(iniBoardWithGrid: grid5, shouldBeNotNil: false)
        let grid6: [[Int?]]  = [[1, 1,], [nil, 1], [2, 2]]
        expect(iniBoardWithGrid: grid6, shouldBeNotNil: true)
        let grid7: [[Int?]]  = [[1, 1,], [nil, 1], [2, 6]]
        expect(iniBoardWithGrid: grid7, shouldBeNotNil: false)
    }

    func testInsertPiece() throws {

        func expect(insertPieceWithId id: Int, andColumn column: Int, shouldBeNotNil notNil: Bool) {
            let grid = [
                [nil, nil, nil, nil, 1],
                [nil, nil, nil, 2, 1],
                [nil, nil, 1, 2, 2],
                [nil, 1, 2, 1, 1]]
            var board = Board(grid: grid)
            let result = board?.insertPiece(id: id, columns: column)
            if !notNil {
                XCTAssertFalse(result!)
                return
            }

            XCTAssertTrue(result!)
            XCTAssertNotNil(result)
            switch column {
                case 0:
                    XCTAssertEqual(id, board?.grid[3][0])
                case 1:
                    XCTAssertEqual(id, board?.grid[2][1])
                case 2:
                    XCTAssertEqual(id, board?.grid[1][2])
                default:
                    XCTAssertEqual(id, board?.grid[0][3])
            }
        }

        expect(insertPieceWithId: 1, andColumn: 0, shouldBeNotNil: true)
        expect(insertPieceWithId: 1, andColumn: 1, shouldBeNotNil: true)
        expect(insertPieceWithId: 1, andColumn: 2, shouldBeNotNil: true)
        expect(insertPieceWithId: 1, andColumn: 3, shouldBeNotNil: true)
        expect(insertPieceWithId: 1, andColumn: 4, shouldBeNotNil: false)
        expect(insertPieceWithId: 1, andColumn: -1, shouldBeNotNil: false)
        expect(insertPieceWithId: 1, andColumn: 6, shouldBeNotNil: false)
        expect(insertPieceWithId: -1, andColumn: 1, shouldBeNotNil: false)
        expect(insertPieceWithId: 0, andColumn: 1, shouldBeNotNil: false)
        expect(insertPieceWithId: 3, andColumn: 1, shouldBeNotNil: false)
    }

    func testDeletePiece() throws {

        func expect(removePieceWithRow row: Int, andColumn column: Int, shouldBeNotNil notNil: Bool) {
            let grid = [
                [nil, nil, nil, nil, 1],
                [nil, nil, nil, 2, 2],
                [nil, nil, 1, 2, 2],
                [nil, 1, 2, 1, 2]]
            var board = Board(grid: grid)
            let result = board?.removePiece(row: row, column: column)
            if !notNil {
                XCTAssertFalse(result!)
                return
            }

            XCTAssertTrue(result!)
            XCTAssertNotNil(result)

            for i in 0...row {
                if i == 0 {
                    XCTAssertEqual(nil, board?.grid[i][column])
                } else {
                    XCTAssertEqual(grid[i-1][column] ?? nil, board?.grid[i][column])
                }
            }
        }

        expect(removePieceWithRow: 0, andColumn: 0, shouldBeNotNil: false)
        expect(removePieceWithRow: 3, andColumn: 1, shouldBeNotNil: true)
        expect(removePieceWithRow: 3, andColumn: 2, shouldBeNotNil: true)
        expect(removePieceWithRow: 2, andColumn: 3, shouldBeNotNil: true)
        expect(removePieceWithRow: 3, andColumn: 4, shouldBeNotNil: true)
        expect(removePieceWithRow: 4, andColumn: 4, shouldBeNotNil: false)
        expect(removePieceWithRow: -1, andColumn: 4, shouldBeNotNil: false)
        expect(removePieceWithRow: 3, andColumn: -1, shouldBeNotNil: false)
        expect(removePieceWithRow: 3, andColumn: 5, shouldBeNotNil: false)

    }
    
    /*func testIsFull() {
        
        func expect(isFullWithGrid grid: [[Int?]], andResult isWork: Bool, shouldBeNotNil notNil: Bool){
            var board = Board(grid: grid)
            var result = board?.isFull()
            if !notNil {
                XCTAssertFalse(result!)
                return
            }
            XCTAssert(result, isWork)
            XCTAssertNotNil(result)
            
        }
        
        let grid1 = [[nil, 1, 1], [1, 1, 1], [1, 1, 1]]
        expect(isFullWithGrid: grid1, andResult: false, shouldBeNotNil: true)
        
        let grid2 = [[1, 1, 1], [1, 1, 1], [1, 1, nil]]
        expect(isFullWithGrid: grid2, andResult: false, shouldBeNotNil: true)
        
        let grid3 = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
        expect(isFullWithGrid: grid3, andResult: false, shouldBeNotNil: true)
        
        let grid4 = [[1, 1, 1], [1, 1, 1], [1, 1, 1]]
        expect(isFullWithGrid: grid4, andResult: true, shouldBeNotNil: true)
    }*/
    
}
