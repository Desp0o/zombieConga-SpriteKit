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
  
  func setupZombie() {
    zombie.position = CGPoint(x: 100, y: UIScreen.main.bounds.height / 2)
    zombie.size = CGSize(width: 70, height: 70)
    addChild(zombie)
  }
  
  func setupCamera() {
    camera = cameraNode
    addChild(cameraNode)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    
    let move = SKAction.move(to: location, duration: 1)
    zombie.run(move)
  }
  
  override func update(_ currentTime: TimeInterval) {
    let minX = size.width / 2
    let maxX = 3 * size.width - size.width / 2
    
    let clampedX = min(max(zombie.position.x, minX) ,maxX)
    let clampedY = UIScreen.main.bounds.height / 2
    
    cameraNode.position = CGPoint(x: clampedX, y: clampedY)
  }
}
