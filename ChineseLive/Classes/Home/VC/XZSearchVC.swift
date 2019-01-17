//
//  XZSearchVC.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/16.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZSearchVC: XZBaseVC {
//MARK:--懒加载searchBar
    lazy var mySearchBar : UISearchBar = {[weak self] in
        let mySearchBar = UISearchBar.init()
        mySearchBar.delegate = self
        mySearchBar.searchBarStyle = .minimal//日历笔记音乐
        mySearchBar.keyboardType = UIKeyboardType.namePhonePad;
        return mySearchBar
        }()
    
    //搜索记录collectionView
    lazy var historyCollectionView : XZSearchCollectionView = {
       
        let historyView = XZSearchCollectionView.init(frame: CGRect.zero)
        historyView.deleteHistoryBlock = {(sender : UIButton) in
            
            DDLog("删除历史记录")
            
        }
        return historyView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavView()
        setupCollectionView()
        
    }
    
    //MARK:--导航view
    private func setupNavView(){
        self.view.addSubview(self.myNavBar)
        
        self.myNavBar.wr_setLeftButton(image: UIImage(named: "nav_back")!)//左侧按钮
        self.myNavBar.wr_setBottomLineHidden(hidden: true)
        self.myNavBar.addSubview(self.mySearchBar)
        self.mySearchBar.snp.makeConstraints { (make) in
            make.left.equalTo(44)
            make.height.equalTo(44)
            make.bottom.equalTo(self.myNavBar)
            make.right.equalTo(-44-ddSpacing(30))
        }
        
        let searchBtn = UIButton.init()
        searchBtn.titleLabel?.font = UIFont.systemFont(ofSize: ddSpacing(40))
        searchBtn.setTitleColor(UIColor.black, for: .normal)
        searchBtn.setTitle("搜索", for: .normal)
        
        searchBtn.addTarget(self, action: #selector(clickSaerchBtn(_:)), for: .touchUpInside)
        self.myNavBar.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(ddSpacing(-25))
            make.centerY.equalTo(self.mySearchBar)
        }
        
        
        self.myNavBar.onClickLeftButton = {
            
            DDLog("onClickLeftButton")
            self.navigationController?.popViewController(animated: true)
            
        }
        
     
        
        
    }
    //MARK:--collectionView
    private func setupCollectionView(){
        
        self.view.addSubview(self.historyCollectionView)
        self.historyCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(DDSafeAreaTopHeight)
            make.bottom.equalTo(DDSafeAreaBottomHeight)
        }
        
        
    }
    
    //MARK:--点击搜索
    @objc private func clickSaerchBtn(_ sender:UIButton){
        
        DDLog("搜索")
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension XZSearchVC:UISearchBarDelegate{
    
    
    
   
}



