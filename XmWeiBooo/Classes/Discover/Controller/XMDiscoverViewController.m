//
//  XMDiscoverViewController.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/3.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMDiscoverViewController.h"
#import "XMSearchBar.h"

@interface XMDiscoverViewController ()

@end

@implementation XMDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMSearchBar *searchBar=[XMSearchBar searchBar];
    searchBar.size=CGSizeMake(350, 30);
    
    self.navigationItem.titleView=searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
