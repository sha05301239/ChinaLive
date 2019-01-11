//
//  XZNetWorkingTool.swift
//  MoraGame
//
//  Created by 再出发 on 2018/9/29.
//  Copyright © 2018年 再出发. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
/** 访问出错具体原因 */

struct AFSErrorInfo {
    
    var code    = 0
    
    var message = ""
    
    var error   = NSError();
    
}




class XZNetWorkingTool: NSObject {
    //单例
    static let share = XZNetWorkingTool()
    private var manager:Alamofire.SessionManager = {
    let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: configuration)
        
    }()
    
    typealias AFSNetSuccessBlock = (SwiftyJSON.JSON)->Void
    typealias AFSNetFaliedBlock = (AFSErrorInfo)->Void
    typealias AFSProgressBlock = (Double)->Void
    
    /**Post*/
    func DDPost(url:String,param:Parameters,successBlock:@escaping AFSNetSuccessBlock,faliedBlock:@escaping AFSNetFaliedBlock) -> (Void) {
            //let encodStr = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed);
        let urlStr = DDCommonURL+url
       
        print("urlStr = \(urlStr)");
         print("paramparamparamparam = \(param)")
//        let headers : HTTPHeaders =  ["Content-Type":"application/json;charset=utf-8"];//http
        self.manager.request(urlStr, method:.post , parameters: param).responseJSON { (response) in
            //处理服务器返回数据
            self.handleResponse(response: response, successBlock: successBlock, faliedBlock: faliedBlock)
            
        }
        
    }
    
    /**Get*/
    
    func DDGet(url:String,successBlock:@escaping AFSNetSuccessBlock,faliedBlock:@escaping AFSNetFaliedBlock) {
        let headers:HTTPHeaders = ["Content-Type":"application/json;charset=utf-8"];//http
        self.manager.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (respnose) in
            
            self.handleResponse(response: respnose, successBlock: successBlock, faliedBlock: faliedBlock)
        }
    }
    
    /**上传图片*/
    func DDUploadImg(url:String,image:UIImage,param:Parameters,pregressBlock:AFSProgressBlock,successBlock:AFSNetSuccessBlock,falieBlock:AFSNetFaliedBlock){
        // 参数：
        // 压缩
    
        }
        
   
    /** 处理服务器响应数据*/
    private func handleResponse(response:DataResponse<Any>,successBlock:AFSNetSuccessBlock,faliedBlock:AFSNetFaliedBlock){
        print("response = \(response)");
        if let error = response.result.error {//服务器未返回数据
            self.handleRequestError(error: error as NSError, faliedBlock: faliedBlock)
        }else if let value = response.result.value{//服务器有返回数据
            if (value as? NSDictionary) == nil && (value as? NSArray) == nil{//返回数据格式不是字典
                self.handleRequestSuccessWithFaliedBlock(faliedBlock: faliedBlock)
            }else{//解析成功
                self.handleRequestSuccess(value: value, successBlock: successBlock, faliedBlock: faliedBlock)
            }
        }
    }
        /** 处理请求失败数据*/
    private func handleRequestError(error:NSError,faliedBlock:AFSNetFaliedBlock){
        var errorInfo = AFSErrorInfo()
        errorInfo.code = error.code
        errorInfo.error = error
        if (errorInfo.code == -1009) {
            errorInfo.message = "无网络连接"
        }else if (errorInfo.code == -1001){
            errorInfo.message = "请求超时"
            
        }else if (errorInfo.code == -1005){
            errorInfo.message = "网络连接丢失(服务器忙)"
        }else if (errorInfo.code == -1004){
            errorInfo.message = "服务器没启动"
        }else if (errorInfo.code == 404 || error.code == 3){
            
        }
        faliedBlock(errorInfo)
        
    }
    
    /**处理请求成功数据*/
    private func handleRequestSuccess(value:Any,successBlock:AFSNetSuccessBlock,faliedBlock:AFSNetFaliedBlock){
        let json = JSON(value)
        if  json["code"].int != nil && json["code"].int! == 200{//拦截，1为成功
            successBlock(json)
        }else if (json["code"].int != nil){//获取服务器返回h失败原因
            var errorInfo = AFSErrorInfo()
            errorInfo.code = json["code"].int!
            errorInfo.message = json["msg"].string != nil ? json["msg"].string! : "未知错误"
            faliedBlock(errorInfo)
            
        }else{
              successBlock(json)
        }
    }
    
     /** 服务器返回数据解析出错*/
    private func handleRequestSuccessWithFaliedBlock(faliedBlock:AFSNetFaliedBlock){
        var errorInfo = AFSErrorInfo()
        errorInfo.code = -1
        errorInfo.message = "解析数据出错"
        faliedBlock(errorInfo)
        
    }
    
}
