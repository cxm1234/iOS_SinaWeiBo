//
//  XMProfileViewController.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/3.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMProfileViewController.h"
#import "XMTestViewController.h"

@interface XMProfileViewController ()

@end

@implementation XMProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"设置" style:0 target:self action:@selector(setting)];
}

-(void)setting
{
    XMTestViewController *test1=[[XMTestViewController alloc] init];
    test1.title=@"test1";
    [self.navigationController pushViewController:test1 animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
