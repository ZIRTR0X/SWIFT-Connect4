import Foundation

public struct MenuDisplay {

    public init() {
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

    public func displayShooseColumn(withBoard board: Board) -> Int{
        print("Quelle colonne voulez-vous jouer ? (1-\(board.nbColumns))")
        let choice = readLine()
        var verifChoice = verifyChoice(withChoice: choice!, andNumber: board.nbColumns)
        while(verifChoice == nil){
            verifChoice = displayShooseColumn(withBoard: board)
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

    public func displayIAPlay(){
        print("L'IA joue...")
        let random = Int.random(in: 1000...3000)
        sleep(UInt32(random/1000))
    }

    public func displayBoard(withBoard board: Board){
        print(board)
    }
}
