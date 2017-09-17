//
//  UIColor-Extension.swift
//  斗鱼S
//
//  Created by trident on 2017/8/21.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

extension UIColor
{
    
    
    convenience init(r:CGFloat, g:CGFloat, b:CGFloat)
    {
        
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
        
    }
    
    
    class func myRandomColor() -> UIColor
    {
        
        return UIColor.init(r: CGFloat(arc4random_uniform(UInt32(255.0))), g: CGFloat(arc4random_uniform(UInt32(255.0))), b: CGFloat(arc4random_uniform(UInt32(255.0))))
        
    }
    
    
}
