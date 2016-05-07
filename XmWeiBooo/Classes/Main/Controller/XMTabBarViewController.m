//
//  XMTabBarViewController.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/3.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMTabBarViewController.h"
#import "XMNavgationController.h"
#import "XMHomeViewController.h"
#import "XMMessageCenterViewController.h"
#import "XMDiscoverViewController.h"
#import "XMProfileViewController.h"
#import "XMTabBar.h"

@interface XMTabBarViewController ()<XMTabBarDelegate>

@end

@implementation XMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化子控制器
    
    XMHomeViewController *home=[[XMHomeViewController alloc] init];
    [self addChildVc:home WithTitle:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    XMMessageCenterViewController *messageCenter=[[XMMessageCenterViewController alloc] init];
    [self addChildVc:messageCenter WithTitle:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
     
    XMDiscoverViewController *discover=[[XMDiscoverViewController alloc] init];
    [self addChildVc:discover WithTitle:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    XMProfileViewController *profile=[[XMProfileViewController alloc] init];
    [self addChildVc:profile WithTitle:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    
    //更换系统自带的tabbar,KVC
    //不允许修改TabBar的delegate属性(这个TabBar)
    
    XMTabBar *tabBar=[[XMTabBar alloc] init];
//    tabBar.delegate=self;
    
    //这行代码过后，tabbar的delegate就是XMTabBarViewController，自动设置了，如果再次试图修改TabBar的delegate，就会报错。
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    XMLog(@"%@",self.tabBar.subviews);
    
    
}


- (void)addChildVc:(UIViewController *)childVc WithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{

    //设置子控制器的文字和图片
//    childVc.tabBarItem.title=title;
//    childVc.navigationItem.title=title;
    
    childVc.title=title;
    //设置子控制器的图片
    childVc.tabBarItem.image=[UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //设置文字的样式
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    NSMutableDictionary *selectTextAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=XMTextColor;
    selectTextAttrs[NSForegroundColorAttributeName]=[UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    XMNavgationController *nav=[[XMNavgationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  -XMTabBarDelegate

-(void)tabBarDidClickPlusButton:(XMTabBar *)tabBar
{
    UIViewController *vc=[[UIViewController alloc] init];
    vc.view.backgroundColor=XMRandomColor;
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
