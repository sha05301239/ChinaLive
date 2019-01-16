//
//  XZHomeVC.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/9.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZHomeVC: XZBaseVC {

    
    //navTitleView
    lazy var topCollectionView : XZHomeNavView = {[weak self] in
       let topCollectionView = XZHomeNavView.init(frame: CGRect.zero)
        topCollectionView.delegate = self
        return topCollectionView
    }()
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
        myCollectionView.emptyDataSetSource = self;
        myCollectionView.emptyDataSetDelegate = self
        myCollectionView.backgroundColor = ddBlueColor()
        myCollectionView.register(XZHomeClassificationCell.self, forCellWithReuseIdentifier: NSStringFromClass(XZHomeClassificationCell.self))//分类
        myCollectionView.register(XZHomePageCell.self, forCellWithReuseIdentifier: NSStringFromClass(XZHomePageCell.self))
        myCollectionView.showsHorizontalScrollIndicator = false;
        myCollectionView.isPagingEnabled = true
//        myCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        return myCollectionView;
        
    }()
    //懒加载数组
    lazy var dataList : Array = { () -> [String] in
       let dataList = ["分类","娱乐","颜值","语音直播","未知","未知","未知","未知"]
//        let dataList = Array<String>()

        return dataList
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isLoading = true
        // Do any additional setup after loading the view.
        DDLog("首页")
        setupCollectionView()
        setupNavUI()
//        view.layoutIfNeeded()
        //默认滚动到第二个item（分类）
      
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            
             
            self.myCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
        }
       
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//            self.isLoading = false
////          self.dataList = ["分类","娱乐","颜值","语音直播","未知","未知","未知","未知"]
//          self.myCollectionView.reloadData()
//        }
        
    }
    
    
    
    
    //MARK:--创建collectionView
    private func setupCollectionView(){
        
        view.addSubview(self.myCollectionView)
        self.myCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(DDSafeAreaTopHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    //导航
    private func setupNavUI(){
        view.addSubview(self.myNavBar)
        
        self.myNavBar.addSubview(topCollectionView)
        topCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.myNavBar)
        }
    }
    
}



//CollectionViewDelegate
//MARK:-- UICollectionViewDataSource
extension XZHomeVC:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        if (indexPath.row == 0){//分类
            let classCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(XZHomeClassificationCell.self), for: indexPath) as! XZHomeClassificationCell
            return classCell
        }else{//其他普通cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(XZHomePageCell.self), for: indexPath) as! XZHomePageCell
        
        return cell
        }
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        DDLog(collectionView.bounds.size)
        return collectionView.bounds.size
        //(375.0, 724.0)]
    }
    
    
    //MARK:-- UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//    }
    
    
    
    override func viewDidLayoutSubviews() {
        // 屏幕旋转时调用
       super.viewDidLayoutSubviews()
        //默认滚动到第二个item（分类）
       
        
            let orientation =  UIApplication.shared.statusBarOrientation;
       
            switch (orientation) {
            case .portrait:
            //DDLog("portrait")
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


//顶部导航collectionView
extension XZHomeVC:XZHomeNavViewDelegate{
   
    //搜索
    func clickSearchBtn(_ sender: UIButton) {
        let homeSearchVC = XZSearchVC()
        navigationController?.pushViewController(homeSearchVC, animated: false)
        DDLog("navigationController = \(String(describing: navigationController))")
//        self.present(homeSearchVC
//            ,animated: false, completion: nil)
    }
    
    func clickMoreBtn(_ sender: UIButton) {
        DDLog("点击更多")
    }
    
    //点击导航栏按钮
    func homePageToScrollatIndexPath(indexPath: IndexPath) {
        if indexPath.item >= self.dataList.count {
            return;
        }
        self.myCollectionView .scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    
    
    //用户滚动scrollView触发代理时间
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let pageNum = round(offset/scrollView.frame.width)
        topCollectionView.didScrollToIndex(indexPath: IndexPath(row: Int(pageNum), section: 0))
        
    }
    
    
    
    
    
    
    
}



extension XZHomeVC{
    
    
    
    
    
}

