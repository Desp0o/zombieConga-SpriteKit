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


final class LoseScene: BaseLevel {
  
  override func didMove(to view: SKView) {
    setupBg()
  }
  
  func setupBg() {
    let bg = SKSpriteNode(imageNamed: "YouLose")
    bg.size.width = size.width
    bg.size.height = size.height
    bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    bg.position = CGPoint(x: size.width / 2, y: size.height / 2)
    
    addChild(bg)
  }
}
