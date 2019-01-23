//
//  XZSearchModel.m
//  TeamC
//
//  Created by sha xianding on 2017/11/27.
//  Copyright © 2017年 沙先鼎. All rights reserved.
//

#import "XZSearchModel.h"

@implementation XZSearchModel
+(instancetype)creatSearchModel:(NSString *)keyWord currentTime:(NSString *)currentTime{
    
    XZSearchModel *model = [[XZSearchModel alloc]init];
    model.keyWord = keyWord;
    model.currentTime = currentTime;
    return model;
    
}
@end
