//
//  XZUserHelper.swift
//  ChineseLive
//
//  Created by 再出发 on 2019/1/7.
//  Copyright © 2019 再出发. All rights reserved.
//

import UIKit

@objcMembers class XZUserHelper: NSObject,NSCoding {
    
    //单例
    static var shareUserHelper : XZUserHelper{
        struct Static {
            static let instance : XZUserHelper = XZUserHelper()
        }
        return Static.instance
    }
    
    
    var userDataKey : String = "userDataKey"
    var username : String?
    var pwd : String?
    var uid : String?
    lazy var filePath:String = {
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        DDLog("filePath = \(filePath+"/sha/userData.data")")
       return filePath + "/sha/userData.data"
    }()
    
    override init() {
        super.init()
    }
    
    //t归档
     func encode(with aCoder: NSCoder) {
        var count : UInt32 = 0
        let ivars = class_copyIvarList(object_getClass(self),&count)
        for i in 0..<count {
            //根据下标取属性
            let a = ivars?[Int(i)]
            //获得属性名称
            let cName = property_getName(a!)
            //转成oc对象
            let name = String(utf8String: cName)!
            aCoder.encode(self.value(forKey: name), forKey: name)
            print("name = \(name)")
        }
        
        free(ivars)//在OC中使用了Copy、Creat、New类型的函数，需要释放指针！！（注：ARC管不了C函数）
    }
    
    //解档
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        var count : UInt32 = 0
        let ivars = class_copyIvarList(object_getClass(self), &count)
        for i in 0..<count {
            //根据下标取属性
            let a = ivars?[Int(i)]
            //获取属性名称
            let cName = ivar_getName(a!)
            
            //转成oc对象
            let name = String(utf8String: cName!)
            let vaule = aDecoder.decodeObject(forKey: name!)
            self.setValue(vaule, forKey: name!)
        
        }
        
        free(ivars)
        
    }
    
    
    /**判断用户是否登录*/
    class func isAutoLogin() -> Bool {
        let userData = UserDefaults.standard.object(forKey: XZUserHelper.shareUserHelper.userDataKey)
        guard userData != nil else { return false }
        return true
        
    }
    
    //保存数据
    class func saveUser(userData:XZUserHelper){
        
        
        do {
            let archiveUserData =  try NSKeyedArchiver.archivedData(withRootObject: userData, requiringSecureCoding: true)
            
           UserDefaults.standard.set(archiveUserData, forKey: XZUserHelper.shareUserHelper.userDataKey)
            UserDefaults.standard.synchronize()
            DDLog("保存成功")
        }
        catch   {
            DDLog("模型转data失败");
        }
        
    }
    /**读取数据*/
    class func getUserData()->(XZUserHelper){
        
        let data = UserDefaults.standard.object(forKey: XZUserHelper.shareUserHelper.userDataKey)
        if data == nil{
            return XZUserHelper.shareUserHelper
        }
        
        let user = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! XZUserHelper
       
        do{
             let user1 = try NSKeyedUnarchiver.unarchivedObject(ofClass:self, from: (data as! Data))
            return user1!
        }
        
        catch {
            
            DDLog("解档失败");
         
        }
        
        return user
        
    }
    
    
    
    
}
