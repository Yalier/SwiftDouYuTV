//
//  UIBarButtonItem-Extension.swift
//  斗鱼S
//
//  Created by trident on 2017/8/17.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

extension UIBarButtonItem
{
    
//    class func createItem(imageName:String, highImageName:String, size:CGSize)->UIBarButtonItem
//    {
//        
//        let btn = UIButton()
//        btn.setImage(UIImage.init(named: imageName), for: .normal)
//        btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
//        btn.frame = CGRect.init(origin: CGPoint.zero, size: size)
//        
//        return UIBarButtonItem.init(customView: btn)
//        
//    }
    
    //便利构造函数：1 convenience开头 2 在构造函数中必须明确调用一个设计的构造函数
    convenience init(imageName:String, highImageName:String = "", size:CGSize = CGSize.zero)
    {
        
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        
        if highImageName != ""
        {
            btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero
        {
            btn.sizeToFit()
        }
        else
        {
            btn.frame = CGRect.init(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)

    }
    
    
}
