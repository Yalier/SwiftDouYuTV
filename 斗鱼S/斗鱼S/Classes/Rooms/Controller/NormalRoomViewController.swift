//
//  NormalRoomViewController.swift
//  斗鱼S
//
//  Created by trident on 2017/9/19.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class NormalRoomViewController: UIViewController, UIGestureRecognizerDelegate
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
    
        super.viewWillAppear(animated)
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //保持pop手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

    
}
