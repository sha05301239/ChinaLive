//
//  XZLoginVC.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/4.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZLoginVC: XZBaseVC {

    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var wechatBtn: UIButton!
    
    @IBOutlet weak var faceBookBtn: UIButton!
    
    @IBOutlet weak var lineBtn: UIButton!
    
    @IBOutlet weak var huarenServerBtn: UIButton!
    
    @IBOutlet weak var privacyBtn: UIButton!//隐私政策
    
    @IBOutlet weak var phoneAddressBtn: UIButton!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var codeTF: UITextField!
   
    @IBOutlet weak var sendCodeBtn: UIButton!//发送验证码
    
    @IBOutlet weak var bottomView: UIView!
    
    lazy var selectBJView : UIView = {[weak self] in
        
        let bjView = UIView.init(frame: self!.view.bounds)
        
        let selectView = XZLoginSelectCountryView(frame: CGRect.zero)

        selectView.clickCellBlock={(titleStr) in
            DDLog("titleStr = \(titleStr)")
            self?.phoneAddressBtn.setTitle(titleStr, for: .normal)
            
            bjView.removeFromSuperview()
        }
        
    
        bjView.addSubview(selectView)
      
        let phoneBottom = self?.phoneAddressBtn.bounds.maxY
        DDLog("phoneBottom = \(String(describing: phoneBottom))")
        let phoneX = self?.phoneAddressBtn.bounds.minX
        DDLog("phoneX = \(String(describing: phoneX))")
        let superReact = phoneAddressBtn.superview?.convert(phoneAddressBtn.frame, to: self?.view)
        
        print("superReact = \(String(describing: superReact))")
        selectView.snp.makeConstraints({ (make) in
            make.top.equalTo(superReact?.maxY ?? 0)
            make.left.equalTo((superReact?.minX)!)
            make.width.equalTo(ddSpacing(120))
            make.height.equalTo(ddSpacing(400))
        })
        
        return bjView
        
    }()
    
    
    var selectView : XZLoginSelectCountryView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.loginBtn.isHidden = true;
        //选择手机区号
        self.phoneAddressBtn.addTarget(self, action: #selector(clickPhoneAddressBtn(_:)), for: .touchUpInside)
        
        self.sendCodeBtn.layer.cornerRadius = 5;
 
        //发送验证码
        self.sendCodeBtn.addTarget(self, action: #selector(clickSendBtn(_:)), for: .touchUpInside)
        
        
        
    }


   
}


extension XZLoginVC{
    
    
    //选择区号
    @objc private func clickPhoneAddressBtn(_ sendrt : UIButton){
  
        self.view.addSubview(self.selectBJView)
        self.selectBJView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        selectView = XZLoginSelectCountryView(frame: CGRect.zero)
//        self.view.addSubview(selectView!)
//
//        selectView!.snp.makeConstraints({ (make) in
//            make.top.equalTo(self.phoneAddressBtn.snp.bottom)
//            make.left.equalTo(self.phoneAddressBtn)
//            make.width.equalTo(ddSpacing(110))
//            make.height.equalTo(ddSpacing(260))
//        })
        
        
    }
    
    //发送验证码
    @objc private func clickSendBtn(_ sender:UIButton){
        
        sender.countDown(count: 60, UIColor.lightGray, UIColor.groupTableViewBackground)
        
        
        
        
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.selectBJView.removeFromSuperview()
    }
    
    
}



//MARK:--按钮倒计时
extension UIButton{
    
    func countDown(count:Int,_ titleColor:UIColor,_ backColor:UIColor){
        //倒计时开始，
        self.isEnabled = false;
        //保存当前背景颜色和title颜色
        let defaultBackColor = self.backgroundColor
        let defaultTitleColor = self.currentTitleColor
        //倒计时颜色
        self.backgroundColor = backColor;
        self.setTitleColor(titleColor, for: .normal)
        
        var remainCount : Int = count{
            
            willSet{
                self.setTitle("重新发送\(newValue)", for: .normal)
                if newValue <= 0{
                    self.setTitle("获取验证码", for: .normal)
                }
            }
            
        }
        
        //创建定时器
        let codeTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        //每秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(),repeating: .seconds(1))
        //设定时间源的触发事件
        codeTimer.setEventHandler {
            
            //回到主线程更新UI
            DispatchQueue.main.async {
                //每秒计时一次
                remainCount -= 1;
                //时间到了取消时间源
                if remainCount <= 0{
                    self.backgroundColor = defaultBackColor;
                    self.setTitleColor(defaultTitleColor, for: .normal)
                    self.isEnabled = true
                    codeTimer.cancel()
                }
                
                
            }
            
            
        }
        
        //启动定时器
        codeTimer.resume()
        
        
    }
    
    
}





