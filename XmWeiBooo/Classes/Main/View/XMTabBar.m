//
//  XMTabBar.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/4.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMTabBar.h"
@interface XMTabBar()
@property (nonatomic,weak) UIButton *plusBtn;
@end



@implementation XMTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn=[[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        plusBtn.size=plusBtn.currentBackgroundImage.size;
        
        self.plusBtn=plusBtn;
        
        [self addSubview:plusBtn];

    }
    return self;
}

-(void)plusClick
{
    if([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)])
    {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}


-(void)layoutSubviews
{
    //一定要调用
    [super layoutSubviews];
    
    self.plusBtn.centerX=self.width*0.5;
    self.plusBtn.centerY=self.height*0.5;
    
    
    CGFloat tabbarButtonW=self.width/5;
    CGFloat tabbarButtonIndex=0;
    for (UIView *child in self.subviews)
    {
        Class class=NSClassFromString(@"UITabBarButton");
        if([child isKindOfClass:class])
        {
            child.width=tabbarButtonW;
            child.x=tabbarButtonIndex*tabbarButtonW;
            //增加索引
            tabbarButtonIndex++;
            
            if(tabbarButtonIndex==2)
            {
                tabbarButtonIndex++;
            }
            
         }
    }

}

@end
