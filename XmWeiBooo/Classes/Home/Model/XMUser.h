//
//  XMUser.h
//  XmWeiBooo
//
//  Created by blackapple on 16/4/16.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMUser : NSObject
//用户UID
@property(nonatomic,copy) NSString *idstr;
//好友显示名称
@property(nonatomic,copy) NSString *name;
//用户头像地址
@property(nonatomic,copy) NSString *profile_image_url;


//+(instancetype)userWithDict:(NSDictionary *)dict;


@end
