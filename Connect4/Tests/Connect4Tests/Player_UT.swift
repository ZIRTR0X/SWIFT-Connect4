import Foundation
import XCTest
@testable import Connect4

final class Player_UT: XCTestCase {

    func testInit() throws {

        func expect(withName name: String, andId id: Int, shouldBeNotNil notNil: Bool) {
            let board = Board(nbRows : 6, nbColumns: 7)
            let menu: Menu = MenuDisplayMock()
            let player = Player(withName: name, andId: id, andMenu: menu)

            if !notNil {
                XCTAssertNil(player)
                return
            }
            XCTAssertNotNil(player)
            XCTAssertEqual(name, player?.name)
            XCTAssertEqual(id, player?.id)
        }

        expect(withName: "Player", andId: 1, shouldBeNotNil: true)
        expect(withName: "Player", andId: 2, shouldBeNotNil: true)
        expect(withName: "Player", andId: 3, shouldBeNotNil: false)
        expect(withName: "Player", andId: 0, shouldBeNotNil: false)
    }

    func testPlayInColumn() throws {

        func expect(withGrid grid: [[Int?]], shouldBeNotNil notNil: Bool) {
            let board = Board(grid: grid)
            let menu = MenuDisplayMock()
            let rules = BasicRules()
            let player = Player(withName: "Player", andId: 1, andMenu: menu)
            let result = player?.playInColumn(withBoard: board!, andRules: rules)

            if !notNil {
                XCTAssertEqual(grid, result?.grid)
                return
            }
            XCTAssertNotEqual(grid, result?.grid)
        }

        let grid = [
            [nil, nil, nil, nil, 2, 1, 1],
            [nil, nil, nil, 2, 2, 1, 1],
            [nil, nil, 2, 2, 2, 1, 1],
            [nil, 2, 2, 2, 2, 1, 1],
            [2, 2, 2, 2, 2, 1, 1],
            [2, 2, 2, 2, 2, 1, 1]]
        for _ in 0..<20 {
            expect(withGrid: grid, shouldBeNotNil: true)
        }
    }

    func testComparePlayer() throws {
        let menu: Menu = MenuDisplayMock()
        let player1 = Player(withName: "Player", andId: 1, andMenu: menu)
        let player2 = Player(withName: "Player2", andId: 1, andMenu: menu)
        let player3 = Player(withName: "Player3", andId: 1, andMenu: menu)
        let player4 = player1

        XCTAssertEqual(player1!, player4!)
        XCTAssertNotEqual(player1!, player3!)
        XCTAssertNotEqual(player2!, player3!)
    }

    func testSetName() throws {
        let menu: Menu = MenuDisplayMock()
        let player = Player(withName: "Player", andId: 1, andMenu: menu)
        player?.name = "Player1"
        XCTAssertEqual("Player1", player?.name)
    }

}
