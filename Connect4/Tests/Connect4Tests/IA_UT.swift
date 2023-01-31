import Foundation
import Foundation
import XCTest
@testable import Connect4

final class IA_UT: XCTestCase {

    func testRandom() throws {

        func expect(withGrid grid: [[Int?]],  shouldBeNotNil notNil: Bool) {
            let board = Board(grid: grid)
            let ia = IA(withName: name, andId: 1, andBoard: board!)
            let result = ia?.random()

            if !notNil {
                XCTAssertFalse(result!)
                return
            }
            XCTAssertTrue(result!)
            XCTAssertNotNil(ia?.board)
        }

        let grid = [
            [nil, nil, nil, nil, 2],
            [nil, nil, nil, 2, 2],
            [nil, nil, 2, 2, 2],
            [nil, 2, 2, 2, 2]]
        expect(withGrid: grid, shouldBeNotNil: true)

        let grid2 = [
            [2, 2, 2, 2, 2],
            [2, 2, 2, 2, 2],
            [2, 2, 2, 2, 2],
            [2, 2, 2, 2, 2]]
        expect(withGrid: grid2, shouldBeNotNil: false)

        for _ in 0...10 {
            let grid3 = [
                [2, 2, 2, 2, nil],
                [2, 2, 2, 2, 2],
                [2, 2, 2, 2, 2],
                [2, 2, 2, 2, 2]]
            expect(withGrid: grid3, shouldBeNotNil: true)
        }


    }


}
