import Foundation
import XCTest
@testable import Connect4

final class Game_UT: XCTestCase {

    func testInit() throws {
        let menu: Menu = MenuDisplayMock()
        let game = Game(withMenu: menu)
        XCTAssertNotNil(game)
        XCTAssertNil(game.player2)
        XCTAssertNotNil(game.player1)
        XCTAssertNotNil(game.board)
        XCTAssertNotNil(game.rules)
        XCTAssertEqual(game.currentPlayer, game.player1)
    }

    func testPlay() throws {
        func expect() {
            let menu: Menu = MenuDisplayMock()
            let game = Game(withMenu: menu)
            game.play()
            XCTAssertNotNil(game.player2)
            XCTAssertNotNil(game.player1)
            XCTAssertNotNil(game.board)
            XCTAssertNotNil(game.rules)
            XCTAssertNotNil(game.currentPlayer)
        }
        for _ in 0..<20 {
            expect()
        }
    }


}
