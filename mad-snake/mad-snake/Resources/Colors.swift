//
//  Colors.swift
//  mad-snake
//
//  Created by Pavel on 17.08.2025.
//
import UIKit

extension UIColor {
    
    static var gameFieldViewColor: UIColor {
            return UIColor(red: 81/255.0, green: 216/255.0, blue: 135/255.0, alpha: 1.0)
        }
    
    static var gameMainViewColor: UIColor {
            return UIColor(red: 39/255.0, green: 39/255.0, blue: 39/255.0, alpha: 1.0)
        }
    
    static var playButtonsColor: UIColor {
            return UIColor(red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0)
        }
    
    static var snakeHeadColor: UIColor {
        return UIColor(red: 29/255.0, green: 71/255.0, blue: 34/255.0, alpha: 1.0)
    }
    
    static var snakeTailColor: UIColor {
        return UIColor(red: 53/255.0, green: 120/255.0, blue: 60/255.0, alpha: 1.0)
    }
    
    static var foodColor: UIColor {
        return UIColor(red: 199/255.0, green: 8/255.0, blue: 65/255.0, alpha: 1.0)
    }
}
