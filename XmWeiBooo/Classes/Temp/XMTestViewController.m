//
//  XMTestViewController.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/3.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMTestViewController.h"
#import "Test2ViewController.h"

@interface XMTestViewController ()

@end

@implementation XMTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Test2ViewController *test2=[[Test2ViewController alloc] init];
    test2.title=@"测试2控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
