//
//  ContentView.swift
//  Zombie Conga
//
//  Created by Tornike Despotashvili on 7/2/25.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
  var scene: SKScene {
    let scene = GameManager.loadLevel(lvl: 1)
    scene.size = UIScreen.main.bounds.size
    scene.scaleMode = .aspectFill
    return scene
  }
  
  var body: some View {
    ZStack {
      SpriteView(scene: scene)
        .ignoresSafeArea()
    }
  }
}

#Preview {
  ContentView()
}


final class LevelOne: BaseLevel {
  let cameraNode = SKCameraNode()
  let enemy = SKSpriteNode(imageNamed: "enemy")
  
  override func didMove(to view: SKView) {
    super.didMove(to: view)
    setupZombie()
    setupCamera()
    setupEnemy()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    
    zombie.moveZombie(location: location)
  }
  
  override func update(_ currentTime: TimeInterval) {
    updateCameraMovement()
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    let bodyA = contact.bodyA
    let bodyB = contact.bodyB
    
    let collision =
    (bodyA.categoryBitMask == CategoryBitmask.player && bodyB.categoryBitMask == CategoryBitmask.enemy) ||
    (bodyA.categoryBitMask == CategoryBitmask.enemy && bodyB.categoryBitMask == CategoryBitmask.player)
    
    if collision {
      print("✅")
    }
  }
  
  func didEnd(_ contact: SKPhysicsContact) {
    let bodyA = contact.bodyA
    let bodyB = contact.bodyB
    
    let collision =
    (bodyA.categoryBitMask == CategoryBitmask.player && bodyB.categoryBitMask == CategoryBitmask.enemy) ||
    (bodyA.categoryBitMask == CategoryBitmask.enemy && bodyB.categoryBitMask == CategoryBitmask.player)
    
    if !collision {
      zombie.physicsBody?.isDynamic = true
      enemy.physicsBody?.isDynamic = true
      print("2, 📸")
    }
  }
  
  func setupCamera() {
    camera = cameraNode
    addChild(cameraNode)
  }
  
  func updateCameraMovement() {
    let minX = size.width / 2
    let maxX = 3 * size.width - size.width / 2
    
    let clampedX = min(max(zombie.position.x, minX) ,maxX)
    let clampedY = UIScreen.main.bounds.height / 2
    
    cameraNode.position = CGPoint(x: clampedX, y: clampedY)
  }
  
  func setupEnemy() {
    
    enemy.name = "enemy"
    enemy.position = CGPoint(x: size.width / 2, y: size.height / 2)
    enemy.setScale(0.3)
    enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
    enemy.physicsBody?.isDynamic = true
    enemy.physicsBody?.affectedByGravity = false
    enemy.physicsBody?.usesPreciseCollisionDetection = true
    enemy.physicsBody?.categoryBitMask = CategoryBitmask.enemy
    enemy.physicsBody?.collisionBitMask = CategoryBitmask.player
    enemy.physicsBody?.contactTestBitMask = CategoryBitmask.player
    
    addChild(enemy)
  }
}


struct CategoryBitmask {
  static let player: UInt32 = 1
  static let enemy: UInt32 = 2
}
