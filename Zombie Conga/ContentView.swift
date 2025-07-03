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
  let cameraNode: SKCameraNode = SKCameraNode()
  let zombie: Zombie = Zombie()
  let enemy: Enemy = Enemy()
  
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
      hittedByEnemy()
    }
  }
  
  func setupZombie() {
    zombie.position = CGPoint(x: 100, y: UIScreen.main.bounds.height / 2)
    addChild(zombie)
  }
  
  func setupEnemy() {
    
    let spawn = SKAction.run {[weak self] in
      guard let zombie = self?.zombie else { return }
      self?.enemy.generateEnemyPosition(sprite: zombie)
      
      guard let enemy = self?.enemy else { return }
      let move = SKAction.move(to: CGPoint(x: -600, y: enemy.position.y) , duration: 4)
      enemy.run(move)
    }
    
    let remove = SKAction.removeFromParent()
    let wait = SKAction.wait(forDuration: 5)
    let sequence = SKAction.sequence([spawn, remove, wait])
    let repeatForever = SKAction.repeatForever(sequence)
    
    self.run(repeatForever)
    addChild(enemy)
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
  
  func hittedByEnemy() {
    zombie.physicsBody?.categoryBitMask = 0
    zombie.physicsBody?.contactTestBitMask = 0
    zombie.physicsBody?.usesPreciseCollisionDetection = false
    zombie.physicsBody?.collisionBitMask = 0
    
    let restore = SKAction.run {[weak self] in
      self?.zombie.physicsBody?.usesPreciseCollisionDetection = true
      self?.zombie.physicsBody?.categoryBitMask = CategoryBitmask.player
      self?.zombie.physicsBody?.collisionBitMask = CategoryBitmask.enemy
      self?.zombie.physicsBody?.contactTestBitMask = CategoryBitmask.enemy
    }
    
    let fadeOut = SKAction.fadeOut(withDuration: 0.1)
    let fadeIn = SKAction.fadeIn(withDuration: 0.1)
    let blink = SKAction.sequence([fadeOut, fadeIn])
    let repeatBlinking = SKAction.repeat(blink, count: 6)
    
    zombie.run(SKAction.sequence([repeatBlinking, restore]))
  }
}



