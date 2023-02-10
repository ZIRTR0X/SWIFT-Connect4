import Foundation
import Connect4

public class MenuDisplayMock: Menu {
    public init() {}
    
    public func initGame(withGameMode gameMode: GameType) -> (String?, String?) {("Jonh", "Doe")}
    
    public func displayMenu() -> GameType {
        var random = Int.random(in: 1..<2)
        guard random == 1 else {return GameType.HumanVsHuman}
        return GameType.HumanVsIA
    }
    
    public func displayShooseColumn(withBoard board: Board) -> Int {
        var random = Int.random(in: 0..<board.nbColumns)
        return random
    }
    
    public func displayEndGame(withWinner winner: String?) {}
    
    public func displayIAPlay() {}
    
    public func displayBoard(withBoard board: Board) {}
}
