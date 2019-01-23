//
//  XZSearchModel.h
//  TeamC
//
//  Created by sha xianding on 2017/11/27.
//  Copyright © 2017年 沙先鼎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZSearchModel : NSObject
+(instancetype)creatSearchModel:(NSString *)keyWord currentTime:(NSString *)currentTime;
@property (nonatomic,copy) NSString *keyWord;
@property (nonatomic,copy) NSString *currentTime;
@end
