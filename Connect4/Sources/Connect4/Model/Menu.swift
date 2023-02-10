//
// Created by etudiant on 10/02/2023.
//

import Foundation

public protocol Menu{

    /// Display the choice of the name of the players
    /// - Parameters :
    ///     - GameType : HumanVsHuman or HumanVsIA
    /// - Returns:
    ///    - String? : name of the player 1
    ///   - String? : name of the player 2
    ///    - nil : for the player 2 if the game is HumanVsIA
    func initGame(withGameMode gameMode: GameType) -> (String?, String?)

    /// Display the choice of the game mode
    /// - Returns :
    ///     - GameType : HumanVsIA, HumanVsHuman or Quit
    func displayMenu() -> GameType

    /// Display the choice of the column
    /// - Parameters:
    ///     - withBoard: the board
    /// - Returns:
    /// -    Int: the column
    func displayShooseColumn(withBoard board: Board) -> Int

    /// Display the end of the game
    /// - Parameter winner: the name of the winner
    func displayEndGame(withWinner winner: String?)

    /// Display the IA play
    func displayIAPlay()

    /// Display the board
    /// - Parameter board: the board
    func displayBoard(withBoard board: Board)
}
