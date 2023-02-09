//
// Created by etudiant on 09/02/2023.
//

import Foundation

/// Enum that represents the end of the game
/// - EndWithWin: The game is ended and a player has won
/// - EndWithoutWin: The game is ended and no player has won
/// - NotEnd: The game is not ended
public enum EndType{
    case EndWithWin
    case EndWithoutWin
    case NotEnd
}