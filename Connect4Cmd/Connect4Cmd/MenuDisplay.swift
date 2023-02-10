import Foundation
import Connect4

public struct MenuDisplay : Menu{

    /// Display the choice of the name of the players
    /// - Parameters :
    ///     - GameType : HumanVsHuman or HumanVsIA
    /// - Returns:
    ///    - String? : name of the player 1
    ///   - String? : name of the player 2
    ///    - nil : for the player 2 if the game is HumanVsIA
    public func initGame(withGameMode gameMode: GameType) -> (String?, String?){
        print("Joueur 1, quel est votre nom ?")
        let name1 = readLine()
        if gameMode == GameType.HumanVsHuman {
            print("Joueur 2, quel est votre nom ?")
            let name2 = readLine()
            return (name1, name2)
        }
        return (name1, nil)
    }

    /// Display the choice of the game mode
    /// - Returns:
    ///        - GameType: HumanVsIA, HumanVsHuman or Quit
    public func displayMenu() -> GameType {
        print("1. Jouer contre l'ordinateur")
        print("2. Jouer contre un autre joueur")
        print("3. Quitter")
        let choice = readLine()
        var verifChoice = verifyChoice(withChoice: choice!, andNumber: 3)
        guard(verifChoice != nil) else {
            return displayMenu()
        }
        if(verifChoice == 1){return GameType.HumanVsIA}
        else if(verifChoice == 2){return GameType.HumanVsHuman}
        else {return GameType.Quit}
    }

    /// Display the choice of the column
    /// - Parameters:
    ///     - withBoard: the board
    /// - Returns:
    /// -    Int: the column
    public func displayShooseColumn(withBoard board: Board) -> Int{
        print("Quelle colonne voulez-vous jouer ? (1-\(board.nbColumns))")
        let choice = readLine()
        var verifChoice = verifyChoice(withChoice: choice!, andNumber: board.nbColumns)
        while(verifChoice == nil){
            verifChoice = displayShooseColumn(withBoard: board)
        }
        return verifChoice!-1
    }

    /// Display the end of the game
    /// - Parameter winner: the name of the winner
    public func displayEndGame(withWinner winner: String?){
        if(winner == nil){
            print("La partie est terminée")
            print("Il n'y a pas de gagnant")
        } else {
            print("La partie est terminée")
            print("Le gagnant est \(winner!)")
        }
    }

    /// Verify the choice of the player
    /// - Parameters:
    ///   - choice:  the choice of the player (String)
    ///   - number: le nombre de choix possible
    /// - Returns:
    ///  - Int: the choice of the player (Int)
    private func verifyChoice(withChoice choice: String, andNumber number: Int ) -> Int? {
        guard let choice = Int(choice) else {return nil}
        for i in 1...number {
            if(choice == i){return choice}
        }
        return nil
    }

    /// Display the IA play
    public func displayIAPlay(){
        print("L'IA joue...")
        let random = Int.random(in: 1000...3000)
        sleep(UInt32(random/1000))
    }

    /// Display the board
    /// - Parameter board: the board
    public func displayBoard(withBoard board: Board){
        print(board)
    }
}
