//
//  XZMyPickerView.swift
//  PaySimulator
//
//  Created by 再出发 on 2018/9/5.
//  Copyright © 2018年 再出发. All rights reserved.
//

import UIKit
import SDCycleScrollView

//contentView区域的高度
let kContentViewH : CGFloat = kWindowH

//定义选择结果block
//点击图片传递index
typealias clickImgBlock = (_ index:Int)->()
typealias finishBlock = ((_ selectorStr : String)->())
class XZMyPickerView: UIView {

    //公开数据源属性，外界传入
    var componentsArray : [[String]]?//多少列
    var cycView : SDCycleScrollView?
    
    var currentStr = ""
    //block属性
    var clickFinishBlock : finishBlock?
    var clickImgIndexBlock : clickImgBlock?
    
    
    //懒加载titleLabel
    var titleLabe :  UILabel = {
       let labe = UILabel()
        labe.textColor = UIColor.darkGray
        labe.font = UIFont.systemFont(ofSize: 15)
        labe.textAlignment = .center
        return  labe
        
    }()
    
    
    
    
    //白色contentView
    lazy var myContentView : UIView = {
        let myContentView = UIView(frame: CGRect(x: 0, y: kWindowH, width: kWindowW, height: kContentViewH))
//        myContentView.backgroundColor = ddRandomColor()//随机颜色
        myContentView.backgroundColor = ddColor(255, 255, 255)//随机颜色
        /*
        myContentView.addSubview(myPickerView)
        myPickerView.snp.makeConstraints({ (make) in
            make.top.equalTo(40)
            make.bottom.equalTo(-40)
            make.left.right.equalTo(myContentView)
        })
 */
        cycView = SDCycleScrollView.init(frame: CGRect.zero, delegate: self, placeholderImage: nil)
        myContentView.addSubview(cycView!)
        cycView?.snp.makeConstraints({ (make) in
            /*
            make.top.equalTo(40)
            make.bottom.equalTo(-40)
            make.left.right.equalTo(myContentView)
             */
             make.edges.equalToSuperview()
        })
        
        
        //取消按钮
        let canlecBtn = UIButton()
        canlecBtn.setTitle("取消", for: .normal)
        canlecBtn.setTitleColor(UIColor.darkGray, for: .normal)
        canlecBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        canlecBtn.addTarget(self, action: #selector(clickCancleBtn), for: .touchUpInside)
        canlecBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
//        myContentView.addSubview(canlecBtn)
        //确认按钮
        let finishBtn = UIButton()
        finishBtn.setTitle("确定", for: .normal)
        finishBtn.setTitleColor(UIColor.darkGray, for: .normal)
        finishBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        finishBtn.addTarget(self, action: #selector(clickFinishBtn), for: .touchUpInside)
        finishBtn.frame = CGRect(x: kWindowW-60, y: 0, width: 60, height: 40)
//        myContentView.addSubview(finishBtn)
     
        //titleLabel
        /*
         myContentView.addSubview(titleLabe)
        titleLabe.snp.makeConstraints({ (make) in
            make.left.equalTo(canlecBtn.snp.right)
            make.right.equalTo(finishBtn.snp.left)
            make.top.bottom.equalTo(canlecBtn)
        })
        */
           return myContentView
    }()
    
    
    //初始化
    override init(frame: CGRect) {
       super.init(frame: frame)
       backgroundColor = ddColorA(2, 2, 2, 160)//黑色遮罩
       self.isUserInteractionEnabled = true
       //添加遮罩点击事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickBJView))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK:--UI相关
extension XZMyPickerView : UIGestureRecognizerDelegate{
    
    private func setupUI(){
//        addSubview(myContentView)
        
    }
    
    //外部调用show方法
    func pickerShow(superView : UIView?){
        if superView == nil {
            return
        }
        
        superView?.addSubview(self)
        self.addSubview(myContentView)
        
 
        UIView.animate(withDuration: 0.2, animations: {
            
            self.alpha = 1.0
//            self.myContentView.frame = CGRect(x: 0, y: kWindowH-kContentViewH, width: kWindowW, height: kContentViewH)
            self.myContentView.frame = CGRect(x: 0, y: kWindowH/2-kContentViewH/2, width: kWindowW, height: kContentViewH)
            
        }) { (finish) in
            
//            self.myPickerView.reloadAllComponents()
        }
    }
    
    //外部dismiss方法
    func pickerDismiss(){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.myContentView.frame = CGRect(x: 0, y: kWindowH, width: kWindowW, height: kContentViewH)
            self.alpha = 0;
        }) { (finish) in
            
            if finish {
                self.removeFromSuperview()
                self.myContentView.removeFromSuperview()
            }
            
        }
    }
    
    
    
    
    
    
    //黑色背景点击事件
    @objc private func clickBJView(){
        pickerDismiss()
    }
    
    //点击取消按钮
    @objc private func clickCancleBtn(){
        
        pickerDismiss()
    }
    
    //点击确定按钮
    @objc private func clickFinishBtn(){
        DDLog("当前选择的是 \(currentStr)")
        guard let clickFinishBlock = clickFinishBlock else {
            return
        }
        clickFinishBlock(currentStr)
          pickerDismiss()
    }
    
    
    
    //MARK:--手势代理，子视图不响应父视图点击
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard let touchView = touch.view else {
            return false
        }
        
        if touchView.isDescendant(of: myContentView) {
            return false
        }
 
        return true
    }
    
}

//MARK:--cycScrollerView
extension  XZMyPickerView : SDCycleScrollViewDelegate{
    
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didScrollTo index: Int) {
//        DDLog("h当前滑动第\(index)个图片")
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
         DDLog("h当前点击第\(index)个图片")
        
        guard let clickImgIndexBlock = clickImgIndexBlock else { return  }
        clickImgIndexBlock(index)
        
    }
}




