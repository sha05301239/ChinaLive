//
//  XZSearchVC.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/16.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZSearchVC: XZBaseVC,XZSearchCollectionViewDelegate,XZSearchResultCollectionViewDelegate {
  
    
    
    let max_count : Int = 20
    //历史记录
    lazy var dataList = { () -> Array<XZSearchModel>? in
        let dataList = XZSearchFMDBManager.shareXZSearchFMDB()?.selecAllSearchModel()
        return dataList as? Array<XZSearchModel>
    }()
    
//MARK:--懒加载searchBar
    lazy var mySearchBar : UISearchBar = {[weak self] in
        let mySearchBar = UISearchBar.init()
        mySearchBar.delegate = self
        mySearchBar.searchBarStyle = .minimal//日历笔记音乐
        mySearchBar.keyboardType = UIKeyboardType.namePhonePad;
        return mySearchBar
        }()
    
    //搜索记录collectionView
    lazy var historyCollectionView : XZSearchCollectionView = {[weak self] in
       
        let historyView = XZSearchCollectionView.init(frame: CGRect.zero)
        historyView.delegate = self
        historyView.deleteHistoryBlock = {(sender : UIButton) in
            
            DDLog("删除历史记录")
            historyView.dataList?.removeAll()
            XZSearchFMDBManager.shareXZSearchFMDB()?.deleteAllSearchModel()
            
        }
        
        //逆序
        let arr = self?.exchangeArray(array:self?.dataList ?? Array())
        historyView.dataList = arr
        
        return historyView
        
    }()
    
    
    //MARK:--点击历史记录item
    func hisCollectionDidSelectItemAt(_ indexPath: IndexPath) {
        //逆序
        let arr = self.exchangeArray(array: self.dataList!)
        
        DDLog("arrarrarr = \(arr)")
        let model = arr[indexPath.item]
        
        let searchBar = UISearchBar.init()
        searchBar.text = model.keyWord
        searchBarSearchButtonClicked(searchBar);
        
    }
    
    
    //搜索结果collectionView
    lazy var resultCollectionView : XZSearchResultCollectionView = {[weak self] in
        let resultView = XZSearchResultCollectionView.init(frame: CGRect.zero)
        resultView.delegate = self
        
        return resultView
        
    }()
    
    //MARK:--点击搜索结果，推出详情

    func searchResultDidSelectItemAt(_ indexPath: IndexPath) {
         
        let liveVC = UIViewController.init()

        self.pushLiveController(liveVC)
    }
    //y推出详情控制器
    private func pushLiveController(_ liveVC:UIViewController){
        let muVCs = NSMutableArray.init(array: (self.navigationController?.children)!)
        let myVCIndex = muVCs.index(of: self)
        //移除当前控制器
        muVCs.removeObject(at: myVCIndex)
        //添加新的控制器
        muVCs.add(liveVC)
        self.navigationController?.setViewControllers(muVCs as! [UIViewController], animated: true)
        
        
    }
    
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
        //历史记录collectionView
        self.view.addSubview(self.historyCollectionView)
        self.historyCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(DDSafeAreaTopHeight)
            make.bottom.equalTo(DDSafeAreaBottomHeight)
        }
        
        //结果collectionView
        
