//
//  UIWindow+Extension.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/16.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "XMTabBarViewController.h"
#import "XMNewfeatureController.h"

@implementation UIWindow (Extension)

-(void)switchRootViewController
{
    NSString *key=@"CFBundleVersion";
    //存储在plist中的版本号
    NSString *lastVersion=[[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[key];
    if([currentVersion isEqualToString:lastVersion])
    {
        self.rootViewController=[[XMTabBarViewController alloc] init];
    }
    else
    {
        self.rootViewController=[[XMNewfeatureController alloc] init];
        //将版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

@end
