//
//  XMAccountTool.h
//  XmWeiBooo
//
//  Created by blackapple on 16/4/10.
//  Copyright © 2016年 blackapple. All rights reserved.
//  处理账号相关的所有操作：存储账号、取出账号、

#import <Foundation/Foundation.h>
#import "XMAccount.h"

@interface XMAccountTool : NSObject

+(void)saveAccount:(XMAccount *)account;


//返回账号信息
+(XMAccount *)account;

@end
