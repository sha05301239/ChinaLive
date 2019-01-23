//
//  VideoShowView.swift
//  VerticalPlayerDemo
//
//  Created by 张崇超 on 2018/6/20.
//  Copyright © 2018年 ZCC. All rights reserved.
//

import UIKit
import PLPlayerKit
let kWidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height
let kNavBarHeight: CGFloat = kHeight > 736.0 ? (88.0) : (64.0)
let kWindow = UIApplication.shared.keyWindow
let kRootVC = kWindow?.rootViewController
let kPlaceholderImg: UIImage = #imageLiteral(resourceName: "placeholderImg")

class VideoShowView: UIView {

    /// 视频地址
    let videoArr: [String] = ["http://ksy.fffffive.com/mda-hinp1ik37b0rt1mj/mda-hinp1ik37b0rt1mj.mp4","http://ksy.fffffive.com/mda-himtqzs2un1u8x2v/mda-himtqzs2un1u8x2v.mp4","http://ksy.fffffive.com/mda-hiw5zixc1ghpgrhn/mda-hiw5zixc1ghpgrhn.mp4","http://ksy.fffffive.com/mda-hiw61ic7i4qkcvmx/mda-hiw61ic7i4qkcvmx.mp4","http://ksy.fffffive.com/mda-hihvysind8etz7ga/mda-hihvysind8etz7ga.mp4","http://ksy.fffffive.com/mda-hiw60i3kczgum0av/mda-hiw60i3kczgum0av.mp4","http://ksy.fffffive.com/mda-hidnzn5r61qwhxp4/mda-hidnzn5r61qwhxp4.mp4","http://ksy.fffffive.com/mda-he1zy3rky0rwrf60/mda-he1zy3rky0rwrf60.mp4","http://ksy.fffffive.com/mda-hh6cxd0dqjqcszcj/mda-hh6cxd0dqjqcszcj.mp4","http://ksy.fffffive.com/mda-hifsrhtqjn8jxeha/mda-hifsrhtqjn8jxeha.mp4"]
    
    /// 封面地址
    let imageArr: [String] = ["http://ksy.fffffive.com/mda-hinp1ik37b0rt1mj/mda-hinp1ik37b0rt1mj.jpg","http://ksy.fffffive.com/mda-himtqzs2un1u8x2v/mda-himtqzs2un1u8x2v.jpg","http://ksy.fffffive.com/mda-hiw5zixc1ghpgrhn/mda-hiw5zixc1ghpgrhn.jpg","http://ksy.fffffive.com/mda-hiw61ic7i4qkcvmx/mda-hiw61ic7i4qkcvmx.jpg", "http://ksy.fffffive.com/mda-hihvysind8etz7ga/mda-hihvysind8etz7ga.jpg","http://ksy.fffffive.com/mda-hiw60i3kczgum0av/mda-hiw60i3kczgum0av.jpg", "http://ksy.fffffive.com/mda-hidnzn5r61qwhxp4/mda-hidnzn5r61qwhxp4.jpg", "http://ksy.fffffive.com/mda-he1zy3rky0rwrf60/mda-he1zy3rky0rwrf60.jpg", "http://ksy.fffffive.com/mda-hh6cxd0dqjqcszcj/mda-hh6cxd0dqjqcszcj.jpg","http://ksy.fffffive.com/mda-hifsrhtqjn8jxeha/mda-hifsrhtqjn8jxeha.jpg"]
    
