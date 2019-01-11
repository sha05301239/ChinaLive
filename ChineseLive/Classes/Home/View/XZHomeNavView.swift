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
        label.font = UIFont.systemFont(ofSize: ddSpacing(40))
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(itemLabel)
        itemLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class XZHomeNavView: XZBaseView {

    //懒加载数组
    lazy var dataList:Array<String> = {
       let array = ["分类","推荐","娱乐","颜值","语音直播"]
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
       let myCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.delegate = self;
        myCollectionView.dataSource = self;
        myCollectionView.register(XZNavViewItemCell.self, forCellWithReuseIdentifier: NSStringFromClass(XZNavViewItemCell.self))
        return myCollectionView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
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
        return cell;
        
    }
    
    
    
    
    
}


