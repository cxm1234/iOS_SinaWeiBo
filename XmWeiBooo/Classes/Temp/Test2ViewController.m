//
//  Test2ViewController.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/3.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "Test2ViewController.h"
#import "Test3ViewController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Test3ViewController *test3=[[Test3ViewController alloc] init];
    test3.title=@"测试3控制器";
    [self.navigationController pushViewController:test3 animated:YES];
}

@end
