
//
//  XMNavgationController.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/3.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMNavgationController.h"

@interface XMNavgationController ()

@end

@implementation XMNavgationController

+(void)initialize
{
    //设置整个项目所有item的主题样式
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    NSMutableDictionary *textArr=[NSMutableDictionary dictionary];
    textArr[NSForegroundColorAttributeName]=[UIColor orangeColor];
    textArr[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textArr forState:UIControlStateNormal];
    
    
    //设置不可用状态
    NSMutableDictionary *disableTextArrs=[NSMutableDictionary dictionary];
    disableTextArrs[NSForegroundColorAttributeName]=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.7];
    
    disableTextArrs[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextArrs forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //说明这时push进来的控制器，不是第一个子控制器（不是根控制器）
    if(self.viewControllers.count>0)
    {
        //自动显示和隐藏tabBar
        viewController.hidesBottomBarWhenPushed=YES;
        
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self Action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithTarget:self Action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    
    [super pushViewController:viewController animated:animated];
    
}
-(void)back
{
    [self popViewControllerAnimated:YES];
}
-(void)more
{
    [self popToRootViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
