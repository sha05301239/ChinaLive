//
//  XZHomeNavView.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/11.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZNavViewItemCell:UICollectionViewCell{
    lazy var itemLabel : UILabel = {
       let label = UILabel.init()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: ddSpacing(38))
        label.textAlignment = .center
        return label
    }()
    
    var bottomView = UIView()
    var isSelectedCell: Bool = false{
        didSet{
           bottomView.isHidden = !isSelectedCell
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(itemLabel)
        itemLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        bottomView.backgroundColor = UIColor.orange
        contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.left.right.equalTo(itemLabel)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//点击滚动代理
protocol XZHomeNavViewDelegate {
    func homePageToScrollatIndexPath(indexPath:IndexPath) -> ()
}


class XZHomeNavView: XZBaseView {

    //代理
    var delegate : XZHomeNavViewDelegate?
    
    //默认选择推荐
    lazy var currentIndex : IndexPath = {
        let currentIndex = IndexPath.init(row: 1, section: 0)
        return currentIndex
    }()
    //懒加载数组
    lazy var dataList:Array<String> = {
       let array = ["分类","推荐","娱乐","颜值","语音直播","王者荣耀","沙","测试"]
        return array
    }()
    //搜索按钮
    lazy var searchBtn:UIButton = {
       let searchBtn = UIButton.init()
        searchBtn.setBackgroundImage(UIImage(named: "home_search"), for: .normal)
        searchBtn.addTarget(self, action: #selector(clickSearchBtn(_:)), for: .touchUpInside)
        return searchBtn
    }()
    
    //右侧更多按钮
    lazy var moreBtn:UIButton = {
        let moreBtn = UIButton.init()
        moreBtn.setBackgroundImage(UIImage(named: "home_search"), for: .normal)
        moreBtn.addTarget(self, action: #selector(clickMoreBtn(_:)), for: .touchUpInside)
        return moreBtn
    }()
    //collectionView
    lazy var myCollectionViiew:UICollectionView = {[weak self] in
       let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
       let myCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.delegate = self;
        myCollectionView.dataSource = self;
        myCollectionView.register(XZNavViewItemCell.self, forCellWithReuseIdentifier: NSStringFromClass(XZNavViewItemCell.self))
        myCollectionView.backgroundColor = UIColor.white
        
        return myCollectionView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        
    }
    
    //设置ui
    private func setupUI() ->(){
        addSubview(self.searchBtn)
        self.searchBtn.snp.makeConstraints { (make) in
            make.left.equalTo(ddSpacing(10))
            make.width.height.equalTo(ddSpacing(60))
            make.bottom.equalTo(self)
        }
        //右侧按钮
        addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(ddSpacing(50))
            make.centerY.equalTo(self.searchBtn)
            make.right.equalTo(ddSpacing(-10))
        }
        
        //中间collectionView
        
        addSubview(self.myCollectionViiew)
        self.myCollectionViiew.snp.makeConstraints { (make) in
            make.left.equalTo(self.searchBtn.snp.right)
            make.top.bottom.equalTo(self.searchBtn)
            make.right.equalTo(self.moreBtn.snp.left).offset(-ddSpacing(5))
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension XZHomeNavView{
    //点击搜索
    @objc private func clickSearchBtn(_ sender:UIButton){
    DDLog("clickSearchBtn")
        
    }
    //点击更多
    @objc private func clickMoreBtn(_ sender:UIButton){
    DDLog("clickSMoreBtn")
    }
    
}


extension XZHomeNavView:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(XZNavViewItemCell.self), for: indexPath) as! XZNavViewItemCell
        cell.itemLabel.text = self.dataList[indexPath.item]
        cell.isSelectedCell = self.currentIndex as IndexPath == indexPath
        return cell;
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lbW = getLabelWidth(str: dataList[indexPath.item], fontSize: ddSpacing(38), height: collectionView.bounds.height)
        
        return CGSize(width: lbW + ddSpacing(20), height: collectionView.bounds.height)
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didScrollToIndex(indexPath: indexPath)
       
        
    }
    
    
    //控制collectionView滚动
    func didScrollToIndex(indexPath:IndexPath){
        if currentIndex == indexPath {
            return
        }
        currentIndex = indexPath
        myCollectionViiew.reloadData()
        myCollectionViiew.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        guard let delegate = self.delegate else { return  }
        delegate.homePageToScrollatIndexPath(indexPath: indexPath)
        
    }
    
    
    
}


