//
//  XMMessageCenterViewController.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/3.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMMessageCenterViewController.h"
#import "XMTestViewController.h"
@interface XMMessageCenterViewController ()

@end

@implementation XMMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //iOS7中style没有任何效果，没有背景
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
    
}
//注意生命周期
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)composeMsg
{
    NSLog(@"composeMsg");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *ID=@"ID";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"test-message-%d",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMTestViewController *test=[[XMTestViewController alloc] init];
    test.title=@"测试控制器";
    [self.navigationController pushViewController:test animated:YES];
}

@end
