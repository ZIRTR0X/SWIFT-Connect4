import Foundation

public struct Menu {

    private var _board: Board

    public init(withBoard board: Board){
        _board = board
    }

    public mutating func initGame(withGameMode gameMode: GameType) -> (String?, String?){
        print("Joueur 1, quel est votre nom ?")
        let name1 = readLine()
        if gameMode == GameType.HumanVsHuman {
            print("Joueur 2, quel est votre nom ?")
            let name2 = readLine()
            return (name1, name2)
        }
        return (name1, nil)
    }

    public mutating func displayMenu() -> GameType {
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

    public func displayShooseColumn() -> Int{
        print("Quelle colonne voulez-vous jouer ? (1-\(_board.nbColumns))))")
        let choice = readLine()
        var verifChoice = verifyChoice(withChoice: choice!, andNumber: _board.nbColumns)
        print(verifChoice)
        while(verifChoice == nil){
            verifChoice = displayShooseColumn()
        }
        return verifChoice!-1
    }

    public func displayEndGame(withWinner winner: String?){
        if(winner == nil){
            print("La partie est terminée")
            print("Il n'y a pas de gagnant")
        } else {
            print("La partie est terminée")
            print("Le gagnant est \(winner!)")
        }
    }

    private func verifyChoice(withChoice choice: String, andNumber number: Int ) -> Int? {
        guard let choice = Int(choice) else {return nil}
        for i in 1...number {
            if(choice == i){return choice}
        }
        return nil
    }
}
