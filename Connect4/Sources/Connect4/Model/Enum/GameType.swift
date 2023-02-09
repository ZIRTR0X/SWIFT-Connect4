//
// Created by etudiant on 09/02/2023.
//

import Foundation

/// Enum that represents the type of the game
/// - HumanVsHuman: Two players
/// - HumanVsIA: One player
/// - Quit: Quit the game
public enum GameType{
    case HumanVsHuman
    case HumanVsIA
    case Quit
}