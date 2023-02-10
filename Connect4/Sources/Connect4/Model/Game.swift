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
    public var player2: Player? {
        get {
            if(_ia != nil){return _ia!}
            else {return _player2}
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

    public init(withMenu menu: Menu) {
        _rules = BasicRules()
        _board = _rules.createBoard()
        _menu = menu
        _player1 = Human(withName: "Player1", andId: 1, andMenu: _menu)!
        _player2 = nil
        _currentPlayer = _player1
        _ia = nil
    }

    public func play(){
        let gameType = _menu.displayMenu()
        setStartGame(withGameType: gameType)

        while !isEnd() {
            let resultBoard: Board
            if gameType == GameType.HumanVsIA && currentPlayer is IA {
                _menu.displayIAPlay()
                resultBoard = _ia!.random(withBoard: board, andRules: rules)
            } else {
                resultBoard = currentPlayer.playInColumn(withBoard: board, andRules: rules)
            }
            _board = resultBoard
            _menu.displayBoard(withBoard: board)
            guard !isEnd() else {
                var winner: Player?
                (_, winner) = rules.isEnd(withBoard: board, andPlayer1: player1, andPlayer2: player2!)
                _menu.displayEndGame(withWinner: winner?.name ?? nil)
                return
            }
            _currentPlayer = (currentPlayer == player1) ? (player2!) : player1
        }
    }

    private func isEnd() -> Bool {
        let isEnd: EndType
        let winner: Player?
        (isEnd, winner) = rules.isEnd(withBoard: board, andPlayer1: player1, andPlayer2: player2 ?? nil)
        return isEnd != EndType.NotEnd
    }

    private func setStartGame(withGameType gameType: GameType){
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
    }
}
