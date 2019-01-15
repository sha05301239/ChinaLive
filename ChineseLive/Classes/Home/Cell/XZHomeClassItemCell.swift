//
//  XZHomeClassItemCell.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/15.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZHomeClassItemCell: UICollectionViewCell {
    
    
    lazy var iconImg : UIImageView = {
        let img = UIImageView(image: UIImage(named: "教育icon"))
        return img
    }()
    lazy var titleLabel:UILabel = {
        let titleLB = UILabel()
        titleLB.text = " "
        titleLB.font = UIFont.systemFont(ofSize: ddSpacing(32))
        titleLB.textColor = UIColor.darkGray
        titleLB.textAlignment = .center
        
        return titleLB
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension XZHomeClassItemCell{
    
    
    
    
    private func setupUI(){
        self.contentView.addSubview(self.iconImg)
        self.iconImg.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(-ddSpacing(50))
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.iconImg.snp.bottom)
        }
    }
    
}

