import Foundation
import Connect4

var menu: Menu = MenuDisplay()
var game: Game = Game(withMenu: menu)
game.play()