    /// 当前展示的视频
    var currentVideoIndex: Int = 0
    /// 处理过的数据数组
    var dealDataTuple: ([String], [String])? {
        
        var firstIndex = 0
        var secondIndex = 0
        var thirdIndex = 0
        switch imageArr.count {
            
        case 0:
            
            return (["", "", ""], ["", "", ""])
            
        case 1:
            
            return ([imageArr[0], imageArr[0], imageArr[0]], [videoArr[0], videoArr[0], videoArr[0]])
            
        default:
            
            firstIndex = (self.currentVideoIndex - 1) < 0 ? imageArr.count - 1 : self.currentVideoIndex - 1
            secondIndex = self.currentVideoIndex
            thirdIndex = (self.currentVideoIndex + 1) > imageArr.count - 1 ? 0 : self.currentVideoIndex + 1
        }
        let dealImgArr = [imageArr[firstIndex], imageArr[secondIndex], imageArr[thirdIndex]]
        let dealVideoArr = [videoArr[firstIndex], videoArr[secondIndex], videoArr[thirdIndex]]
        
        return (dealImgArr, dealVideoArr)
    }
    /// 视频播放器
    private var videoPlayer: PLPlayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.scrollView.addSubview(self.firstView)
        self.scrollView.addSubview(self.secondView)
        self.scrollView.addSubview(self.thirdView)
        self.scrollView.setContentOffset(CGPoint.init(x: 0, y: kHeight), animated: true)
        
        self.addSubview(self.scrollView)
        
        self.setPlayer(videoUrl: "")
        
        // 添加通知 进入前台
//        NotificationCenter.default.addObserver(self, selector: #selector(_:), name:UIApplicationDidBecomeActive , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationDidBecomeActive"), object: nil)
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: OperationQueue.main, using: { (note) in
//
//            // 继续播放
//            self.videoPlayer?.resume()
//        })
        // 进入后台
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground(_:)), name: NSNotification.Name(rawValue: "UIApplicationDidEnterBackground"), object: nil)
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: OperationQueue.main, using: { (note) in
        
//            self.videoPlayer?.pause()
//        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //监听程序进入前台
    @objc func didBecomeActive(_ sender:UIButton){
          self.videoPlayer?.resume()
        DDLog("didBecomeActive")
        
    }
    //监听进入后台
    @objc func didEnterBackground(_ sender:UIButton){
        
        self.videoPlayer?.pause()
    }
    
    
    
    
    deinit {
        
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: -Lazy
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: kWidth, height: kHeight))
        scrollView.contentSize = CGSize.init(width: kWidth, height: kHeight * 3.0)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    lazy var firstView: VideoPlayerView = {
        let view = VideoPlayerView.loadXibView(frame: CGRect.init(x: 0.0, y: 0.0, width: kWidth, height: kHeight))
        view.coverImgV.sd_setImage(with: URL.init(string: imageArr.last!), placeholderImage: kPlaceholderImg, completed: { (img, error, cacheType, url) in
            
            view.coverImgV.setViewContentModel(size: (img ?? kPlaceholderImg).size)
        })
        
        return view
    }()
    lazy var secondView: VideoPlayerView = {
        let view = VideoPlayerView.loadXibView(frame: CGRect.init(x: 0.0, y: kHeight, width: kWidth, height: kHeight))
        view.coverImgV.sd_setImage(with: URL.init(string: imageArr.first!), placeholderImage: kPlaceholderImg, completed: { (img, error, cacheType, url) in
            
            view.coverImgV.setViewContentModel(size: (img ?? kPlaceholderImg).size)
        })
        
        return view
    }()
    lazy var thirdView: VideoPlayerView = {
        let view = VideoPlayerView.loadXibView(frame: CGRect.init(x: 0.0, y: kHeight * 2.0, width: kWidth, height: kHeight))
        view.coverImgV.sd_setImage(with: URL.init(string: imageArr[1]), placeholderImage: kPlaceholderImg, completed: { (img, error, cacheType, url) in
            
            view.coverImgV.setViewContentModel(size: (img ?? kPlaceholderImg).size)
        })
        
        return view
    }()
}

extension VideoShowView: PLPlayerDelegate {
    
    func player(_ player: PLPlayer, width: Int32, height: Int32) {
        
        if player.playerView!.superview != nil { return }
        
        player.launchView?.setViewContentModel(size: CGSize.init(width: CGFloat(width), height: CGFloat(height)))
        player.playerView?.setViewContentModel(size: CGSize.init(width: CGFloat(width), height: CGFloat(height)))

        self.secondView.insertSubview(player.playerView!, belowSubview: self.secondView.coverImgV)
    }
    
