//
//  XZSearchFMDBManager.h
//  TeamC
//
//  Created by sha xianding on 2017/11/24.
//  Copyright © 2017年 沙先鼎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZSearchModel.h"
//#import "ChineseLive-Swift.h"
@interface XZSearchFMDBManager : NSObject
+(instancetype)shareXZSearchFMDB;



//插入数据
-(void)insterSearchModel:(XZSearchModel *)searchModel;
//获取全部数据
-(NSMutableArray *)selecAllSearchModel;
//根据关键字删除数据
-(void)deleteSearchModelByKeyWord:(NSString *)keyWord;
//删除全部数据
-(void)deleteAllSearchModel;
@end
