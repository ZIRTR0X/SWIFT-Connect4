//
// Created by etudiant on 31/01/2023.
//

import Foundation

public class Game {

    private let _board: Board?
    public var board: Board {
        get {_board!}
    }

    private var _player1: Human?
    public var player1: Human? {
        get {_player1 ?? nil}
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
        _board = Board(nbRows: 6, nbColumns: 7)
        _menu = Menu(withBoard: _board!)
        _player1 = Human(withName: "Player1", andId: 1, andBoard: _board!)
        _player2 = nil
        _currentPlayer = _player1!
        _ia = nil
        _rules = BasicRules()
    }

    private func isEnd() -> Bool {
        let isEnd: Bool
        (isEnd, _, _) = _rules.isEnd(withBoard: _board!, andPlayer1: _player1!, andPlayer2: _player2!)
        return isEnd
    }

    public func play(){
        let gameType = _menu.displayMenu()
        let (player1Name, player2Name) = _menu.initGame(withGameMode: gameType)
        if(gameType == 1){
            _player1?.name = player1Name ?? "Player1"
            _ia = IA(withName: player2Name ?? "IA", andId: 2, andBoard: _board!)
        }
        if (gameType == 2){
            _player1 = Human(withName: player1Name ?? "Player1", andId: 1, andBoard: _board!)
            _player2 = Human(withName: player2Name ?? "Player2", andId: 2, andBoard: _board!)
        }
        if (gameType == 3){
            return
        }


        while isEnd() {
            if gameType == 1 && currentPlayer == _ia {
                guard isEnd() else {
                    print("La partie est terminée")
                    return
                }
                _ia!.random()
            } else {
                guard _menu.displayPlayMenu() == 1 else {return}
                guard isEnd() else {
                    print("La partie est terminée")
                    return
                }
                _currentPlayer.playInColumn(withColumn: _menu.play())
            }
            if(_currentPlayer == _player1){
                if(_player2 != nil){
                    _currentPlayer = _player2!
                } else {
                    _currentPlayer = _ia!
                }
            } else {
                _currentPlayer = _player1!
            }
            print(_board!)
        }
    }

}
