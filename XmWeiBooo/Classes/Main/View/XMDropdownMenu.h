//
//  XMDropdownMenu.h
//  XmWeiBooo
//
//  Created by blackapple on 16/4/4.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMDropdownMenu;
@protocol XMDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(XMDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(XMDropdownMenu *)menu;
@end

@interface XMDropdownMenu : UIView

+(instancetype)menu;

-(void)showFrom:(UIView *)from;

-(void)dismiss;


//内容
@property (nonatomic,strong) UIView *content;

@property (nonatomic,strong) UIViewController *contentController;

@property (nonatomic,weak) id<XMDropdownMenuDelegate> delegate;

@end
