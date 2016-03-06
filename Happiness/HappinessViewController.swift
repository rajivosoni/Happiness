//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Rajiv on 1/31/16.
//  Copyright © 2016 Rajiv. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    var happiness: Int = 75 {
        didSet {
            happiness = min(max(happiness,0),100)
            print("happiness = \(happiness)")
            updateUI()
        }
    }

    func updateUI(){
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
