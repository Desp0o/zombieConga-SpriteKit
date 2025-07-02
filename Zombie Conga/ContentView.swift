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
