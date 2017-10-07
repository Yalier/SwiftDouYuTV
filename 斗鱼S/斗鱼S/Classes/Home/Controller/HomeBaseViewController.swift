//
//  HomeBaseViewController.swift
//  斗鱼S
//
//  Created by trident on 2017/9/18.
//  Copyright © 2017年 trident. All rights reserved.
//

import UIKit

class HomeBaseViewController: UIViewController
{
    
    var contentView : UIView?
    
    lazy var baseImageIV : UIImageView = {[weak self] in
        
        
        let imageV = UIImageView.init(image: UIImage.init(named: "dyla_img_loading_1"))
        
        imageV.center = (self?.view.center)!
        imageV.animationDuration = 0.5
        imageV.animationRepeatCount = LONG_MAX
        imageV.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        
        imageV.animationImages = [UIImage.init(named: "dyla_img_loading_1")!, UIImage.init(named: "dyla_img_loading_2")!, UIImage.init(named: "dyla_img_loading_3")!, UIImage.init(named: "dyla_img_loading_4")!]
        
        
        return imageV
        
    }()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        contentView?.isHidden = true
        view.addSubview(baseImageIV)
        baseImageIV.startAnimating()
        
        view.backgroundColor = UIColor.white
        
        
    }
    
    
    func amationFinish()
    {
        
        baseImageIV.stopAnimating()
        baseImageIV.isHidden = true
        contentView?.isHidden = false
        
    }
 

}
