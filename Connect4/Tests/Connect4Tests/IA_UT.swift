import Foundation
import XCTest
@testable import Connect4

final class IA_UT: XCTestCase {

    func testRandom() throws {

        func expect(withGrid grid: [[Int?]],  shouldBeNotNil notNil: Bool) {
            let board = Board(grid: grid)
            let menu = MenuDisplay()
            let rules = BasicRules()
            let ia = IA(withName: name, andId: 1, andMenu: menu)
            let result = ia?.random(withBoard: board!, andRules: rules)

            if !notNil {
                XCTAssertEqual(grid, result?.grid)
                return
            }
            XCTAssertNotEqual(board!, result!)
            XCTAssertNotNil(result)
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
