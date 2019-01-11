//
//  XZTabBarVC.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/3.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //设置UITabbarItem的文字属性
        setupItemTextAttrs()
        //添加子控制器
        setupChildViewControllers(XZHomeVC.init(), "首页", "home_normal", "home_highlight")
        setupChildViewControllers(UIViewController.init(), "title1", "home_normal", "home_highlight")
        setupChildViewControllers(UIViewController.init(), "title2", "home_normal", "home_highlight")
        setupChildViewControllers(UIViewController.init(), "title3", "home_normal", "home_highlight")
//        setupChildViewControllers(UIViewController.init(), "title4", "home_normal", "home_highlight")
        
        setupTabBar()//更换tabBar
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension XZTabBarVC:XZTabbarDelegate{
    //XZTabbarDelegate
    func clickReleaseBtn(_ sender: UIButton) {
        
        
        DDLog("XZTabbarVC");
        
    }
    
    //文字全球化
    func setupItemTextAttrs() -> () {
        
        let item = UITabBarItem.appearance()
        //设置普通状态下的文字属性
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:ddColorFromHex("0x2e95fc")], for: .selected)
        item.setTitleTextAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13)], for: .selected)
        
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        
    }
    //添加子控制器私有方法
    func setupChildViewControllers(_ childVC:UIViewController,_ title:String,_ imageName:String,_ selectImgName:String) -> () {
        childVC.tabBarItem.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: selectImgName)?.withRenderingMode(.alwaysOriginal)
        childVC.view.backgroundColor = ddRandomColor()
        //讲vc添加进来
        addChild(childVC)
        
    }
    
    //更换tabbar
    
    func setupTabBar() -> () {
        let xzTabbar = XZTabbar(frame: self.tabBar.bounds)
        xzTabbar.tabBarDelegate = self
        self .setValue(xzTabbar, forKey: "tabBar")
    }
    
   
    
    
    
    
    
}
