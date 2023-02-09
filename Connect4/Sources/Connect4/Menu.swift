import Foundation

public struct Menu {

    private var _board: Board

    public init(withBoard board: Board){
        _board = board
    }

    /*public mutating func start(){
        displayMenu()
    }*/
    public mutating func initGame(withGameMode gameMode: Int) -> (String?, String?){
        print("Joueur 1, quel est votre nom ?")
        let name1 = readLine()
        if gameMode == 2 {
            print("Joueur 2, quel est votre nom ?")
            let name2 = readLine()
            return (name1, name2)
        }
        return (name1, nil)
    }

    /*private mutating func initGame(withGameMode gameMode: Int){
        print("Joueur 1, quel est votre nom ?")
        let name1 = readLine()
        player1 = Player(withName: name1 ?? "Player1", andId: 1, andBoard: _board)
        if gameMode == 2 {
            print("Joueur 2, quel est votre nom ?")
            let name2 = readLine()
            player2 = Player(withName: name2 ?? "Player2", andId: 2, andBoard: _board)
        } else {
            ia = IA(withName: "IA", andId: 2, andBoard: _board)
        }
    }*/

    /*private mutating func displayMenu() {
        print("1. Jouer contre l'ordinateur")
        print("2. Jouer contre un autre joueur")
        print("3. Quitter")
        let choice = readLine()
        let result = verifyChoice(withChoice: choice!, andNumber: 3)
        switch result {
            case 1:
                initGame(withGameMode: 1)
                playWithIA()

            case 2:
                initGame(withGameMode: 2)
                playWithPlayer()
            default:
                print("Veuillez entrer un nombre valide !")
        }
    }*/

    public mutating func displayMenu() -> Int{
        print("1. Jouer contre l'ordinateur")
        print("2. Jouer contre un autre joueur")
        print("3. Quitter")
        let choice = readLine()
        var verifChoice = verifyChoice(withChoice: choice!, andNumber: 3)
        while(verifChoice == 0){
            verifChoice = displayMenu()
        }
        print(verifChoice)
        return verifChoice!
    }

    public func displayPlayMenu() -> Int{
        print("1. Jouer")
        print("2. Quitter")
        let choice = readLine()
        var verifChoice = verifyChoice(withChoice: choice!, andNumber: 3)
        while(verifChoice == 0){
            verifChoice = displayPlayMenu()
        }
        return verifChoice!

    }

    public func displayShooseColumn() -> Int{
        print("Quelle colonne voulez-vous jouer ? (1-\(_board.nbColumns))))")
        let choice = readLine()
        var verifChoice = verifyChoice(withChoice: choice!, andNumber: 3)
        while(verifChoice == 0){
            verifChoice = displayShooseColumn()
        }
        return verifChoice!-1

    }

    /*private func play(withPlayer player: Player){
        guard !_board.isEnd() else {
            print("La partie est terminée")
            return
        }
        print("Quelle colonne voulez-vous jouer ? (1-\(_board.nbColumns))))")
        let choice = readLine()
        let result = verifyChoice(withChoice: choice!, andNumber: _board.nbColumns)
        if player.playInColumn(withColumn: result-1) {
            print("Vous avez joué dans la colonne \(result)")
            print(_board)
        }
    }*/

    /*public func playIA(withPlayer player: IA){
        guard !_board.isEnd() else {
            print("La partie est terminée")
            return
        }
        print(player.random())
        print(_board)
    }*/

    /*private func playWithPlayer() {
        print("1. Jouer")
        print("2. Quitter")
        let choice = readLine()
        let result = verifyChoice(withChoice: choice!, andNumber: 2)
        switch result {
        case 1:
            while(!_board.isEnd()){
                play(withPlayer: player1!)
                if(_board.isFull() == false){
                    play(withPlayer: player2!)
                }
            }
            showWinner(withPlayer: player1!, andPlayer2: player2!)
        case 2:
            print("Vous avez choisi de quitter")
        default:
            print("Veuillez entrer un nombre valide !")
        }
    }*/


    /*A modifier pour utiliser les rules*/
    /*private func showWinner(withPlayer player1: Player, andPlayer2 player2: Player){
        if(_board.isWinner(withSymbole: player1.id)){
            print("Le joueur \(player1.name) a gagné !")
            return
        }
        if(_board.isWinner(withSymbole: player2.id)){
            print("Le joueur \(player2.name) a gagné !")
            return
        }
        if(_board.isFull()){
            print("Match nul !")
            return
        }
    }*/

    private func verifyChoice(withChoice choice: String, andNumber number: Int ) -> Int? {
        /*guard let choice = Int(choice) else {
            print("Veuillez entrer un nombre valide !")
            let choice = readLine()
            return verifyChoice(withChoice: choice!, andNumber: number)
        }*/
        guard let choice = Int(choice) else{return nil}
        for i in 1...number {
            if(choice == i){return choice}
        }
        return nil
    }
}
