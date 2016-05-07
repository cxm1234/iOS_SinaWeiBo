//
//  XMLoadMoreFooter.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/17.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMLoadMoreFooter.h"

@implementation XMLoadMoreFooter

+(instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"XMLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
