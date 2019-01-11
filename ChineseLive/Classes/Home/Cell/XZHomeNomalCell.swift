//
//  XZHomeNomalCell.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/10.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZHomeNomalCell: UICollectionViewCell {
    
    
    var model : XZHomeNomalItemModel?{
        didSet{
            guard let model = model else { return }
            
            typeDivLabel.text = model.typeStr;
            nameLabel.text = model.name
            roomNameLB.text = model.room
            audienceCountLB.text = model.audience
             
        }
    }
    
    
    lazy var bjImg : UIImageView = {//背景图
       let bjImg = UIImageView(image: UIImage(named: "homeItem_5"))
       return bjImg;
        
    }()
    
    //右上角类型标签
    lazy var typeDivLabel : UILabel = {
       let typeDivLabel = cretaLabel(fontSize: ddSpacing(30), color: UIColor.white)
       typeDivLabel.layer.cornerRadius = ddSpacing(15)
        typeDivLabel.text = "颜值"
       return typeDivLabel
    }()
    
    //主播名称
    lazy var nameLabel : UILabel = {
       
        let nameLabel = cretaLabel(fontSize:ddSpacing(30) , color: UIColor.white)
        nameLabel.text = "颦一笑欢喜"
        return nameLabel
    
    }()
    //观看人数
    lazy var audienceCountLB : UILabel = {
       let audienceCountLB = cretaLabel(fontSize: ddSpacing(28), color: UIColor.white)
        audienceCountLB.text = "2.6万"
        return audienceCountLB
    }()
    
    //房间名称
    lazy var roomNameLB : UILabel = {
       let roomNameLB = cretaLabel(fontSize: ddSpacing(36))
        roomNameLB.text = "只想要荧光棒"
       return roomNameLB
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension XZHomeNomalCell{
    //创建label私有方法
    private func cretaLabel(fontSize:CGFloat,color:UIColor = UIColor.black)->(UILabel){
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: fontSize)
        lb.textAlignment = .center
        lb.textColor = color
        return lb
    }
    //布局
    private func setupUI(){
        
        contentView.addSubview(bjImg)
        bjImg.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(-ddSpacing(45))
        }
        
        
        self.bjImg.addSubview(typeDivLabel)
        typeDivLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-ddSpacing(2))
            make.top.equalTo(ddSpacing(14))
            make.width.equalTo(ddSpacing(80))
            make.height.equalTo(ddSpacing(35))
        }
        
        self.bjImg.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ddSpacing(12))
            make.bottom.equalTo(-ddSpacing(5))
        }
        
        self.bjImg.addSubview(audienceCountLB)
        audienceCountLB.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(-ddSpacing(5))
        }
        
        //人图标
        let peopleIcon = UIImageView(image: UIImage(named: "home_renshu"))
        self.bjImg.addSubview(peopleIcon)
        peopleIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(ddSpacing(14))
            make.centerY.equalTo(audienceCountLB)
            make.right.equalTo(audienceCountLB.snp.left).offset(ddSpacing(2))
        }
        
        //底部房间号
        self.contentView.addSubview(roomNameLB)
        roomNameLB.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.bjImg.snp.bottom).offset(ddSpacing(4))
        }
        
        
        
    }
    
    
    
    
    
    
}