//        self.resultCollectionView = XZSearchResultCollectionView.init(frame: CGRect.zero)
        self.view.addSubview(resultCollectionView)
        resultCollectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(DDSafeAreaTopHeight)
        }
        resultCollectionView.isHidden = true
        
    }
    
    //MARK:--点击搜索
    @objc private func clickSaerchBtn(_ sender:UIButton){
        
        DDLog("点击搜索")
        
        searchBarSearchButtonClicked(self.mySearchBar);
        
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
//MARK:--searchBarDelegate
extension XZSearchVC:UISearchBarDelegate{
    //开始编辑
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.resultCollectionView.isHidden = true
        self.historyCollectionView.isHidden = false
        return true
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       /*
        searchBar.showsCancelButton = true
        for view in (searchBar.subviews.first?.subviews)! {
            if (view .isKind(of: NSClassFromString("UINavigationButton")!.self)){
                let btn = view as! UIButton
                btn.setTitle("搜索", for: .normal)
                btn.setTitleColor(UIColor.black, for: .normal)
            }
        }
 */
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool{
        return true
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DDLog("是时候插入数据了")
        if (searchBar.text?.count == 0) {
            MBProgressHUD.showError("搜索l内容不能为空")
            return
        }
        
        searchBar.showsCancelButton = false
        self.historyCollectionView.isHidden = true
        self.resultCollectionView.isHidden = false
        
        _ = self.insterDBData(keyWord: searchBar.text!)
        self.mySearchBar.resignFirstResponder()
        DDLog("开始调用接口")
        
    }
    
    
    //MARK:--自定义私有方法
    
    func insterDBData(keyWord:String) -> (Bool) {
        if (keyWord.count == 0){
            return false
        }
        //搜索历史插入数据库,先删除数据库中相同的数据
        removeSameData(keyWord: keyWord)
        //再左移，插入数据
        self.moreThan20Data(keyWord: keyWord)
        //读取数据库里的数据
        
        self.dataList = (XZSearchFMDBManager.shareXZSearchFMDB()?.selecAllSearchModel() as! Array<XZSearchModel>)
            //.shareSearchFMDB.selectedAllSearchModel()
        guard let dataListArray = self.dataList else { return true }
        //逆序
        let arr =  self.exchangeArray(array: dataListArray  )
        
        self.historyCollectionView.dataList = arr
        
        
        return true
    }
    
    
    //根据关键字删除数据
    private func removeSameData(keyWord:String){
        let fmdbManager = XZSearchFMDBManager.shareXZSearchFMDB()
//        fmdbManager.creatSqliteData()
        let array = fmdbManager?.selecAllSearchModel()
        guard let arr = array else { return }
        for model in arr {
            //根据关键字删除数据库相同的数据
            if ((model as! XZSearchModel).keyWord == keyWord){
                fmdbManager?.deleteSearchModel(byKeyWord: keyWord)
            }
        }
        
    }
    
    
    //多余的20条把第0条去掉
    private func moreThan20Data(keyWord:String){
        
        
        //读取数据库里的数据
        let fmdbManager = XZSearchFMDBManager.shareXZSearchFMDB()
//        fmdbManager.creatSqliteData()
        let array = fmdbManager?.selecAllSearchModel()
        guard let arr = array else { return }
        if (arr.count > max_count - 1){//超出最大限制
            let tempArray = self.moveArrToLeft(arr: arr as! Array<XZSearchModel>, keyWord: keyWord)//数组左移
           
            XZSearchFMDBManager.shareXZSearchFMDB()?.deleteAllSearchModel()
//            XZSearchFMDBmanager.shareSearchFMDB.deleteAllSearchModel()
            self.dataList?.removeAll()
//            self.historyCollectionView.dataList =
            for (_,obj) in tempArray.enumerated(){
                XZSearchFMDBManager.shareXZSearchFMDB()?.insterSearchModel(obj)
//             XZSearchFMDBmanager.shareSearchFMDB.insterSearchModel(searchModel: obj)
                
            }
            
        }else{//未超出，直接插入数据库
         
            let model = XZSearchModel.creatSearchModel(keyWord, currentTime: getCurrentTime())
            XZSearchFMDBManager.shareXZSearchFMDB()?.insterSearchModel(model)
//            XZSearchFMDBmanager.shareSearchFMDB.insterSearchModel(searchModel:model!)
            
        }
        
        
    }
    
    
    //数组左移
    private func moveArrToLeft(arr:Array<XZSearchModel>,keyWord:String)->Array<XZSearchModel>{
        var array = arr
        
        let model : XZSearchModel = XZSearchModel.creatSearchModel(keyWord, currentTime: getCurrentTime())
        array.append(model)
        array.remove(at: 0)
        return array
       
    }
    
    //数组逆序
    private func exchangeArray(array:Array<XZSearchModel>)->Array<XZSearchModel>{
//        let num = array.count
        var temp = Array<XZSearchModel>()
        for (_,item) in array.enumerated().reversed() {
            temp.append(item)
        }
        return temp
        
        
    }
    
    
    
    //获取当前时间
    private func getCurrentTime()->String{
        let sendDate = Date.init()
        let formtter = DateFormatter.init()
        formtter.dateFormat = "YYY年MM月dd日 HH:mm:ss"
        let locationStr = formtter.string(from: sendDate)
        return locationStr
    }
    
}



