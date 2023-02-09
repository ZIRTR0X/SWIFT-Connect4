//
// Created by etudiant on 31/01/2023.
//

import Foundation

public class Game {


    private var _board: Board
    public var board: Board {
        get {_board}
    }

    private var _player1: Human
    public var player1: Human {
        get {_player1}
    }

    private var _player2: Player?
    public var player2: Player {
        get {
            if(_ia != nil){return _ia!} else {return _player2!}
        }
    }

    private var _currentPlayer: Player
    public var currentPlayer: Player {
        get {_currentPlayer}
    }

    private let _rules: Rules
    public var rules: Rules {
        get {_rules}
    }

    private var _ia: IA?

    private var _menu: Menu

    public init() {
        _rules = BasicRules()
        _board = _rules.createBoard()
        _menu = Menu(withBoard: _board)
        _player1 = Human(withName: "Player1", andId: 1, andMenu: _menu)!
        _player2 = nil
        _currentPlayer = _player1
        _ia = nil
    }

    private func isEnd() -> Bool {
        let isEnd: Bool
        (isEnd, _, _) = _rules.isEnd(withBoard: _board, andPlayer1: _player1, andPlayer2: player2)
        return isEnd
    }

    public func play(){
        let gameType = _menu.displayMenu()
        if(gameType == 3){return}
        let (player1Name, player2Name) = _menu.initGame(withGameMode: gameType)
        switch gameType {
            case 1:
                _player1.name = player1Name ?? "Player1"
                _ia = IA(withName: player2Name ?? "IA", andId: 2, andMenu: _menu)
            case 2:
                _player1.name = player1Name ?? "Player1"
                _player2 = Human(withName: player2Name ?? "Player2", andId: 2, andMenu: _menu)!
            default:
                return

        }
//        if(gameType == 1){
//            _player1.name = player1Name ?? "Player1"
//            _ia = IA(withName: player2Name ?? "IA", andId: 2, andMenu: _menu)
//        }
//        if (gameType == 2){
//            _player1.name = player1Name ?? "Player1"
//            _player2 = Human(withName: player2Name ?? "Player2", andId: 2, andMenu: _menu)!
//        }
//        if (gameType == 3){
//            return
//        }


        while !isEnd() {
            if gameType == 1 && currentPlayer is IA {
                guard !isEnd() else {
                    print("La partie est terminée")
                    return
                }
                let resultBoard = _ia!.random(withBoard: _board, andRules: _rules)
                setBoard(withBoard: resultBoard)
            } else {
                guard _menu.displayPlayMenu() == 1 else {return}
                guard !isEnd() else {
                    print("La partie est terminée")
                    return
                }
                let resultBoard = _currentPlayer.playInColumn(withBoard: _board, andRules: _rules)
                setBoard(withBoard: resultBoard)
            }
            if(_currentPlayer == _player1){
                if(_player2 != nil){
                    _currentPlayer = _player2!
                } else {
                    _currentPlayer = _ia!
                }
            } else {
                _currentPlayer = _player1
            }
            print("New turn")
            print(_board)
        }
    }

    private func setBoard(withBoard board: Board){
        _board = board
    }

}

extension Date{
    static let dateFormatter = DateFormatter()

    public init?(year: Int, month: Int, day: Int) {
        Date.dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let date = Date.dateFormatter.date(from: "\(day)/\(month)/\(year)") else {
            return nil
        }
        self = date
    }

    func toString() -> String {
        Date.dateFormatter.dateFormat = "dd/MM/yyyy"
        return Date.dateFormatter.string(from: self)
    }
}
