//
//  XZHomeClassificationCell.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/15.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZHomeClassificationCell: UICollectionViewCell {
    
    //l懒加载collectionView
    
    lazy var myCollectionView:UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout.init()
        let itemW = (kWindowW-ddSpacing(320))/4;
        layout.itemSize = CGSize(width:itemW , height: itemW+ddSpacing(40))
        layout.minimumLineSpacing = ddSpacing(10);
        layout.minimumInteritemSpacing = ddSpacing(50)
        layout.sectionInset = UIEdgeInsets(top: 3, left: ddSpacing(50), bottom: 5, right: ddSpacing(50))
        layout.scrollDirection = .vertical;//c垂直
        
        let myCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.delegate =  self
        myCollectionView.dataSource = self
        myCollectionView.backgroundColor = UIColor.white
        myCollectionView.showsVerticalScrollIndicator = false
        myCollectionView.register(XZHomeClassItemCell.self, forCellWithReuseIdentifier: NSStringFromClass(XZHomeClassItemCell.self))
        //headerView
        myCollectionView.register(XZHomeClassifHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(XZHomeClassifHeaderView.self))
 
        return myCollectionView
        }()
    
        //懒加载数组
    lazy var dataList:Array = { () -> [[String]] in
       
        let dataList = [["娱乐","颜值","语音直播","美食","才艺","音乐","交友","娱乐","娱乐"],["教育","财经","法律","移民","医疗","地产","养生","汽车","运动","科技","母婴","动物","文化","园艺","居家","娱乐测试ceshi","居家","居家","居家"]]
        return dataList
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI(){
        self.contentView.addSubview(self.myCollectionView)
        //        self.myCollectionView.frame = self.contentView
        //        .bounds
        self.myCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
         
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension XZHomeClassificationCell:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataList.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let subDataList = dataList[section]
        
        
        return subDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(XZHomeClassItemCell.self), for: indexPath) as!  XZHomeClassItemCell
        let subDataList = dataList[indexPath.section];
        
        cell.titleLabel.text = subDataList[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
         return CGSize(width: kWindowW, height: ddSpacing(80))
//        if (section == 0) {
//            return CGSize(width: kWindowW, height: ddSpacing(300))
//        }else{
//            return CGSize(width: kWindowW, height: ddSpacing(50))
//        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader ) {
            
             let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(XZHomeClassifHeaderView.self), for: indexPath) as! XZHomeClassifHeaderView
            if (indexPath.section == 0){//
               headerView.titleLB?.text = "娱乐天地"
                
            }else if (indexPath.section == 1){
                 headerView.titleLB?.text = "科技教育"
                
            }
            
            return headerView;
            
        }
        
        
        return UICollectionReusableView.init()
        
        
        
    }
    
    
    
    
    
    
}
