//
//  ViewController.swift
//  GameHandle.swift
//
//  Created by allthings_LuYD on 16/8/9.
//  Copyright © 2016年 scrum_snail. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftBgImage: UIImageView!
    @IBOutlet weak var leftHandle: UIImageView!
    @IBOutlet weak var rightBgImage: UIImageView!
    @IBOutlet weak var rightHandle: UIImageView!

    let radius = 75
    var left = CGPoint()
    var right = CGPoint()
    var rightRect = CGRect()


    override func viewDidLoad() {
        super.viewDidLoad()
        left = leftHandle.center
        right = rightHandle.center
        rightRect = rightBgImage.frame
        let leftPan = UIPanGestureRecognizer.init(target: self, action: #selector(leftPanFrom))
        leftHandle.addGestureRecognizer(leftPan)
        let rightPan = UIPanGestureRecognizer.init(target: self, action: #selector(rightPanFrom))
        rightHandle.addGestureRecognizer(rightPan)
    }

    func leftPanFrom(recognizer:UIPanGestureRecognizer) -> Void {
        leftHandle.image = UIImage(named: "btn_pressed")
        let translation = recognizer.translation(in: self.view)
        var center = recognizer.view?.center
        center?.y += translation.y
        center?.x += translation.x
        let x = (center?.x)! - left.x
        let y = (center?.y)! - left.y
        if (x*x + y*y) >= CGFloat(radius*radius) {
            center?.y -= translation.y
            center?.x -= translation.x
        }
        print(directionForX(x: x, y: y))
        recognizer.view?.center = center!
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        if recognizer.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.08, animations: {
                recognizer.view?.center = self.left
                self.leftHandle.image = UIImage(named: "btn_normal")
            })
        }
    }

    func rightPanFrom(recognizer:UIPanGestureRecognizer) -> Void {
        rightHandle.image = UIImage(named: "btn_pressed")
        let translation = recognizer.translation(in: self.view)
        var center = recognizer.view?.center
        center?.y += translation.y
        if (center?.y)! + 20 >= rightRect.size.height + rightRect.origin.y {
            center?.y = rightRect.size.height + rightRect.origin.y - 20
        }
        if center?.y <= rightRect.origin.y + 20 {
            center?.y = rightRect.origin.y + 20
        }
        recognizer.view?.center = center!
        let y = (center?.y)! - right.y
        if y < 0 {

        }
        if y > 0 {

        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        if recognizer.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.08, animations: {
                recognizer.view?.center = self.right
                self.rightHandle.image = UIImage(named: "btn_normal")
            })
        }

    }


    func directionForX(x:CGFloat,y:CGFloat) -> String {
        let a = Double(atan(y/x) * 180) / M_PI
        /**
         *  第一象限
         */
        if 0 <= x && y <= 0 {
            if (a > -22.5) {
                return  "right"
            }
            if -67.5 <= a && a <= -22.5 {
                return  "forwardright"
            }
            if a < -67.5 {
                return  "forward"
            }
        }
        /**
         *  第二象限
         */
        if 0 >= x && y <= 0 {
            if (a < 22.5) {
                return "left"
            }
            if 22.5 <= a && a <= 67.5 {
                return "forwardleft"
            }
            if 67.5 < a  {
                return "forward"
            }
        }
        /**
         *  第三象限
         */
        if 0 > x && y > 0 {
            if a > -22.5 {
                return "left"
            }
            if -22.5 >= a && a >= -67.5 {
                return "backwardleft"
            }
            if a < 67.5 {
                return "backward"
            }

        }
        /**
         *  第四象限
         */
        if 0 <= x && y > 0 {
            if a < 22.5 {
                return "right"
            }
            if 22.5 <= a && a <= 67.5 {
                return "backwardright"
            }
            if a > 67.5 {
                return "backward"
            }
        }
        return ""



    }


}

