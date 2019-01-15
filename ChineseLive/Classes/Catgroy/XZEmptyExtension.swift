//
//  XZEmptyExtension.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/15.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

extension UIView:DZNEmptyDataSetDelegate,DZNEmptyDataSetSource{
    
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "<#T##String#>")
    }
    
}





