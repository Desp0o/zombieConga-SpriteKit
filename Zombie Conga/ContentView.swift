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
    let scene = GameManager.loadLevel(lvl: 0)
    scene.size = UIScreen.main.bounds.size
    scene.scaleMode = .fill
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


final class LevelOne: SKScene {
  let zombie = SKSpriteNode(imageNamed: "zombie1")
  let cameraNode = SKCameraNode()
  
  override func didMove(to view: SKView) {
    setupZombie()
    setupCamera()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    
    moveZombie(location: location)
  }
  
  override func update(_ currentTime: TimeInterval) {
    updateCameraMovement()
  }
  
  func setupZombie() {
    zombie.position = CGPoint(x: 100, y: UIScreen.main.bounds.height / 2)
    zombie.size = CGSize(width: 70, height: 70)
    addChild(zombie)
  }
  
  func moveZombie(location: CGPoint) {
    let zombieX: CGFloat = zombie.position.x
    let zombieY: CGFloat = zombie.position.y
    
    let offset: CGPoint = CGPointMake(location.x - zombieX, location.y - zombieY)
    let distance: CGFloat = sqrt(offset.x * offset.x + offset.y * offset.y)
    let speed: CGFloat = 300.0
    let duration: CGFloat = distance / speed
    let direction: CGPoint = CGPoint(x: offset.x / distance, y: offset.y / distance)
    let angle: CGFloat = atan2(direction.y, direction.x)
    
    let move = SKAction.move(to: location, duration: duration)
    let rotate = SKAction.rotate(toAngle: angle, duration: 0.2, shortestUnitArc: true)
    
    zombie.removeAllActions()
    zombie.run(rotate)
    zombie.run(move)
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
}
