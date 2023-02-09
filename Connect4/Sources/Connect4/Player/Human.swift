//
//  File.swift
//  
//
//  Created by etudiant on 26/01/2023.
//

import Foundation

public class Human: Player {
    public override init?(withName name: String, andId id: Int, andMenu menu: MenuDisplay) {
        super.init(withName: name, andId: id, andMenu: menu)
    }
}
