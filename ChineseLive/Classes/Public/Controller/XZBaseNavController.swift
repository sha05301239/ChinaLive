//
//  XZBaseNavController.swift
//  MoraGame
//
//  Created by 再出发 on 2018/9/27.
//  Copyright © 2018年 再出发. All rights reserved.
//

import UIKit

class XZBaseNavController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        interactivePopGestureRecognizer?.delegate = self;
        
        //        navigationBar.setBackgroundImage(UIImage(named: "navBlue.jpg"), for: .top, barMetrics: .default);
        navigationBar.setBackgroundImage(UIImage(named: "navBlue.jpg"), for: .default)
        //        navigationBar.barTintColor = ddBlueColor()
        view.backgroundColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.darkGray,NSAttributedString.Key.font:UIFont.systemFont(ofSize:18)];
        navigationBar.isTranslucent = false;//不透明
    }
    
    //重写push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count>0 {//不是第一层控制器，有父级控制器
            let leftbtn = UIButton(type: .custom)
            leftbtn.setTitle("返回", for: .normal)
            leftbtn.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
            leftbtn.addTarget(self, action: #selector(back), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftbtn)
            leftbtn.setTitleColor(UIColor.darkGray, for: .normal)
            leftbtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            leftbtn.setImage(UIImage(named: "back"), for: .normal)
            viewController.hidesBottomBarWhenPushed = true
            
        }else{
            
            
        }
        
        super.pushViewController(viewController, animated: true)
        
    }
    //返回手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return children.count>1
    }
    
    override var childForStatusBarStyle: UIViewController?{
        return topViewController;
    }
    
    
    @objc private func back(){
        self.popViewController(animated: true)
    }
    
}
