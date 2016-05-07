//
//  XMHomeViewController.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/3.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMHomeViewController.h"
#import "XMDropdownMenu.h"
#import "XMTitleMenuController.h"
#import "AFNetworking.h"
#import "XMAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "XMTitleButton.h"
#import "UIImageView+WebCache.h"
#import "XMUser.h"
#import "XMStatus.h"
#import "MJExtension.h"
#import "XMLoadMoreFooter.h"

@interface XMHomeViewController ()<XMDropdownMenuDelegate>
/**
 
*/
@property(nonatomic,strong)NSMutableArray *statuses;
@end

@implementation XMHomeViewController



-(NSMutableArray *)statuses
{
    if(!_statuses){
        self.statuses=[NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];

    [self setupUserInfo];
    
    
    [self setupDownRefresh];
    
    
    //集成
    [self setupUpRefresh];
    
    //集成上拉刷新控件
    
    //（定时器的）
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)setupUnreadCount
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    //2.拼接请求参数
    XMAccount *account=[XMAccountTool account];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    params[@"uid"]=account.uid;
    
    //发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_cout.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //微博的未读数
        NSString *status=[responseObject[@"status"] description];
        if([status isEqualToString:@"0"]){
            self.tabBarItem.badgeValue=nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber=0;
        }else{
            self.tabBarItem.badgeValue=status;
            [UIApplication sharedApplication].applicationIconBadgeNumber=status.intValue;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XMLog(@"请求失败-%@",error);
    }];
    
}

- (void)setupUpRefresh
{
    XMLoadMoreFooter *footer=[XMLoadMoreFooter footer];
    footer.hidden=YES;
    self.tableView.tableFooterView=footer;
}

- (void)setupDownRefresh
{
    //添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    
    //马上进入刷新状态(仅仅显示刷新状态)
    [control beginRefreshing];
    
    [self loadNewStatus:control];
    
}


/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
- (void)loadNewStatus:(UIRefreshControl *)control
{
    
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    XMAccount *account = [XMAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    XMStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatus.idstr;
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [XMStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [control endRefreshing];
        
        // 显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XMLog(@"请求失败-%@", error);
        
        // 结束刷新刷新
        [control endRefreshing];
    }];
}


- (void)showNewStatusCount:(NSInteger)count
{
    self.tabBarItem.badgeValue=nil;
    
    UILabel *label=[[UILabel alloc] init];
    label.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width=[UIScreen mainScreen].bounds.size.width;
    label.height=35;
    
    if(count==0){
        label.text=@"没有新的微博数据";
    }else{
        label.text=[NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:16];
    
    
    label.y=64-label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    CGFloat duration=1.0;
    
    [UIView animateWithDuration:duration animations:^{
//        label.y+=label.height;
        
        label.transform=CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay=1.0;  //延迟1s
        
       [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
//           label.y-=label.height;
           
           label.transform=CGAffineTransformIdentity;
       } completion:^(BOOL finished) {
           [label removeFromSuperview];
       }];
    }];
}

- (void)loadMoreStatus
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    
    
    XMAccount *account=[XMAccountTool account];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    
    XMStatus *lastStatus=[self.statuses lastObject];
    if(lastStatus){
        long long maxId=lastStatus.idstr.longLongValue-1;
        params[@"max_id"]=@(maxId);
    }
    
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary  *responseObject) {
        XMLog(@"请求成功responseObject--%@",responseObject);
        //用框架实现字典转模型
        NSArray *newStatuses=[XMStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        [self.statuses addObjectsFromArray:newStatuses];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XMLog(@"请求失败-%@",error);
    }];
}

- (void)setupUserInfo
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    
    
    XMAccount *account=[XMAccountTool account];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    params[@"access_token"]=account.access_token;
    params[@"uid"]=account.uid;
    
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary  *responseObject) {
        XMLog(@"请求成功--%@",responseObject);
        
        //标题按钮
        XMTitleButton *titleButton=(XMTitleButton *)self.navigationItem.titleView;
        
        
        XMUser *user=[XMUser objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        account.name=user.name;
        [XMAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XMLog(@"请求失败-%@",error);
    }];

}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self Action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithTarget:self Action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    
    XMTitleButton *titleButton=[[XMTitleButton alloc] init];
    NSString *name=[XMAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮自适应
    self.navigationItem.titleView=titleButton;
}


- (void)titleClick:(UIButton *)titleButton
{
    
    XMDropdownMenu *menu=[XMDropdownMenu menu];
    menu.delegate=self;
    XMTitleMenuController *menuVc=[[XMTitleMenuController alloc] init];
    menuVc.view.height=150;
    menuVc.view.width=150;
    menu.contentController=menuVc;
    [menu showFrom:titleButton];

}
- (void)friendSearch
{
    NSLog(@"friendSearch");
}

- (void)pop
{
    NSLog(@"pop");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - XMDropdownMenuDelegate

//下拉菜单被销毁
-(void)dropdownMenuDidDismiss:(XMDropdownMenu *)menu
{
    UIButton *titleButton=(UIButton *)self.navigationItem.titleView;
    titleButton.selected=NO;
}

-(void)dropdownMenuDidShow:(XMDropdownMenu *)menu
{
    UIButton *titleButton=(UIButton *)self.navigationItem.titleView;
    titleButton.selected=YES;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *ID=@"statues";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    XMStatus *status=self.statuses[indexPath.row];
    
    XMUser *user=status.user;
    cell.detailTextLabel.text=status.text;
    
    
//    NSDictionary *user=status[@"user"];
    
    cell.textLabel.text=user.name;
    
//    cell.detailTextLabel.text=status[@"text"];
    
    NSString *imageUrl=user.profile_image_url;
    UIImage *placehoder=[UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placehoder];
    
    //设置头像
    XMLog(@"%@",user);
    return cell;
}


@end
