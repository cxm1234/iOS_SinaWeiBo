//
//  XMTitleButton.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/16.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMTitleButton.h"

@implementation XMTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //粗体17号
        self.titleLabel.font=[UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];

    }
    [self layoutSubviews];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //1.计算label
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=self.titleLabel.font;
    
    self.titleLabel.x=self.imageView.x;
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame);
    
    //2.计算imageView的frame
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
