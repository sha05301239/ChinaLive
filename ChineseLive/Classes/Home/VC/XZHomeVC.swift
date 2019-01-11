//
//  XZHomeVC.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/9.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZHomeVC: XZBaseVC {

    //懒加载collectionView
    lazy var myCollectionView:UICollectionView = {[weak self] in
       
        let layout = UICollectionViewFlowLayout.init()
//        layout.itemSize = CGSize.init(width:kWindowW, height: kWindowH)
        layout.scrollDirection = .horizontal;//水平滚动
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let myCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.delegate = self
        myCollectionView.dataSource = self;
        myCollectionView.backgroundColor = ddBlueColor()
        myCollectionView.register(XZHomePageCell.self, forCellWithReuseIdentifier: NSStringFromClass(XZHomePageCell.self))
        myCollectionView.showsHorizontalScrollIndicator = false;
        myCollectionView.isPagingEnabled = true
        return myCollectionView;
        
    }()
    //懒加载数组
    lazy var dataList : Array = { () -> [String] in
       let dataList = ["分类","娱乐","颜值","语音直播","未知","未知","未知"]
        return dataList
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DDLog("首页")
        setupCollectionView()
        
        
    }
    
    //MARK:--创建collectionView
    private func setupCollectionView(){
        
        view.addSubview(self.myCollectionView)
        self.myCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    //导航
    private func setupNavUI(){
        view.addSubview(self.myNavBar)
        
        
    }
    
  
}



//CollectionViewDelegate
//MARK:-- UICollectionViewDataSource
extension XZHomeVC:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return self.dataList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(XZHomePageCell.self), for: indexPath) as! XZHomePageCell
        
        return cell
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
    
    
    //MARK:-- UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//    }
    
    
    
    override func viewDidLayoutSubviews() {
        // 屏幕旋转时调用
       
            let orientation =  UIApplication.shared.statusBarOrientation;
       
            switch (orientation) {
            case .portrait:
            DDLog("portrait")//
//        [self verticalTwoViews];
                break;
            case .landscapeLeft:
                DDLog("landscape left");
//                [self horizontalTwoViews];
                break;
            case .landscapeRight:
                DDLog("landscape right");
//                [self horizontalTwoViews];
                break;
            case .portraitUpsideDown:
                DDLog("portrait upside down");
                break;
            case .unknown:
                DDLog("unknown");
                break;
            default:
                break;
            }
        }
  
    
    
}
