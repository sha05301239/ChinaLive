//
//  XZNomalHeaderView.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/10.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

import SDCycleScrollView

 class XZNomalHeaderView: UICollectionReusableView,SDCycleScrollViewDelegate {
    
  
        
        lazy var cycScrollView : SDCycleScrollView = {[weak self] in
            
            let cycView = SDCycleScrollView.init(frame: CGRect.zero, delegate: self, placeholderImage: UIImage(named: "登录-微信logo"))
            
            return cycView!;
            
            }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(cycScrollView)
            cycScrollView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            
            //        cycScrollView.imageURLStringsGroup =
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }

    
    

