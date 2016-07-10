//
//  FaceView.swift
//  Happiness
//
//  Created by Yapzi on 16/6/11.
//  Copyright © 2016年 Yap. All rights reserved.
//

import UIKit

protocol FaceViewDataSource: class {
    func smilinessForFaceView(faceView: FaceView) -> Double?
}

@IBDesignable

class FaceView: UIView {
    
    
    
    var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius: CGFloat {
        return min(bounds.width, bounds.height) / 2 * scale
    }
    
    var scale: CGFloat = 0.90 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lineWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var color = UIColor.redColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    weak var dataSource: FaceViewDataSource?
    
    private struct scaling {
        static let faceRadiusToEyeRadiusRatio: CGFloat = 10
        static let faceRadiusTOEyeOffsetRatio: CGFloat = 3
        static let faceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let faceRadiusToMouthWidth: CGFloat = 1
        static let faceRadiusToMouthHeight: CGFloat = 3
        static let faceRadiusToMouthOffsetRatio: CGFloat = 3
    }

    private enum Eye {
        case Left, Right
    }

    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
        let eyeRadius = faceRadius / scaling.faceRadiusToEyeRadiusRatio
        let eyeOffset = faceRadius / scaling.faceRadiusTOEyeOffsetRatio
        let eyeSeparation = faceRadius / scaling.faceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeOffset
        switch whichEye {
        case .Left:
            eyeCenter.x -= eyeSeparation / 2
        default:
            eyeCenter.x += eyeSeparation / 2
        }
        let eyePath = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        eyePath.lineWidth = lineWidth
        return eyePath
    }
    
    private func  bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath {
        let mouthWidth = faceRadius / scaling.faceRadiusToMouthWidth
        let mouthHeight = faceRadius / scaling.faceRadiusToMouthHeight
        let mouthOffset = faceRadius / scaling.faceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(min(max(fractionOfMaxSmile, -1), 1)) * mouthHeight
        
        let startPoint = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthOffset)
        let cp1 = CGPoint(x: startPoint.x + mouthWidth / 3, y: startPoint.y + smileHeight)
        let endPoint = CGPoint(x: faceCenter.x + mouthWidth / 2, y: startPoint.y)
        let cp2 = CGPoint(x: endPoint.x - mouthWidth / 3, y: cp1.y)
        
        let mouthPath = UIBezierPath()
        mouthPath.moveToPoint(startPoint) // 定位到 startPoint
        mouthPath.addCurveToPoint(endPoint, controlPoint1: cp1, controlPoint2: cp2) // 画曲线
        mouthPath.lineWidth = lineWidth
        return mouthPath
    }
    
    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0.0, endAngle:CGFloat(2 * M_PI), clockwise: true)
        
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
        let smiliness = dataSource?.smilinessForFaceView(self) ?? 0.0
        let smilePath = bezierPathForSmile(smiliness)
        smilePath.stroke()
        // Drawing code
    }
    
    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == UIGestureRecognizerState.Changed {
            scale *= gesture.scale
            gesture.scale = 1 // 保证下次 Pinch 的时候改变的scale系数一样
        }
    }
    
}
