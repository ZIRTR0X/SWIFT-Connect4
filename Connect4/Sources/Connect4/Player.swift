//
//  File.swift
//  
//
//  Created by etudiant on 24/01/2023.
//

import Foundation

public class Player {
    private let _name: String
    public var name: String {
        get {_name}
    }
    
    private let _id: Int
    public var id: Int {
        get{_id}
    }
    
    public var board: Board
    
    
    public init(withName name: String, andId id: Int, andBoard board: Board) {
        _name = name
        _id = id
        self.board = board
    }

    
    public func playInColumn(withColumn column: Int) -> Bool {
        return board.insertPiece(id: _id, columns: column)
    }
}
