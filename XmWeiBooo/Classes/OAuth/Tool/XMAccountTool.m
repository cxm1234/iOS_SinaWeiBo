//
//  XMAccountTool.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/10.
//  Copyright © 2016年 blackapple. All rights reserved.
//  处理账号相关的所有信息：存储账号、取出账号、

#import "XMAccountTool.h"
#import "XMAccount.h"

#define XMAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation XMAccountTool

+(void)saveAccount:(XMAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:XMAccountPath];
}

+ (XMAccount *)account
{
    XMAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:XMAccountPath];
    
    //验证账号是否过期
    
    //过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    NSDate *expiresTime=[account.created_time dateByAddingTimeInterval:expires_in];
    NSDate *now=[NSDate date];
    
    //如果now>=expiresTime，过期
    NSComparisonResult result=[expiresTime compare:now];
    
    /*
     NSOrderedAscending = -1L,  升序
     NSOrderedSame, 
     NSOrderedDescending  降序
     */
    
    if(result != NSOrderedDescending){ //过期
        return  nil;
    }
    
    return account;
}



@end
