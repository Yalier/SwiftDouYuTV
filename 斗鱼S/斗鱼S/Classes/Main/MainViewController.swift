//
//  MainViewController.swift
//  斗鱼S
//
//  Created by trident on 2017/8/15.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

       
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
        
    }

    private func addChildVC(storyName:String)
    {
        
        let childVC = UIStoryboard.init(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVC)
        
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        
    }
    

   
}
