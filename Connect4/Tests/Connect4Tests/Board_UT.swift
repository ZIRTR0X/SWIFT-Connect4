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
}
