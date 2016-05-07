//
//  XMAccount.h
//  XmWeiBooo
//
//  Created by blackapple on 16/4/10.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 "access_token" = "2.00zXxq6G0wKnsqa7fb6ddf8bo5q7bD";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5878827351;
 }
 */
//遵守NSCoding协议才能被归档
@interface XMAccount : NSObject<NSCoding>
@property(nonatomic,copy) NSString *access_token;
@property(nonatomic,copy) NSString *expires_in;
@property(nonatomic,copy) NSString *uid;
//
@property(nonatomic,strong) NSDate *created_time;
//用户昵称
@property(nonatomic,copy) NSString *name;

+(instancetype)accountWithDict:(NSDictionary *)dict;

@end