    // 播放状态变更
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        
        print("state:\(state)")
        if state == PLPlayerStatus.statusError {
            
            print("播放出错")
            self.videoPlayer?.stop()
            
        } else if state == PLPlayerStatus.statusPlaying {
            
            print("开始播放")
            UIView.animate(withDuration: 0.5, animations: {
                
                self.secondView.coverImgV.alpha = 0.0
            })
            
        } else if state == PLPlayerStatus.statusCaching {
            
            print("开始加载")
            
        } else if state == PLPlayerStatus.statusPaused {
            
            print("暂停播放")
        }
    }
    func player(_ player: PLPlayer, stoppedWithError error: Error?) {
        
        self.videoPlayer?.stop()
    }
    
    /// 创建播放器
    func setPlayer(videoUrl: String) {
        
        if self.videoPlayer != nil { return }
        
        let option = PLPlayerOption.default()
        let url = URL.init(string: self.videoArr[0])
        
        let player = PLPlayer.init(url: url, option: option)
        player?.delegate = self
        player?.loopPlay = true
        player?.isBackgroundPlayEnable = false
        player?.setBufferingEnabled(true)
        
        // 开启预加载
        player?.open(with: url)
        
        player?.playerView?.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth, .flexibleHeight]
        
        self.videoPlayer = player
        // 开始播放
        self.videoPlayer?.play()
    }
}

extension VideoShowView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset: CGFloat = scrollView.contentOffset.y
        if offset <= 0 {
            
            currentVideoIndex == 0 ? (currentVideoIndex = imageArr.count - 1): (currentVideoIndex = currentVideoIndex - 1)
            
            thirdView.contentMode = secondView.coverImgV.contentMode
            thirdView.coverImgV.image = secondView.coverImgV.image
            
            secondView.coverImgV.contentMode = firstView.contentMode
            secondView.coverImgV.image = firstView.coverImgV.image
            
            firstView.coverImgV.sd_setImage(with: URL.init(string: dealDataTuple!.0[0]), placeholderImage: kPlaceholderImg, completed: { (img, error, cacheType, url) in
                
                self.firstView.coverImgV.setViewContentModel(size: (img ?? kPlaceholderImg).size)
            })
            scrollView.setContentOffset(CGPoint.init(x: 0, y: kHeight), animated: false)
            
        } else if offset >= kHeight * 2 {
            
            currentVideoIndex == self.imageArr.count - 1 ? (currentVideoIndex = 0): (currentVideoIndex = currentVideoIndex + 1)
            
            firstView.coverImgV.contentMode = secondView.coverImgV.contentMode
            firstView.coverImgV.image = secondView.coverImgV.image
            
            secondView.coverImgV.contentMode = thirdView.coverImgV.contentMode
            secondView.coverImgV.image = thirdView.coverImgV.image
            
            thirdView.coverImgV.sd_setImage(with: URL.init(string: dealDataTuple!.0[2]), placeholderImage: kPlaceholderImg, completed: { (img, error, cacheType, url) in
                
                self.thirdView.coverImgV.setViewContentModel(size: (img ?? kPlaceholderImg).size)
            })
            scrollView.setContentOffset(CGPoint.init(x: 0, y: kHeight), animated: false)
        }
    }
    
    // 结束滚动时 开始播放新的地址
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //播放地止是否一致
        let playUrl = URL.init(string: self.videoArr[self.currentVideoIndex])
        if self.videoPlayer!.url != playUrl {

            self.secondView.coverImgV.alpha = 1.0

            self.videoPlayer?.playerView?.contentMode = self.secondView.coverImgV.contentMode
            self.videoPlayer?.play(with: playUrl, sameSource: true)
        }
    }
}

extension UIView {
    
    /// 设置控件展示模式
    func setViewContentModel(size: CGSize) {
        
        if size.height > size.width && Double(size.height) / Double(size.width) > 1.6 && Double(size.height) / Double(size.width) < 1.8 {
            
            self.contentMode = .scaleAspectFill
            self.clipsToBounds = true
            
        } else {
            
            self.contentMode = .scaleAspectFit
        }
    }
}


