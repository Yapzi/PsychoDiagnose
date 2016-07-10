//
//  ViewController.swift
//  Happiness
//
//  Created by Yapzi on 16/6/11.
//  Copyright © 2016年 Yap. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: NSSelectorFromString("scale:")))
            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: NSSelectorFromString("smilinessForGesture:")))
        }
    }
    
    var happiness: Int = 10 {
        didSet {
            happiness = min(max(happiness, 0), 100)
            updateUI()
        }
    }
    
    func updateUI() {
        faceView?.setNeedsDisplay()
    }
    
    func smilinessForFaceView(faceView: FaceView) -> Double? {
        let k = Double(happiness - 50) / 50
        return k
    }
    
    func smilinessForGesture(gesture: UIPanGestureRecognizer) {
        let changingScale: CGFloat = 4
        switch gesture.state {
            case .Ended: fallthrough
            case .Changed:
                let translation = gesture.translationInView(faceView)
                let smilinessChange = Int(translation.y / changingScale)
                happiness += smilinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
        default: break
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

