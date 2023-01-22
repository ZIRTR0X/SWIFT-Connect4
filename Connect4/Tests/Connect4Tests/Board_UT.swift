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
        expect(iniBoardWithGrid: [[0]], shouldBeNotNil: true)
        let grid1 = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
        expect(iniBoardWithGrid: grid1, shouldBeNotNil: true)
        let grid2 = [[0, 0, 0], [0, 0, 0], [0, 0]]
        expect(iniBoardWithGrid: grid2, shouldBeNotNil: false)
        let grid3 = [[0, 0, 0], [0, 0, 0], [0, 0, 0, 0]]
        expect(iniBoardWithGrid: grid3, shouldBeNotNil: false)
    }
}
