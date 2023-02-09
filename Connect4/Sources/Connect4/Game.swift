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

    private var _menu: MenuDisplay

    public init() {
        _rules = BasicRules()
        _board = _rules.createBoard()
        _menu = MenuDisplay()
        _player1 = Human(withName: "Player1", andId: 1, andMenu: _menu)!
        _player2 = nil
        _currentPlayer = _player1
        _ia = nil
    }

    private func isEnd() -> Bool {
        let isEnd: EndType
        (isEnd, _) = _rules.isEnd(withBoard: _board, andPlayer1: _player1, andPlayer2: player2)
        return isEnd != EndType.NotEnd
    }

    public func play(){
        let gameType = _menu.displayMenu()
        if(gameType == GameType.Quit){return}
        let (player1Name, player2Name) = _menu.initGame(withGameMode: gameType)
        switch gameType {
            case GameType.HumanVsIA:
                _player1.name = player1Name ?? "Player1"
                _ia = IA(withName: player2Name ?? "IA", andId: 2, andMenu: _menu)
            case GameType.HumanVsHuman:
                _player1.name = player1Name ?? "Player1"
                _player2 = Human(withName: player2Name ?? "Player2", andId: 2, andMenu: _menu)!
            default:
                return

        }
        while !isEnd() {
            let resultBoard: Board
            if gameType == GameType.HumanVsIA && currentPlayer is IA {
                resultBoard = _ia!.random(withBoard: _board, andRules: _rules)
            } else {
                resultBoard = _currentPlayer.playInColumn(withBoard: _board, andRules: _rules)
            }
            setBoard(withBoard: resultBoard)
            print(_board)
            guard !isEnd() else {
                var winner: Player?
                (_, winner) = _rules.isEnd(withBoard: _board, andPlayer1: player1, andPlayer2: player2)
                _menu.displayEndGame(withWinner: winner?.name ?? nil)
                return
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
        }
    }

    private func setBoard(withBoard board: Board){
        _board = board
    }
}
