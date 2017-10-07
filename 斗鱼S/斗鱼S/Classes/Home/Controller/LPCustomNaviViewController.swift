//
//  LPCustomNaviViewController.swift
//  斗鱼S
//
//  Created by trident on 2017/9/19.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class LPCustomNaviViewController: UINavigationController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //运行时机制查看该类的所有属性名称
//        var count : UInt32 = 0
//        let Ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count
//        {
//            
//            let ivar = Ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(cString: name!))
//            
//        }
        
        //系统手势
        guard let systemGes = self.interactivePopGestureRecognizer else {return}
        //系统手势所在的view
        guard let gesView = systemGes.view else {return}
        
        guard let myTargets = systemGes.value(forKey: "_targets") as? [NSObject] else {return}
        guard let myTargetObj = myTargets.first else {return}
        
        let action = Selector.init(("handleNavigationTransition:"))
        let target = myTargetObj.value(forKey: "target")
        
        let myPanGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(myPanGes)
        myPanGes.addTarget(target!, action: action)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
        
    }
    
}
