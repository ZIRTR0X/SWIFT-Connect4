import Foundation
import XCTest
@testable import Connect4

final class Player_UT: XCTestCase {

    func testInit() throws {

        func expect(withName name: String, andId id: Int, shouldBeNotNil notNil: Bool) {
            let board = Board(nbRows : 6, nbColumns: 7)
            let player = Player(withName: name, andId: id, andBoard: board!)

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

        func expect(withColumn column: Int, shouldBeNotNil notNil: Bool) {
            let grid = [
                [nil, nil, nil, nil, 2],
                [nil, nil, nil, 2, 2],
                [nil, nil, 2, 2, 2],
                [nil, 2, 2, 2, 2]]
            let board = Board(grid: grid)
            let player = Player(withName: "Player", andId: 1, andBoard: board!)
            let result = player?.playInColumn(withColumn: column)

            if !notNil {
                XCTAssertFalse(result!)
                return
            }
            XCTAssertTrue(result!)
            XCTAssertNotNil(result)
            switch column {
            case 0:
                XCTAssertEqual(1, board?.grid[3][0])
            case 1:
                XCTAssertEqual(1, board?.grid[2][1])
            case 2:
                XCTAssertEqual(1, board?.grid[1][2])
            default:
                XCTAssertEqual(1, board?.grid[0][3])
            }

        }

        expect(withColumn: 0, shouldBeNotNil: true)
        expect(withColumn: 1, shouldBeNotNil: true)
        expect(withColumn: 2, shouldBeNotNil: true)
        expect(withColumn: 3, shouldBeNotNil: true)
        expect(withColumn: 4, shouldBeNotNil: false)
        expect(withColumn: 5, shouldBeNotNil: false)
        expect(withColumn: -1, shouldBeNotNil: false)
    }

    func testComparePlayer() throws {
        let board = Board(nbRows : 6, nbColumns: 7)
        let player1 = Player(withName: "Player1", andId: 1, andBoard: board!)
        let player2 = Player(withName: "Player2", andId: 2, andBoard: board!)
        let player3 = Player(withName: "Player3", andId: 1, andBoard: board!)

        XCTAssertNotEqual(player1, player2)
        XCTAssertEqual(player1, player3)
    }

    func testSetName() throws {
        let board = Board(nbRows : 6, nbColumns: 7)
        let player = Player(withName: "Player", andId: 1, andBoard: board!)
        player?.name = "Player1"
        XCTAssertEqual("Player1", player?.name)
    }

}
