//
//  File.swift
//  
//
//  Created by etudiant on 24/01/2023.
//

import Foundation

public class Player : Equatable {
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }

    private var _name: String
    public var name: String {
        get {_name}
        set {_name = newValue}
    }
    
    private var _id: Int
    public var id: Int {
        get{_id}
    }


    private var _board: Board
    public var board: Board {
        get {_board}
    }
    
    
    public init?(withName name: String, andId id: Int, andBoard board: Board) {
        guard id == 1 || id == 2 else {
            print("Error : The id must be 1 or 2")
            return nil
        }
        _name = name
        _id = id
        _board = board
    }

    
    public func playInColumn(withColumn column: Int) -> Bool {
        board.insertPiece(id: _id, columns: column)
    }
}
