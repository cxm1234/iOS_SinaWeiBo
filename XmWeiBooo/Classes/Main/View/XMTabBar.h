//
//  XMTabBar.h
//  XmWeiBooo
//
//  Created by blackapple on 16/4/4.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMTabBar;
@protocol  XMTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(XMTabBar *)tabBar;
@end


@interface XMTabBar : UITabBar
@property (nonatomic,weak) id < XMTabBarDelegate> delegate;

@end
