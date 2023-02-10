import Foundation
import Connect4

public class MenuDisplayMock: Menu {
    public init() {}
    
    public func initGame(withGameMode gameMode: GameType) -> (String?, String?) {
        var random = Int.random(in: 1..<4)
        if random == 1 {return (nil, nil)}
        if random == 2 {return ("Jonh", nil)}
        if random == 3 {return (nil, "Doe")}
        return ("Jonh", "Doe")
    }
    
    public func displayMenu() -> GameType {
        var random = Int.random(in: 1..<3)
        if random == 1 {return GameType.HumanVsIA}
        return GameType.HumanVsHuman
    }
    
    public func displayShooseColumn(withBoard board: Board) -> Int {
        var random = Int.random(in: -1..<board.nbColumns+1)
        return random
    }
    
    public func displayEndGame(withWinner winner: String?) {}
    
    public func displayIAPlay() {}
    
    public func displayBoard(withBoard board: Board) {}
}
