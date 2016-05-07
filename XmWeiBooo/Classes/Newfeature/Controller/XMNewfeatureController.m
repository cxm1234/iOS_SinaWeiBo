//
//  XMNewfeatureController.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/4.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMNewfeatureController.h"
#import "XMTabBarViewController.h"
#define XMNewfeatureCount 4

@interface XMNewfeatureController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageControl;
@end

@implementation XMNewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建一个scrollView:显示所有的新特性图片
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    
    scrollView.delegate=self;
    //某个方向不能滚动，这个饭方向传0

    scrollView.frame=self.view.bounds;
    [self.view addSubview:scrollView];
    
    
    CGFloat scrollW=scrollView.width;
    CGFloat scrollH=scrollView.height;
    for (int i=0; i<XMNewfeatureCount; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        imageView.width=scrollW;
        imageView.height=scrollH;
        imageView.y=0;
        imageView.x=i*scrollW;
        NSString *name=[NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image=[UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        
        //如果是最后一个imageView，往里面添加东西
        if(i==XMNewfeatureCount-1){
            [self setupLastImageView:imageView];
        }
        
    }
    scrollView.contentSize=CGSizeMake(XMNewfeatureCount*scrollView.width, 0);
    //去除弹簧效果
    scrollView.bounces=NO;
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO;
    
    //添加pageControl:分页，展示目前看到的是第几页
    UIPageControl *pageControl=[[UIPageControl alloc] init];
    pageControl.numberOfPages=XMNewfeatureCount;
//  没有宽高，里面的内容还是照常显示
//  pageControl.width=100;
//  pageControl.height=50;
    pageControl.centerX=scrollW*0.5;
    pageControl.centerY=scrollH-50;
    
    pageControl.pageIndicatorTintColor=XMColor(189, 189, 189);
    pageControl.currentPageIndicatorTintColor=XMColor(253, 98, 42);
    
    self.pageControl=pageControl;
    [self.view addSubview:pageControl];
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    
    imageView.userInteractionEnabled=YES;
    //分享按钮
    UIButton *shareBtn=[[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    
    shareBtn.width=150;
    shareBtn.height=30;
    shareBtn.centerX=imageView.width*0.5;
    shareBtn.centerY=imageView.height*0.65;
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    shareBtn .contentEdgeInsets=UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    shareBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    
    
    [imageView addSubview:shareBtn];
    
    
    //开始微博
    UIButton *startBtn=[[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    startBtn.size=startBtn.currentBackgroundImage.size;
    startBtn.centerX=shareBtn.centerX;
    startBtn.centerY=imageView.height*0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
    
}

- (void)startClick:(UIButton *)startBtn
{
    //切换到XMTabBarController
    /*
     1.push:依赖于UINavigationController
     2.modal:新特性控制器不会被销毁
     3.切换window的rootViewController
     */
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=[[XMTabBarViewController alloc] init];
    
    XMLog(@"startClick");
}

- (void)dealloc
{
    XMLog(@"dealloc");
}

- (void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected=!shareBtn.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page=scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage=(int)(page+0.5);     
    //四舍五入 (int)(page+0.5)
    
//    XMLog(@"%f",page);
//    
//    XMLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}

@end
