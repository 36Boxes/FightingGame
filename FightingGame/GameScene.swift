//
//  GameScene.swift
//  FightingGame
//
//  Created by Josh Manik on 08/06/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player = SKSpriteNode(imageNamed: "SW13")
    
    var PlayerTextureAtlas = SKTextureAtlas()
    var PlayerTextureArray: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        PlayerTextureAtlas = SKTextureAtlas(named: "SkeletonWalk.atlas")
        
        for n in 1...PlayerTextureAtlas.textureNames.count{
            let texture = "SW\(n).png"
            PlayerTextureArray.append(SKTexture(imageNamed: texture))
        }
        let anim = SKAction.animate(with: PlayerTextureArray, timePerFrame: 0.09)
        let animforever = SKAction.repeatForever(anim)
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        player.setScale(3)
        player.zPosition = 3
        self.addChild(player)

    }
    
    func animate(){
        let anim = SKAction.animate(with: PlayerTextureArray, timePerFrame: 0.09)
        player.run(anim)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      let touch = touches.first!
      let location = touch.location(in: self)
      
      var multiplierForDirection: CGFloat
      if location.x < frame.midX {
        // walk left
        multiplierForDirection = 1.0
      } else {
        // walk right
        multiplierForDirection = -1.0
      }
      
      player.xScale = abs(player.xScale) * multiplierForDirection
        
        animate()
    }
}
