//
//  XZBaseVC.swift
//  MoraGame
//
//  Created by 再出发 on 2018/9/25.
//  Copyright © 2018年 再出发. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
class XZBaseVC: UIViewController {

    //加载中
    var isLoading = false
    
    
    
    lazy var myNavBar: WRCustomNavigationBar = {
        
       let myNavBar = WRCustomNavigationBar.CustomNavigationBar()
       return myNavBar;
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//       self.view .addSubview(self.myNavBar)
        self.view.backgroundColor = UIColor.white
        statusBarStyle = .default
        navBarShadowImageHidden = true
        // 设置导航栏默认的背景颜色
        
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }

    /*
 // 一行代码搞定导航栏颜色
 navBarBarTintColor = .white
 // 一行代码搞定导航栏透明度
 navBarBackgroundAlpha = alpha
 // 一行代码搞定导航栏两边按钮颜色
 navBarTintColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
 // 一行代码搞定导航栏上标题颜色
 navBarTitleColor = .black
 // 一行代码搞定状态栏是 default 还是 lightContent
 statusBarStyle = .default
 // 一行代码搞定导航栏底部分割线是否隐藏
 navBarShadowImageHidden = true;
 
 // 设置导航栏默认的背景颜色
 UIColor.defaultNavBarBarTintColor = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
 // 设置导航栏所有按钮的默认颜色
 UIColor.defaultNavBarTintColor = .white
 // 设置导航栏标题默认颜色
 UIColor.defaultNavBarTitleColor = .white
 // 统一设置状态栏样式
 UIColor.defaultStatusBarStyle = .lightContent
 // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
 UIColor.defaultShadowImageHidden = true
 */
    
    
    
}


extension XZBaseVC:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    
    
    
    /**
     *空白页标题(注：
     1：该标题并不是页面的标题，是提示视图的标题
     2：必须返回富文本（可设置其颜色，字号，风格等。或：nil))
     */
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: "", attributes: nil)
        let str = "洪荒之力"
        return NSAttributedString.init(string: str, attributes: nil)
    }
    /**
     *空白正文(注：
     必须返回富文本（可设置其颜色，字号，风格等。或：nil，方法同上))
     */
    
    public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "玩命加载中"
        return NSAttributedString.init(string: str, attributes: nil)
    }
    
    /**
     *(空白页图片)注：
     如果直接返回图片，显示的图片会是图片原本的尺寸。可以在该方法中重置图片大小再return。
     */
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "loading_imgBlue_78x78")
    }
    /**空白页颜色e色调（注：
     * 该方法一般不用，默认为nil）
     */
    
//    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
//        DDLog("scrollViewscrollView = \(String(describing: scrollView))")
//        if self.isLoading {
//            return nil
//        }else{
//            let customView = XZEmptyHomeView.init(frame:scrollView.bounds)
//
//            return customView
//        }
//
//
//    }
//
    public func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return nil
    }
    /**
     *空白页图片（视图）动画(注：
     该方法是设置图片或视图的动画，可设置动画组CAAnimationGroup)
     */
    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        
//         CABasicAnimation *animation = [CABasicAnimation         animationWithKeyPath: @"transform"];
        
//         animation.fromValue = [NSValue                  valueWithCATransform3D:CATransform3DIdentity];
//         animation.toValue = [NSValue   valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
//
//         animation.duration = 0.25;
//         animation.cumulative = YES;
//         animation.repeatCount = MAXFLOAT;
//
//         return animation;
        
        let animation = CABasicAnimation(keyPath: "transform")
        //开始位置
        animation.fromValue = CATransform3DIdentity
        //结束位置
        animation.toValue = CATransform3DMakeRotation(CGFloat(Double.pi/2), 0.0, 0.0, 1.0)
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT
        return animation
//        return nil
    }
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0 //整体位置
    }
    public func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0  //标题、图片位置
    }
    
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.white
    }
    
     
    //MARK:--DZNEmptyDataSetDelegate Methods
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return self.isLoading
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.isLoading = false
        }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.isLoading = false
        }
        
    }
    
    
    
}
