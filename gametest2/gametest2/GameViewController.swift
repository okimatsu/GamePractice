import UIKit
import SpriteKit

class GameViewController: UIViewController {

    let skView = SKView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let skView = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .resizeFill
            skView.presentScene(scene)
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
