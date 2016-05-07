//
//  XMDropdownMenu.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/4.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMDropdownMenu.h"
@interface XMDropdownMenu()

//用来显示具体内容的容器
@property(nonatomic,weak) UIImageView *containerView;
@end

@implementation XMDropdownMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIImageView *)containerView
{
    if(!_containerView){
        //如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸
        UIImageView *containerView=[[UIImageView alloc] init];
        containerView.image=[UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled=YES;
        [self addSubview:containerView];
        self.containerView=containerView;
    }
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}

+(instancetype)menu
{
    return [[self alloc] init];
}

-(void)showFrom:(UIView *)from
{
    //获得最上面的Window
    
    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    //设置尺寸
    self.size=window.bounds.size;
    
    //调整灰色图片的位置
    self.containerView.x=(self.width-self.containerView.width)*0.5;
    
    
    //默认情况下fram是以父控件左上角为原点
    //可以转换坐标原点，注意转换的是坐标系，所以对象是superview
    CGRect newFrame=[from.superview convertRect:from.frame toView:window];
    self.containerView.centerX=CGRectGetMidX(newFrame);
    
    self.containerView.y=CGRectGetMaxY(newFrame);
    
    if([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)])
    {
        [self.delegate dropdownMenuDidShow:self];
    }
    
}

-(void)dismiss
{
    [self removeFromSuperview];
    
    if([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)])
    {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    XMLog(@"touchesBegan");
    
    [self dismiss];
}


-(void)setContent:(UIView *)content
{
    _content=content;
    content.x=15;
    content.y=15;

    
    //设置菜单的尺寸
    self.containerView.height=CGRectGetMaxY(content.frame)+15;
    
    //设置containerView的宽度
    
    self.containerView.width=CGRectGetMaxX(content.frame)+15;
    
    [self.containerView addSubview:content];
}


-(void)setContentController:(UIViewController *)contentController
{
    _contentController=contentController;
    
    self.content=contentController.view;
}

@end
