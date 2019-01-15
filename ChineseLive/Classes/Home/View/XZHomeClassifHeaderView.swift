//
//  XZHomeClassifHeaderView.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/15.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZHomeClassifHeaderView: UICollectionReusableView {
    
    var titleLB:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let topView = UIView.init()
        topView.backgroundColor = UIColor.groupTableViewBackground
        self.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(2)
        }
        
        
        titleLB = UILabel.init()
        titleLB?.text = ""
//        titleLB?.textAlignment = .center
        titleLB?.font = UIFont.systemFont(ofSize: ddSpacing(38))
        self.addSubview(titleLB!)
        titleLB!.snp.makeConstraints { (make) in
            make.left.equalTo(ddSpacing(40))
            make.bottom.equalTo(self)
        }
          
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
