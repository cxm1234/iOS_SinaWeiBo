//
//  XMStatus.h
//  XmWeiBooo
//
//  Created by blackapple on 16/4/16.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMUser.h"
/**
 "created_at": "Tue May 31 17:46:55 +0800 2011",
 "id": 11488058246,
 "text": "求关注。"，
 "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
 "favorited": false,
 "truncated": false,
 "in_reply_to_status_id": "",
 "in_reply_to_user_id": "",
 "in_reply_to_screen_name": "",
 "geo": null,
 "mid": "5612814510546515491",
 "reposts_count": 8,
 "comments_count": 9,
 "annotations": [],
 */
@interface XMStatus : NSObject
@property(nonatomic,copy) NSString *idstr;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) XMUser *user;
//+(instancetype)statusWithDict:(NSDictionary *)dict;

@end
