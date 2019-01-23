//
//  XZSearchFMDB.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/21.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit
import FMDB

//
//struct XZSearchModel {
//
//    var keyWord :  String?
//    var currentTime : String?
//    mutating func creatSearchModel(keyWord:String,currentTime:String) -> XZSearchModel {
//        self.keyWord = keyWord
//        self.currentTime = currentTime
//        return self
//
//    }
//
//
//}


class XZSearchFMDB: NSObject {
    
    var db : FMDatabase? = nil
    let TABLE_NAME = "SearchDataDB"
    
    
    //单例
    static var shareSearchFMDB : XZSearchFMDB{
        struct Static {
            static let instance : XZSearchFMDB = XZSearchFMDB()
            //
        }
        return Static.instance
    }
    override init() {
        super.init()
        creatSqliteData()
    }
    
    //MARK:--创建数据库
    func creatSqliteData(){
        /*
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSError *error;
         NSString *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
         NSString *filePath = [paths stringByAppendingString:@"activContent.sqlite"];
         if ([fileManager fileExistsAtPath:filePath] == NO) {
         NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"activContent" ofType:@"sqlite"];
         [fileManager copyItemAtPath:resourcePath toPath:filePath error:&error];
         }
         */
        //新建数据库，并打开
        let dbPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!+"history.sqlite"//https://github.com/ccgus/fmdb;
        DDLog("sqPath = \(dbPath)")
        var db : FMDatabase? = nil
        if (self.db == nil){
            
            do{
                
                let fileUrl = try FileManager.default.url(for: FileManager.SearchPathDirectory.applicationSupportDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(dbPath)
                db = FMDatabase(url: fileUrl)
                
            }catch{
                DDLog("catch d创建数据库失败")
            }
            
        }
        self.db = db;
        
        
        let success = db?.open()
        if (success == true){
            //数据库创建成果
            
            let sqlStr = "CREATE TABLE IF NOT EXISTS \(TABLE_NAME)(rowid INTEGER PRIMARY KEY AUTOINCREMENT,keyWord text,currentTime text)"
            
            do {
                try db?.executeUpdate(sqlStr, values: nil)
                DDLog("创建数据库成功")
            }catch{
                DDLog("s创建数据库失败")
            }
            
        }else{
            DDLog("打开数据库失败")
            
        }
        
        
        
    }
    
    
    //MARK:--已搜索数据模型插入数据库
    func insterSearchModel(searchModel:XZSearchModel){
        if (self.db?.open() == false){
            DDLog("打开数据库失败")
            return
        }
        
        let insertSQL = "insert into \(TABLE_NAME) (keyWord,currentTime) values (?,?)"
        let result = self.db?.executeUpdate(insertSQL, withArgumentsIn: [searchModel.keyWord!,searchModel.currentTime!])
        if (result == true){
            DDLog("插入成功")
        }else{
            DDLog("插入数据库失败")
        }
        
        self.db?.close()
        
    }
    
    
    //MARK:--根据关键字删除数据模型
    func deleteSearchModelByKeyWord(keyWrod:String){
        if (self.db?.open() == false){
            DDLog("打开数据库失败")
            return
        }
        
        DDLog("打开数据库成功")
        let deleteSQL = "DELETE FROM \(TABLE_NAME) WHERE keyWord = '\(keyWrod)'"
        
        do{
            try self.db?.executeUpdate(deleteSQL, values: nil)
            DDLog("删除成功")
        }catch{
            DDLog("删除失败")
        }
        
        self.db?.close()
        
    }
    
    //删除全部数据
    func deleteAllSearchModel() -> () {
        if (self.db?.open() == false){
            DDLog("打开数据库失败")
            return
        }
        
        let deleteSQL = "delete from \(TABLE_NAME) where 1>0"
        
        do {
            try self.db?.executeUpdate(deleteSQL, values: nil)
            
            DDLog("删除成功")
        }
        catch {
            DDLog("删除失败")
        }
    }
    
    //MARK:--获取数据库的全部数据
    func selectedAllSearchModel() -> Array<XZSearchModel>? {
        if (self.db?.open() == false){
            DDLog("查询 打开失败")
            return nil
        }
        
        let selectedSQL = "SELECT * FROM \(TABLE_NAME)"
        var array = Array<XZSearchModel>()
        do {
            let resultSet = try self.db?.executeQuery(selectedSQL, values: nil)
            guard let set = resultSet else { return nil }
            
            
            while (set.next()) {
                let keyWord : String = set.object(forColumn: "keyWord") as! String
                let currentTime :String = set.object(forColumn: "currentTime") as! String
                let model = XZSearchModel.creatSearchModel(keyWord, currentTime: currentTime)
                array.append(model!)
            }
            
            
        }catch{
            
            DDLog("查询失败")
        }
        self.db?.close()
        return array
    }
    
    
}
