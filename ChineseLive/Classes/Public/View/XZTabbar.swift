//
//  XZTabbar.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/3.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit


protocol XZTabbarDelegate{
    func clickReleaseBtn(_ sender:UIButton) -> ()
 
}


class XZTabbar: UITabBar {

    var tabBarDelegate: XZTabbarDelegate?
    
    
      lazy var releaseBtn:tabBarBtn = {[weak self] in
        let releaseBtn = tabBarBtn.init()
        releaseBtn.frame = CGRect.init(x: 0, y: 0, width: 80, height: 60)
        releaseBtn.setImage(UIImage(named: "post_normal"), for: .normal)
        releaseBtn.addTarget(self, action: #selector(clickReleaseBtn(_:)), for: .touchUpInside)
        
        return releaseBtn
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension XZTabbar{
    
    func setupUI() ->() {
        backgroundImage = UIImage(named: "tabBarBg")
        isTranslucent = false;
        let topLine = UIImageView(image: UIImage(named: "tapbar_top_line"))
        addSubview(topLine)
        
    }
    
    override func layoutSubviews() {
        //取出tabbarBtn
        super.layoutSubviews()
        
        var tabBarArray = [UIView]()
        for tabBarBtn:UIView in subviews {
            if (tabBarBtn.isKind(of: (NSClassFromString("UITabBarButton"))!)){
                tabBarArray.append(tabBarBtn)
                
            }
        }
        
        
        let barW = bounds.size.width;
        let barH = bounds.size.height;
        let centerBtnW = releaseBtn.frame.width
        //设置中间按钮位置
        releaseBtn.center = CGPoint.init(x: barW/2, y: barH/2-ddSpacing(60))
        //重新布局其他TabBarButton
        let barItemW = (barW - centerBtnW)/CGFloat(tabBarArray.count)
        //逐个布局，修改frame
        for (index , subView) in tabBarArray.enumerated(){
            
            var frame = subView.frame
            if index >= tabBarArray.count/2{
                
                frame.origin.x = CGFloat(index) * barItemW + centerBtnW
                
            }else{
                frame.origin.x = CGFloat(index) * barItemW
            }
            //重新设置宽度
            frame.size.width = barItemW;
            subView.frame = frame;
            
        }
        
        //把中间a按钮添加到视图最上方
        addSubview(releaseBtn)
        
        
        
        
    }
    
    @objc func clickReleaseBtn(_ sender:UIButton) -> () {
        DDLog("点击发布")
        tabBarDelegate?.clickReleaseBtn(sender)
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.clipsToBounds || self.isHidden || (self.alpha == 0){
            return nil
        }
        
        var resultView = super.hitTest(point, with: event)
        //如果事件发生在tabbar里，直接返回
        if ((resultView) != nil) {
            return resultView;
        }
        
        //遍历超出部分
        for subView  in subviews {
            //把这个坐标从tabbar的坐标转成subView的坐标
            let subPoint = subView.convert(point, from: self)
            resultView = subView .hitTest(subPoint, with: event)
            //如果事件发生在subView里就直接返回
            if (resultView != nil) {
                return resultView;
            }
            
        }
        
        return nil
    }
    
    override var frame: CGRect{
        didSet{
            if ((self.superview != nil) && self.superview?.bounds.maxY != frame.maxY ) {
                frame.origin.y = self.superview!.bounds.height - frame.height
            }
            super.frame = frame
            
        }
    }
    
}




//自定义按钮
class tabBarBtn: UIButton {
    override var isHighlighted: Bool{
        set{
            
        }
        get{
           return false
        }
    }
}


