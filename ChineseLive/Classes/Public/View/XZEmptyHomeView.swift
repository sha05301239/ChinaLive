//
//  XZEmptyHomeView.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/16.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZEmptyHomeView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI(){
        
        let iconImgView = UIImageView(image: UIImage(named: "empty_icon"))
        self.addSubview(iconImgView)
        iconImgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
        }
        
        let label = UILabel.init()
        label.text = "目前没有主播在线哦~不如先去逛逛视频和社区吧"
        label.font = UIFont.systemFont(ofSize: ddSpacing(24))
        label.textAlignment = .center
        label.textColor  = UIColor.orange
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(iconImgView.snp.bottom).offset(ddSpacing(50))
            make.centerX.equalToSuperview()
        }
        
        //底部img
        //
        let leftImg = UIImageView(image: UIImage(named: "empty_left"))
        self.addSubview(leftImg)
        leftImg.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(kWindowH/2-DDTabBarHeight-ddSpacing(50))
            make.right.equalTo(self.snp.centerX).offset(ddSpacing(-5))

        }
//        leftImg.frame = CGRect(x: 100, y: 300, width: 100, height: 100)
        
        
        let rightImg = UIImageView(image: UIImage(named: "empty_right"))
        self.addSubview(rightImg)
        rightImg.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview().offset(kWindowH/2-DDTabBarHeight+10)
            make.bottom.equalTo(leftImg)
            make.left.equalTo(self.snp.centerX).offset(ddSpacing(40))

        }

        
        
        
    }
    
    
    
}
