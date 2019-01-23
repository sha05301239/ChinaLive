//
//  VideoPlayerView.swift
//  VerticalPlayerDemo
//
//  Created by 张崇超 on 2018/6/20.
//  Copyright © 2018年 ZCC. All rights reserved.
//

import UIKit

class VideoPlayerView: UIView {

    @IBOutlet weak var coverImgV: UIImageView!
    
    class func loadXibView(frame: CGRect) -> VideoPlayerView {
        let tool = Bundle.main.loadNibNamed("VideoPlayerView", owner: nil, options: nil)?.last as! VideoPlayerView
        tool.frame = frame
        
        return tool
    }

}
