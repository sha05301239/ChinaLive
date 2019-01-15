//
//  XZHomePageCell.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/10.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZHomePageCell: UICollectionViewCell {
    
    
    lazy var dataList : Array<XZHomeNomalItemModel> = {
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
