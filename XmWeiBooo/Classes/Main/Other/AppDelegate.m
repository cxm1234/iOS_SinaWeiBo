//
//  AppDelegate.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/3.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "AppDelegate.h"
#import "XMNewfeatureController.h"
#import "XMTabBarViewController.h"
#import "XMHomeViewController.h"
#import "XMMessageCenterViewController.h"
#import "XMDiscoverViewController.h"
#import "XMProfileViewController.h"
#import "XMOAuthViewController.h"
#import "XMAccount.h"
#import "XMAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window=[[UIWindow  alloc] init];
    self.window.frame=[UIScreen mainScreen].bounds;
    

    
    XMAccount *account=[XMAccountTool account];
    
    
    XMLog(@"%@",account);
    if (account)
    {
        
        [self.window switchRootViewController];
    }
    else
    {
        self.window.rootViewController=[[XMOAuthViewController alloc] init];
    }
    
    //先设置主窗口
    [self.window makeKeyAndVisible];
    //3.设置子控制器
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //向操作系统申请后台运行的资格
      UIBackgroundTaskIdentifier task=[application beginBackgroundTaskWithExpirationHandler:^{
        //当申请的后台运行时间已经结束（过期），就会调用这个block
          [application endBackgroundTask:task];
      }];
    
    //在info.plist中设置
    //搞一个0kb的MP3文件,没有声音
    //循环播放
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr=[SDWebImageManager sharedManager];
    
    [mgr cancelAll];
    
    [mgr.imageCache clearMemory];
}

@end
