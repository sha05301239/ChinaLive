//
//  XZNomalSectionView.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/10.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZNomalSectionView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//
//        for view in sectionHeader.subviews{
//
//            view.removeFromSuperview()
//
//        }
        
        let leftImg =  UIImageView(image: UIImage(named: "home_haitan"))
        self.addSubview(leftImg)
        leftImg.snp.makeConstraints { (make) in
            make.left.width.height.equalTo(ddSpacing(25))
            make.centerY.equalTo(self)
        }
        
        let titleLB = UILabel.init()
        titleLB.text = "全部直播"
        titleLB.font = UIFont.systemFont(ofSize: ddSpacing(38))
        self.addSubview(titleLB)
        titleLB.snp.makeConstraints { (make) in
            make.left.equalTo(leftImg.snp.right).offset(ddSpacing(5))
            make.centerY.equalTo(self)
        }
        let rightImg =  UIImageView(image: UIImage(named: "home_haitan"))
        self.addSubview(rightImg)
        rightImg.snp.makeConstraints { (make) in
            make.width.height.equalTo(ddSpacing(25))
            make.left.equalTo(titleLB.snp.right).offset(ddSpacing(5))
            make.centerY.equalTo(self)
        }
        
        let moreBtn = UIButton(type: .custom)
        moreBtn.backgroundColor = ddColorA(50, 50, 50, 50)
        moreBtn.addTarget(self, action: #selector(clickMoreBtn(_:)), for: .touchUpInside)
        self.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.left.equalTo(leftImg)
            make.right.equalTo(rightImg)
            make.top.bottom.equalTo(self)
        }
        
        self.backgroundColor = ddBlueColor()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:--点击查看更多直播
    @objc private func clickMoreBtn(_ sender:UIButton){
        
        DDLog("clickMoreBtn")
    }
    

}

