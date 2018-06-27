import SpriteKit
import GameplayKit



func  + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}
func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}
#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

class GameScene: SKScene {
    
    
    
    let player = SKSpriteNode(imageNamed: "player")
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        player.size = CGSize(width: 50, height: 70)
        self.addChild(player)
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addMonster), SKAction.wait(forDuration: 1.0)])
        ))
        }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    func addMonster()  {
        let monster = SKSpriteNode(imageNamed: "monster")
        monster.size = CGSize(width: 80, height: 80)
        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        // ↑ モンスターのY軸
        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
        // ↑ モンスターのx軸
        addChild(monster)
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        // ↑ 2-4のスピードで動く
        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
        // ↑ actionMoveが終わったらactionMoveDone
    }
    
   
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
      
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        projectile.size = CGSize(width: 30, height: 30)
        
        let offset = touchLocation - projectile.position
        
        
        if offset.x < 0 { return }
        
        
        addChild(projectile)
        
        
        let direction = offset.normalized()
        
       
        let shootAmount = direction * 1000
        
        
        let realDest = shootAmount + projectile.position
        
        
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))

    }
    
    
}

