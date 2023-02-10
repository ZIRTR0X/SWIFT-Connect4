//
//  File.swift
//  
//
//  Created by etudiant on 24/01/2023.
//

import Foundation

public class Player : Equatable {
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }

    private var _menu: Menu

    private var _name: String
    public var name: String {
        get {_name}
        set {_name = newValue}
    }
    
    private var _id: Int
    public var id: Int {
        get{_id}
    }
    
    
    public init?(withName name: String, andId id: Int, andMenu menu: Menu) {
        guard id == 1 || id == 2 else {
            print("Error : The id must be 1 or 2")
            return nil
        }
        _name = name
        _id = id
        _menu = menu
    }

    public func playInColumn(withBoard board: Board, andRules rules : Rules) -> Board {
        if(board.isFull()) {return board}
        var newBoard = board
        var column =  _menu.displayShooseColumn(withBoard: newBoard)-1
        while(rules.isValideMove(withBoard: newBoard, andColumn: column) == false){
            column = _menu.displayShooseColumn(withBoard: newBoard)-1
        }
        newBoard.insertPiece(id: _id, columns: column)
        return newBoard
    }
}
