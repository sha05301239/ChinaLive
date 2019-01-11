//
//  XZLoginSelectCountryView.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/7.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

class XZLoginSelectCountryView: XZBaseView {

    
    
    lazy var myTableView : UITableView = {[weak self] in
    
        let myTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        myTableView.delegate = self
        myTableView.dataSource = self;
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))

        return myTableView
        
    }()
    
//    var clickCellBlock : ((_ title : String)->())?
    var clickCellBlock : ((_ titleStr : String)->())?

    
    lazy var dataList : Array = { () -> [String] in
       let dataList = ["+86","+1","+49","+44","+46","+7","+30","+31","+60","+63","+65","+66","+81"]
        return dataList
        
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myTableView)
        myTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension XZLoginSelectCountryView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self))
        cell?.textLabel?.font = UIFont.systemFont(ofSize: ddSpacing(25))
        cell?.textLabel?.text = dataList[indexPath.row]
        cell?.textLabel?.textAlignment = .center
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ddSpacing(50)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    guard let clickCellBlock = clickCellBlock else { return }
    
        clickCellBlock(dataList[indexPath.row])
//        clickCellBlock()

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
    }
}
