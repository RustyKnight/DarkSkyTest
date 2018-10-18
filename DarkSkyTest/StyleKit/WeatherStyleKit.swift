//
//  WeatherStyleKit.swift
//  Weather
//
//  Created by Shane Whitehead on 18/10/18.
//  Copyright © 2018 CompanyName. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class WeatherStyleKit : NSObject {

    //// Cache

    private struct Cache {
        static var imageOfWind: UIImage?
        static var windTargets: [AnyObject]?
        static var imageOfRain: UIImage?
        static var rainTargets: [AnyObject]?
    }

    //// Drawing Methods

    @objc dynamic public class func drawWindDirection(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50), resizing: ResizingBehavior = .aspectFit, direction: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 50, height: 50), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 50, y: resizedFrame.height / 50)


        //// Color Declarations
        let black = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let red = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let white = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Group
        //// Body
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 5, y: 5, width: 40, height: 40))
        black.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 25, y: 7))
        bezierPath.addLine(to: CGPoint(x: 25, y: 3))
        black.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        bezierPath.stroke()


        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.move(to: CGPoint(x: 25, y: 47))
        bezier6Path.addLine(to: CGPoint(x: 25, y: 43))
        black.setStroke()
        bezier6Path.lineWidth = 1
        bezier6Path.lineCapStyle = .round
        bezier6Path.lineJoinStyle = .round
        bezier6Path.stroke()


        //// Bezier 7 Drawing
        let bezier7Path = UIBezierPath()
        bezier7Path.move(to: CGPoint(x: 3, y: 25))
        bezier7Path.addLine(to: CGPoint(x: 7, y: 25))
        black.setStroke()
        bezier7Path.lineWidth = 1
        bezier7Path.lineCapStyle = .round
        bezier7Path.lineJoinStyle = .round
        bezier7Path.stroke()


        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.move(to: CGPoint(x: 43, y: 25.01))
        bezier8Path.addLine(to: CGPoint(x: 47, y: 25.01))
        black.setStroke()
        bezier8Path.lineWidth = 1
        bezier8Path.lineCapStyle = .round
        bezier8Path.lineJoinStyle = .round
        bezier8Path.stroke()




        //// Pointer
        context.saveGState()
        context.translateBy(x: 25, y: 25)
        context.rotate(by: -(direction + 45) * CGFloat.pi/180)



        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 9.2, y: -10))
        bezier3Path.addLine(to: CGPoint(x: 9.2, y: -10))
        bezier3Path.addCurve(to: CGPoint(x: 8.8, y: -9.87), controlPoint1: CGPoint(x: 9.06, y: -9.99), controlPoint2: CGPoint(x: 8.92, y: -9.95))
        bezier3Path.addLine(to: CGPoint(x: -2.22, y: -2.42))
        bezier3Path.addLine(to: CGPoint(x: -2.22, y: -2.42))
        bezier3Path.addCurve(to: CGPoint(x: -2.43, y: -2.22), controlPoint1: CGPoint(x: -2.3, y: -2.37), controlPoint2: CGPoint(x: -2.37, y: -2.3))
        bezier3Path.addLine(to: CGPoint(x: -9.87, y: 8.8))
        bezier3Path.addLine(to: CGPoint(x: -9.87, y: 8.8))
        bezier3Path.addCurve(to: CGPoint(x: -9.66, y: 9.87), controlPoint1: CGPoint(x: -10.11, y: 9.15), controlPoint2: CGPoint(x: -10.01, y: 9.63))
        bezier3Path.addCurve(to: CGPoint(x: -8.8, y: 9.87), controlPoint1: CGPoint(x: -9.4, y: 10.04), controlPoint2: CGPoint(x: -9.06, y: 10.04))
        bezier3Path.addLine(to: CGPoint(x: 2.22, y: 2.43))
        bezier3Path.addLine(to: CGPoint(x: 2.22, y: 2.43))
        bezier3Path.addCurve(to: CGPoint(x: 2.43, y: 2.22), controlPoint1: CGPoint(x: 2.3, y: 2.37), controlPoint2: CGPoint(x: 2.37, y: 2.3))
        bezier3Path.addLine(to: CGPoint(x: 9.87, y: -8.8))
        bezier3Path.addLine(to: CGPoint(x: 9.87, y: -8.8))
        bezier3Path.addCurve(to: CGPoint(x: 9.66, y: -9.87), controlPoint1: CGPoint(x: 10.11, y: -9.15), controlPoint2: CGPoint(x: 10.01, y: -9.63))
        bezier3Path.addCurve(to: CGPoint(x: 9.2, y: -10), controlPoint1: CGPoint(x: 9.53, y: -9.96), controlPoint2: CGPoint(x: 9.37, y: -10.01))
        bezier3Path.close()
        black.setFill()
        bezier3Path.fill()


        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 9.2, y: -10))
        bezier2Path.addLine(to: CGPoint(x: 9.2, y: -10))
        bezier2Path.addCurve(to: CGPoint(x: 8.8, y: -9.87), controlPoint1: CGPoint(x: 9.06, y: -9.99), controlPoint2: CGPoint(x: 8.92, y: -9.95))
        bezier2Path.addLine(to: CGPoint(x: -2.22, y: -2.42))
        bezier2Path.addLine(to: CGPoint(x: -2.22, y: -2.42))
        bezier2Path.addCurve(to: CGPoint(x: 2.43, y: 2.22), controlPoint1: CGPoint(x: -2.3, y: -2.37), controlPoint2: CGPoint(x: 2.37, y: 2.3))
        bezier2Path.addLine(to: CGPoint(x: 9.87, y: -8.8))
        bezier2Path.addLine(to: CGPoint(x: 9.87, y: -8.8))
        bezier2Path.addCurve(to: CGPoint(x: 9.66, y: -9.87), controlPoint1: CGPoint(x: 10.11, y: -9.15), controlPoint2: CGPoint(x: 10.01, y: -9.63))
        bezier2Path.addCurve(to: CGPoint(x: 9.2, y: -10), controlPoint1: CGPoint(x: 9.53, y: -9.96), controlPoint2: CGPoint(x: 9.37, y: -10.01))
        bezier2Path.close()
        red.setFill()
        bezier2Path.fill()


        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: -1.23, y: -1.23))
        bezier4Path.addLine(to: CGPoint(x: 1.23, y: 1.23))
        bezier4Path.addLine(to: CGPoint(x: -6.37, y: 6.37))
        bezier4Path.addLine(to: CGPoint(x: -1.23, y: -1.23))
        bezier4Path.close()
        white.setFill()
        bezier4Path.fill()



        context.restoreGState()
        
        context.restoreGState()

    }

    @objc dynamic public class func drawIcons8waterCanvas(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 48, height: 48), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 48, height: 48), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 48, y: resizedFrame.height / 48)


        //// Color Declarations
        let fillColor = UIColor(red: 0.392, green: 0.710, blue: 0.965, alpha: 1.000)
        let fillColor2 = UIColor(red: 0.733, green: 0.871, blue: 0.984, alpha: 1.000)

        //// surface1
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 37, y: 31))
        bezierPath.addCurve(to: CGPoint(x: 24, y: 44), controlPoint1: CGPoint(x: 37, y: 38.2), controlPoint2: CGPoint(x: 31.2, y: 44))
        bezierPath.addCurve(to: CGPoint(x: 11, y: 31), controlPoint1: CGPoint(x: 16.8, y: 44), controlPoint2: CGPoint(x: 11, y: 38.2))
        bezierPath.addCurve(to: CGPoint(x: 24, y: 4), controlPoint1: CGPoint(x: 11, y: 23.8), controlPoint2: CGPoint(x: 24, y: 4))
        bezierPath.addCurve(to: CGPoint(x: 37, y: 31), controlPoint1: CGPoint(x: 24, y: 4), controlPoint2: CGPoint(x: 37, y: 23.8))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()


        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 24, y: 39))
        bezier2Path.addCurve(to: CGPoint(x: 16, y: 31), controlPoint1: CGPoint(x: 19.6, y: 39), controlPoint2: CGPoint(x: 16, y: 35.4))
        bezier2Path.addCurve(to: CGPoint(x: 18, y: 29), controlPoint1: CGPoint(x: 16, y: 29.9), controlPoint2: CGPoint(x: 16.9, y: 29))
        bezier2Path.addCurve(to: CGPoint(x: 20, y: 31), controlPoint1: CGPoint(x: 19.1, y: 29), controlPoint2: CGPoint(x: 20, y: 29.9))
        bezier2Path.addCurve(to: CGPoint(x: 24, y: 35), controlPoint1: CGPoint(x: 20, y: 33.2), controlPoint2: CGPoint(x: 21.8, y: 35))
        bezier2Path.addCurve(to: CGPoint(x: 26, y: 37), controlPoint1: CGPoint(x: 25.1, y: 35), controlPoint2: CGPoint(x: 26, y: 35.9))
        bezier2Path.addCurve(to: CGPoint(x: 24, y: 39), controlPoint1: CGPoint(x: 26, y: 38.1), controlPoint2: CGPoint(x: 25.1, y: 39))
        bezier2Path.close()
        fillColor2.setFill()
        bezier2Path.fill()
        
        context.restoreGState()

    }

    @objc dynamic public class func drawWind(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 50, height: 50), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 50, y: resizedFrame.height / 50)


        //// Color Declarations
        let fillColor3 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 15.5, y: 4))
        bezierPath.addCurve(to: CGPoint(x: 9.15, y: 7.51), controlPoint1: CGPoint(x: 12.83, y: 4), controlPoint2: CGPoint(x: 10.48, y: 5.41))
        bezierPath.addLine(to: CGPoint(x: 9.16, y: 7.51))
        bezierPath.addCurve(to: CGPoint(x: 9.43, y: 8.9), controlPoint1: CGPoint(x: 8.85, y: 7.97), controlPoint2: CGPoint(x: 8.97, y: 8.59))
        bezierPath.addCurve(to: CGPoint(x: 10.82, y: 8.63), controlPoint1: CGPoint(x: 9.88, y: 9.21), controlPoint2: CGPoint(x: 10.51, y: 9.09))
        bezierPath.addCurve(to: CGPoint(x: 10.84, y: 8.58), controlPoint1: CGPoint(x: 10.82, y: 8.61), controlPoint2: CGPoint(x: 10.83, y: 8.6))
        bezierPath.addCurve(to: CGPoint(x: 15.5, y: 6), controlPoint1: CGPoint(x: 11.82, y: 7.03), controlPoint2: CGPoint(x: 13.53, y: 6))
        bezierPath.addCurve(to: CGPoint(x: 21, y: 11.65), controlPoint1: CGPoint(x: 18.6, y: 6), controlPoint2: CGPoint(x: 21.08, y: 8.53))
        bezierPath.addCurve(to: CGPoint(x: 15.2, y: 17), controlPoint1: CGPoint(x: 20.92, y: 14.65), controlPoint2: CGPoint(x: 18.26, y: 17))
        bezierPath.addLine(to: CGPoint(x: 4, y: 17))
        bezierPath.addLine(to: CGPoint(x: 4, y: 17))
        bezierPath.addCurve(to: CGPoint(x: 2.99, y: 17.98), controlPoint1: CGPoint(x: 3.45, y: 16.99), controlPoint2: CGPoint(x: 3, y: 17.43))
        bezierPath.addCurve(to: CGPoint(x: 3.97, y: 19), controlPoint1: CGPoint(x: 2.98, y: 18.53), controlPoint2: CGPoint(x: 3.42, y: 18.99))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 19), controlPoint1: CGPoint(x: 3.98, y: 19), controlPoint2: CGPoint(x: 3.99, y: 19))
        bezierPath.addLine(to: CGPoint(x: 15.2, y: 19))
        bezierPath.addCurve(to: CGPoint(x: 23, y: 11.7), controlPoint1: CGPoint(x: 19.29, y: 19), controlPoint2: CGPoint(x: 22.89, y: 15.84))
        bezierPath.addCurve(to: CGPoint(x: 15.5, y: 4), controlPoint1: CGPoint(x: 23.11, y: 7.48), controlPoint2: CGPoint(x: 19.7, y: 4))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 38, y: 8))
        bezierPath.addCurve(to: CGPoint(x: 30.12, y: 12.64), controlPoint1: CGPoint(x: 34.62, y: 8), controlPoint2: CGPoint(x: 31.66, y: 9.87))
        bezierPath.addLine(to: CGPoint(x: 30.12, y: 12.64))
        bezierPath.addCurve(to: CGPoint(x: 30.51, y: 14.01), controlPoint1: CGPoint(x: 29.86, y: 13.13), controlPoint2: CGPoint(x: 30.03, y: 13.74))
        bezierPath.addCurve(to: CGPoint(x: 31.88, y: 13.61), controlPoint1: CGPoint(x: 31, y: 14.27), controlPoint2: CGPoint(x: 31.61, y: 14.1))
        bezierPath.addLine(to: CGPoint(x: 31.88, y: 13.61))
        bezierPath.addCurve(to: CGPoint(x: 38, y: 10), controlPoint1: CGPoint(x: 33.07, y: 11.46), controlPoint2: CGPoint(x: 35.35, y: 10))
        bezierPath.addCurve(to: CGPoint(x: 44.99, y: 17.43), controlPoint1: CGPoint(x: 42.02, y: 10), controlPoint2: CGPoint(x: 45.23, y: 13.35))
        bezierPath.addCurve(to: CGPoint(x: 37.69, y: 24), controlPoint1: CGPoint(x: 44.76, y: 21.16), controlPoint2: CGPoint(x: 41.47, y: 24))
        bezierPath.addLine(to: CGPoint(x: 4, y: 24))
        bezierPath.addLine(to: CGPoint(x: 4, y: 24))
        bezierPath.addCurve(to: CGPoint(x: 2.99, y: 24.98), controlPoint1: CGPoint(x: 3.45, y: 23.99), controlPoint2: CGPoint(x: 3, y: 24.43))
        bezierPath.addCurve(to: CGPoint(x: 3.97, y: 26), controlPoint1: CGPoint(x: 2.98, y: 25.53), controlPoint2: CGPoint(x: 3.42, y: 25.99))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 26), controlPoint1: CGPoint(x: 3.98, y: 26), controlPoint2: CGPoint(x: 3.99, y: 26))
        bezierPath.addLine(to: CGPoint(x: 37.69, y: 26))
        bezierPath.addCurve(to: CGPoint(x: 46.98, y: 17.55), controlPoint1: CGPoint(x: 42.47, y: 26), controlPoint2: CGPoint(x: 46.69, y: 22.38))
        bezierPath.addCurve(to: CGPoint(x: 38, y: 8), controlPoint1: CGPoint(x: 47.3, y: 12.35), controlPoint2: CGPoint(x: 43.14, y: 8))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 4, y: 31))
        bezierPath.addLine(to: CGPoint(x: 4, y: 31))
        bezierPath.addCurve(to: CGPoint(x: 2.99, y: 31.98), controlPoint1: CGPoint(x: 3.45, y: 30.99), controlPoint2: CGPoint(x: 3, y: 31.43))
        bezierPath.addCurve(to: CGPoint(x: 3.97, y: 33), controlPoint1: CGPoint(x: 2.98, y: 32.53), controlPoint2: CGPoint(x: 3.42, y: 32.99))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 33), controlPoint1: CGPoint(x: 3.98, y: 33), controlPoint2: CGPoint(x: 3.99, y: 33))
        bezierPath.addLine(to: CGPoint(x: 25.2, y: 33))
        bezierPath.addCurve(to: CGPoint(x: 31, y: 38.35), controlPoint1: CGPoint(x: 28.26, y: 33), controlPoint2: CGPoint(x: 30.92, y: 35.35))
        bezierPath.addCurve(to: CGPoint(x: 25.5, y: 44), controlPoint1: CGPoint(x: 31.08, y: 41.47), controlPoint2: CGPoint(x: 28.6, y: 44))
        bezierPath.addCurve(to: CGPoint(x: 20.85, y: 41.42), controlPoint1: CGPoint(x: 23.53, y: 44), controlPoint2: CGPoint(x: 21.82, y: 42.97))
        bezierPath.addLine(to: CGPoint(x: 20.84, y: 41.42))
        bezierPath.addCurve(to: CGPoint(x: 19.47, y: 41.07), controlPoint1: CGPoint(x: 20.56, y: 40.94), controlPoint2: CGPoint(x: 19.94, y: 40.79))
        bezierPath.addCurve(to: CGPoint(x: 19.13, y: 42.45), controlPoint1: CGPoint(x: 19, y: 41.36), controlPoint2: CGPoint(x: 18.84, y: 41.97))
        bezierPath.addCurve(to: CGPoint(x: 19.16, y: 42.49), controlPoint1: CGPoint(x: 19.14, y: 42.46), controlPoint2: CGPoint(x: 19.15, y: 42.48))
        bezierPath.addCurve(to: CGPoint(x: 25.5, y: 46), controlPoint1: CGPoint(x: 20.48, y: 44.59), controlPoint2: CGPoint(x: 22.83, y: 46))
        bezierPath.addCurve(to: CGPoint(x: 33, y: 38.3), controlPoint1: CGPoint(x: 29.7, y: 46), controlPoint2: CGPoint(x: 33.11, y: 42.52))
        bezierPath.addCurve(to: CGPoint(x: 25.2, y: 31), controlPoint1: CGPoint(x: 32.89, y: 34.16), controlPoint2: CGPoint(x: 29.29, y: 31))
        bezierPath.addLine(to: CGPoint(x: 4, y: 31))
        bezierPath.close()
        fillColor3.setFill()
        bezierPath.fill()
        
        context.restoreGState()

    }

    @objc dynamic public class func drawRain(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 50, height: 50), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 50, y: resizedFrame.height / 50)


        //// Color Declarations
        let fillColor3 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// surface1
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 25, y: 46.88))
        bezierPath.addCurve(to: CGPoint(x: 10.12, y: 32), controlPoint1: CGPoint(x: 16.8, y: 46.88), controlPoint2: CGPoint(x: 10.12, y: 40.2))
        bezierPath.addCurve(to: CGPoint(x: 24.27, y: 2.52), controlPoint1: CGPoint(x: 10.12, y: 24.1), controlPoint2: CGPoint(x: 23.69, y: 3.39))
        bezierPath.addCurve(to: CGPoint(x: 25.73, y: 2.52), controlPoint1: CGPoint(x: 24.59, y: 2.03), controlPoint2: CGPoint(x: 25.41, y: 2.03))
        bezierPath.addCurve(to: CGPoint(x: 39.88, y: 32), controlPoint1: CGPoint(x: 26.31, y: 3.39), controlPoint2: CGPoint(x: 39.88, y: 24.1))
        bezierPath.addCurve(to: CGPoint(x: 25, y: 46.88), controlPoint1: CGPoint(x: 39.88, y: 40.2), controlPoint2: CGPoint(x: 33.2, y: 46.88))
        bezierPath.close()
        fillColor3.setFill()
        bezierPath.fill()
        
        context.restoreGState()

    }

    //// Generated Images

    @objc dynamic public class func imageOfWindDirection(direction: CGFloat = 0) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 50, height: 50), false, 0)
            WeatherStyleKit.drawWindDirection(direction: direction)

        let imageOfWindDirection = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfWindDirection
    }

    @objc dynamic public class var imageOfWind: UIImage {
        if Cache.imageOfWind != nil {
            return Cache.imageOfWind!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 50, height: 50), false, 0)
            WeatherStyleKit.drawWind()

        Cache.imageOfWind = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfWind!
    }

    @objc dynamic public class var imageOfRain: UIImage {
        if Cache.imageOfRain != nil {
            return Cache.imageOfRain!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 50, height: 50), false, 0)
            WeatherStyleKit.drawRain()

        Cache.imageOfRain = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfRain!
    }

    //// Customization Infrastructure

    @objc @IBOutlet dynamic var windTargets: [AnyObject]! {
        get { return Cache.windTargets }
        set {
            Cache.windTargets = newValue
            for target: AnyObject in newValue {
                let _ = target.perform(NSSelectorFromString("setImage:"), with: WeatherStyleKit.imageOfWind)
            }
        }
    }

    @objc @IBOutlet dynamic var rainTargets: [AnyObject]! {
        get { return Cache.rainTargets }
        set {
            Cache.rainTargets = newValue
            for target: AnyObject in newValue {
                let _ = target.perform(NSSelectorFromString("setImage:"), with: WeatherStyleKit.imageOfRain)
            }
        }
    }




    @objc(WeatherStyleKitResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}