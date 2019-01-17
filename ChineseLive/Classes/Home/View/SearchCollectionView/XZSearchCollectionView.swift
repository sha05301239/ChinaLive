//
//  XZSearchCollectionView.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/17.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit
//MARK:--sectionView
class XZSearchHeaderView: UICollectionReusableView {
    
    //block
    var clickDeleteBlock : ((_ sender:UIButton)->())?
    
    
    lazy var titleLb : UILabel = {
        let lb = UILabel.init()
        lb.text = "搜索记录"
        lb.font = UIFont.systemFont(ofSize: ddSpacing(30))
        return lb
    }()
    
    lazy var deleteBtn : UIButton = {
       let btn = UIButton.init(type: UIButton.ButtonType.custom)
      
        btn.setImage(UIImage(named: "homeSearch_delegate"), for: .normal)
        btn.addTarget(self, action: #selector(clickDeleteBtn(_:)), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(ddSpacing(35))
            make.bottom.equalTo(ddSpacing(-5))
        }
        
        addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { (make) in
            make.right.equalTo(ddSpacing(-25))
            make.width.height.equalTo(ddSpacing(45))
            make.centerY.equalTo(titleLb)
        }
        
        self.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:--点击删除
    @objc private func clickDeleteBtn(_ sender:UIButton){
        
        guard let clickDeleteBlock = clickDeleteBlock else { return  }
        clickDeleteBlock(sender)
    }
    
    
    
}

//MARK:--Cell
class XZSearchCollectionCell: UICollectionViewCell {
    
    
    lazy var titleLabel : UILabel = {
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: ddSpacing(26))
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class XZSearchCollectionView: UIView {

    //MARK:--点击删除历史记录
    var deleteHistoryBlock : ((_ sender:UIButton)->())?
    
    
    //加载中
    var isLoading = false
    
    lazy var dataList : Array<XZHomeNomalItemModel> = {
        let model = XZHomeNomalItemModel.init()
        model.name = "颦一笑欢喜"
        //
        let model1 = XZHomeNomalItemModel.init()
        
        model1.name = "踏雪伤痕"
        //
        let model2 = XZHomeNomalItemModel.init()
        model2.name = "白雪@。。"
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
        layout.scrollDirection = .vertical;//垂直
        
        let myCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.delegate =  self
        myCollectionView.dataSource = self
        myCollectionView.backgroundColor = UIColor.white
        myCollectionView.showsVerticalScrollIndicator = false
        myCollectionView.register(XZSearchCollectionCell.self, forCellWithReuseIdentifier: NSStringFromClass(XZSearchCollectionCell.self))
 
        
        //sectionView
        myCollectionView.register(XZSearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(XZSearchHeaderView.self))
        
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
        
        self.addSubview(self.myCollectionView)
        self.myCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
}



extension XZSearchCollectionView:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return dataList.count * 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(XZSearchCollectionCell.self), for: indexPath) as!  XZSearchCollectionCell
        let model = dataList[indexPath.item % 3]
        cell.titleLabel.text = model.name
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if self.dataList.count == 0{
            return CGSize.zero
        }
        
            return CGSize(width: collectionView.bounds.width, height: ddSpacing(100))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader ) {
            
            //搜索l记录
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(XZSearchHeaderView.self), for: indexPath) as! XZSearchHeaderView
            //MARK:--点击历史记录
            headerView.clickDeleteBlock = {(sender) in
                guard let deleteHistoryBlock = self.deleteHistoryBlock else {return}
                
                deleteHistoryBlock(sender)
                
            }
 
                return headerView
            
        }
        
        return UICollectionReusableView.init()
        
    }
    
    
}
    
    




