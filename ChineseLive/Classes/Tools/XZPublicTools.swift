//
//  XZPublicTools.swift
//  PaySimulator
//
//  Created by zzz on 2018/9/7.
//  Copyright © 2018年 再出发. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView
import SCLAlertView


let kSuccessTitle = "提示"
let kErrorTitle = "提示"
let kNoticeTitle = " 提醒"
let kWarningTitle = "警告"
let kInfoTitle = "详情"

let kDefaultAnimationDuration = 2.0

class XZPublicTools: NSObject {
    
    private static let shareInstance : XZPublicTools = XZPublicTools()
    
    private override init(){}
    
    //确保唯一性，通过此类方法创建对象
    class var shareSingleton: XZPublicTools {
        return shareInstance;
    }
}



//加载提示
extension XZPublicTools {
    
    //显示加载中提示
    func showLoading (title : String = "加载中...")  {
        let size = CGSize(width: 30, height: 30)
        startAnimating(size, message: title, type: NVActivityIndicatorType(rawValue: 1)!, fadeInAnimation: nil)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 20) {
            self.stopAnimating()
        }
    }
    
    //更改加载中提示 title
    func setLoadMessage(_ message : String) {
        NVActivityIndicatorPresenter.sharedInstance.setMessage(message)
    }
    
    
    //隐藏加载
    func hideLoad ()  {
        self.stopAnimating()
    }
}

 extension XZPublicTools {
    /// Current status of animation, read-only.
    var isAnimating: Bool { return NVActivityIndicatorPresenter.sharedInstance.isAnimating }
    
    /**
     Display UI blocker.
     
     Appropriate NVActivityIndicatorView.DEFAULT_* values are used for omitted params.
     
     - parameter size:                 size of activity indicator view.
     - parameter message:              message displayed under activity indicator view.
     - parameter messageFont:          font of message displayed under activity indicator view.
     - parameter type:                 animation type.
     - parameter color:                color of activity indicator view.
     - parameter padding:              padding of activity indicator view.
     - parameter displayTimeThreshold: display time threshold to actually display UI blocker.
     - parameter minimumDisplayTime:   minimum display time of UI blocker.
     - parameter fadeInAnimation:      fade in animation.
     */
    public func startAnimating(
        _ size: CGSize? = nil,
        message: String? = nil,
        messageFont: UIFont? = nil,
        type: NVActivityIndicatorType? = nil,
        color: UIColor? = nil,
        padding: CGFloat? = nil,
        displayTimeThreshold: Int? = nil,
        minimumDisplayTime: Int? = nil,
        backgroundColor: UIColor? = nil,
        textColor: UIColor? = nil,
        fadeInAnimation: FadeInAnimation? = NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION) {
        let activityData = ActivityData(size: size,
                                        message: message,
                                        messageFont: messageFont,
                                        type: type,
                                        color: color,
                                        padding: padding,
                                        displayTimeThreshold: displayTimeThreshold,
                                        minimumDisplayTime: minimumDisplayTime,
                                        backgroundColor: backgroundColor,
                                        textColor: textColor)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, fadeInAnimation)
    }
    
    /**
     Remove UI blocker.
     
     - parameter fadeOutAnimation: fade out animation.
     */
    public func stopAnimating(_ fadeOutAnimation: FadeOutAnimation? = NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(fadeOutAnimation)
    }
}


//弹框提示
extension XZPublicTools {
    //成功提示
    func showSuccess(successTitle: String = kSuccessTitle, subTitle: String, closeTitle : String = "确定") {
        let alert = SCLAlertView()
        _ = alert.showSuccess(successTitle, subTitle: subTitle, closeButtonTitle: closeTitle)
    }
    
    //提示消息
    func showMessage(successTitle: String, subTitle: String, firstBtnTitle: String, firstBlock : @escaping () -> ()) {
        let alert = SCLAlertView()
        _ = alert.addButton(firstBtnTitle) {
            firstBlock()
        }
        _ = alert.showSuccess(successTitle, subTitle: subTitle)
    }
    
    
    //失败提示
    func showError(title: String = kErrorTitle, subTitle: String, closeTitle : String = "知道了") {
        _ = SCLAlertView().showError(title, subTitle:subTitle, closeButtonTitle:closeTitle)
        //        SCLAlertView().showError(self, title: kErrorTitle, subTitle: kSubtitle)
    }
    
    
    //提示
    func showNotice(title: String = kNoticeTitle, subTitle: String) {
        let appearance = SCLAlertView.SCLAppearance(dynamicAnimatorActive: true)
        _ = SCLAlertView(appearance: appearance).showNotice(title, subTitle: subTitle)
    }
    
    func showWarning(title: String = kWarningTitle, subTitle: String) {
        _ = SCLAlertView().showWarning(title, subTitle: subTitle)
    }
    
    func showInfo(title: String = kInfoTitle, subTitle: String) {
        _ = SCLAlertView().showInfo(title, subTitle: subTitle)
    }
    
    func showEdit(title: String = kInfoTitle, subTitle: String, sureTitle: String , placeholder: String = "请输入", sureBlock : @escaping (String?) -> ()) {
        let appearance = SCLAlertView.SCLAppearance(
            kTextFieldHeight: 60,
            showCloseButton: true
        )
        let alert = SCLAlertView(appearance: appearance)
        let txt = alert.addTextField(placeholder)
        _ = alert.addButton(sureTitle) {
            sureBlock(txt.text ?? "")
        }
        _ = alert.showEdit(title, subTitle:subTitle)
    }
    
    func showWait(title: String = "下载", subTitle: String = "下载中", closeTitle: String) -> (()->(), (_ : String)->()){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance).showWait(title, subTitle: subTitle, closeButtonTitle: closeTitle, timeout: nil, colorStyle: nil, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
        let close : () -> () = { alert.close() }
        let changeProgress : (_ progress : String) -> () = { (progress : String) in alert.setSubTitle(progress) }
        
        return (close, changeProgress)
        
    }
}
