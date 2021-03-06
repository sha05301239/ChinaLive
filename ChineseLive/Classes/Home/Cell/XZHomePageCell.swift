//
//  XZHomePageCell.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/10.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


class XZHomePageCell: UICollectionViewCell {
    
    //加载中
    var isLoading = false
    
    lazy var dataList : Array<XZHomeNomalItemModel> = {
       
        return Array<XZHomeNomalItemModel>()
        
        let model = XZHomeNomalItemModel.init()
        model.typeStr = "颜值"
        model.name = "颦一笑欢喜"
        model.audience = "2.3W"
        model.room = "只想要荧光棒"
        
        //
        let model1 = XZHomeNomalItemModel.init()
        model1.typeStr = "语音"
        model1.name = "踏雪伤痕"
        model1.audience = "10.3W"
        model1.room = "快乐的唱歌"
        //
        let model2 = XZHomeNomalItemModel.init()
        model2.typeStr = "户外"
        model2.name = "白雪@。。"
        model2.audience = "23.3W"
        model2.room = "么么哒"
        let dataList = [model,model1,model2]
        return dataList
        
    }()
    
    //l懒加载collectionView
    
    lazy var myCollectionView:UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout.init()
        let itemW = (kWindowW-ddSpacing(15)-ddSpacing(50))/2;
        layout.itemSize = CGSize(width:itemW , height: itemW*220/350)
        layout.minimumLineSpacing = ddSpacing(10);
        layout.minimumInteritemSpacing = ddSpacing(10)
        layout.sectionInset = UIEdgeInsets(top: 10, left: ddSpacing(25), bottom: 0, right: ddSpacing(25))
        layout.scrollDirection = .vertical;//c垂直
        
        let myCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.delegate =  self
        myCollectionView.dataSource = self
        myCollectionView.emptyDataSetSource = self;
        myCollectionView.emptyDataSetDelegate = self;
        myCollectionView.backgroundColor = UIColor.white
        myCollectionView.showsVerticalScrollIndicator = false
        myCollectionView.register(XZHomeNomalCell.self, forCellWithReuseIdentifier: NSStringFromClass(XZHomeNomalCell.self))
        //headerView
        myCollectionView.register(XZNomalHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(XZNomalHeaderView.self))
        
        //sectionView
        myCollectionView.register(XZNomalSectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(XZNomalSectionView.self))
        
        return myCollectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        var num = 1
        
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            
            num += 1
            if num == 2{
                self.isLoading = false
                self.dataList.removeAll()
                self.myCollectionView.reloadData()//无数据
            }
            
            if num > 2 {//有数据
                
            }
            
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            
            let model = XZHomeNomalItemModel.init()
            model.typeStr = "颜值"
            model.name = "颦一笑欢喜"
            model.audience = "2.3W"
            model.room = "只想要荧光棒"
            
            //
            let model1 = XZHomeNomalItemModel.init()
            model1.typeStr = "语音"
            model1.name = "踏雪伤痕"
            model1.audience = "10.3W"
            model1.room = "快乐的唱歌"
            //
            let model2 = XZHomeNomalItemModel.init()
            model2.typeStr = "户外"
            model2.name = "白雪@。。"
            model2.audience = "23.3W"
            model2.room = "么么哒"
            self.dataList.append(model)
            self.dataList.append(model1)
            self.dataList.append(model2)
            self.isLoading = false
            self.myCollectionView.reloadData()
            
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        self.contentView.addSubview(self.myCollectionView)
//        self.myCollectionView.frame = self.contentView
//        .bounds
        self.myCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        
    }
    
}


extension XZHomePageCell:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0){
            return 0
        }
        return dataList.count * 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(XZHomeNomalCell.self), for: indexPath) as!  XZHomeNomalCell
        
        cell.model = dataList[indexPath.item % 3]
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if self.dataList.count == 0{
            return CGSize.zero
        }
        if (section == 0) {
            return CGSize(width: kWindowW, height: ddSpacing(300))
        }else{
            return CGSize(width: kWindowW, height: ddSpacing(50))
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader ) {
            
            if (indexPath.section == 0){//轮播
                let firstHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(XZNomalHeaderView.self), for: indexPath) as! XZNomalHeaderView
                 
                return firstHeader
                
            }else if (indexPath.section == 1){
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(XZNomalSectionView.self), for: indexPath)
                
                return sectionHeader
            }
            
        }
            
            
        return UICollectionReusableView.init()
        
    }
 
    

    
    
}



//MARK:--首页直播空白显示界面


extension XZHomePageCell:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    
    /**
     *空白页标题(注：
     1：该标题并不是页面的标题，是提示视图的标题
     2：必须返回富文本（可设置其颜色，字号，风格等。或：nil))
     */
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: "", attributes: nil)
        let str = "洪荒之力"
        return NSAttributedString.init(string: str, attributes: nil)
    }
    /**
     *空白正文(注：
     必须返回富文本（可设置其颜色，字号，风格等。或：nil，方法同上))
     */
    
    public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "玩命加载中"
        return NSAttributedString.init(string: str, attributes: nil)
    }
    
    /**
     *(空白页图片)注：
     如果直接返回图片，显示的图片会是图片原本的尺寸。可以在该方法中重置图片大小再return。
     */
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "loading_imgBlue_78x78")
    }
    /**空白页颜色e色调（注：
     * 该方法一般不用，默认为nil）
     */
    
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        DDLog("scrollViewscrollView = \(String(describing: scrollView))")
        if self.isLoading {
            return nil
        }else{
            let customView = XZEmptyHomeView.init(frame:scrollView.bounds)
            
            return customView
        }
        
        
    }
    
    public func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return nil
    }
    /**
     *空白页图片（视图）动画(注：
     该方法是设置图片或视图的动画，可设置动画组CAAnimationGroup)
     */
    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        
        //         CABasicAnimation *animation = [CABasicAnimation         animationWithKeyPath: @"transform"];
        
        //         animation.fromValue = [NSValue                  valueWithCATransform3D:CATransform3DIdentity];
        //         animation.toValue = [NSValue   valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
        //
        //         animation.duration = 0.25;
        //         animation.cumulative = YES;
        //         animation.repeatCount = MAXFLOAT;
        //
        //         return animation;
        
        let animation = CABasicAnimation(keyPath: "transform")
        //开始位置
        animation.fromValue = CATransform3DIdentity
        //结束位置
        animation.toValue = CATransform3DMakeRotation(CGFloat(Double.pi/2), 0.0, 0.0, 1.0)
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT
        return animation
        //        return nil
    }
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0 //整体位置
    }
    public func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0  //标题、图片位置
    }
    
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.white
    }
    
    
    //MARK:--DZNEmptyDataSetDelegate Methods
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        DDLog("self.isLoading = \(self.isLoading)")
        return self.isLoading
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.isLoading = false
        }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.isLoading = false
        }
        
    }
    
    
    
}
