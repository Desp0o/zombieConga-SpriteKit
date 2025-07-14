//
//  GameManager.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/2/25.
//

import SpriteKit

final class GameManager {
  static func loadLevel(lvl: Int) -> SKScene {
    switch lvl {
    case 0:
      return MainMenu()
    case 1:
      return SKScene(fileNamed: "LevelOneScene") ?? MainMenu()
    case 2:
      return LoseScene()
    case 3:
      return WinnerScene()
    default:
      return MainMenu()
    }
  }
}
