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
    
    var ground = SKSpriteNode(imageNamed: "bg")
    
    var PlayerTextureAtlas = SKTextureAtlas()
    var PlayerTextureArray: [SKTexture] = []
    

    
    override func didMove(to view: SKView) {
        PlayerTextureAtlas = SKTextureAtlas(named: "SkeletonWalk.atlas")
        
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        
        for n in 1...PlayerTextureAtlas.textureNames.count{
            let texture = "SW\(n).png"
            PlayerTextureArray.append(SKTexture(imageNamed: texture))
        }
        let anim = SKAction.animate(with: PlayerTextureArray, timePerFrame: 0.09)
        let animforever = SKAction.repeatForever(anim)
        player.position = CGPoint(x: frame.midX, y: frame.midY - 60)
        player.setScale(2)
        player.zPosition = 3
        self.addChild(player)
        player.run(animforever)
        
        createGrounds()

    }
    
    func createGrounds(){
        
        for i in 0...3 {
            
            let ground = SKSpriteNode(imageNamed: "bg")
            ground.name = "Ground"
            ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.ground.texture?.size().height)!)
            ground.anchorPoint = CGPoint(x:0.5, y:0.5)
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: frame.midY)
            
            self.addChild(ground)
        }
    }
    
    func moveGround(){
        
        self.enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            
            node.position.x -= 1.5
            
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
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
        multiplierForDirection = -1.0
      } else {
        // walk right
        multiplierForDirection = 1.0
      }
      
      player.xScale = abs(player.xScale) * multiplierForDirection
        
        animate()
        moveGround()
    }
}
