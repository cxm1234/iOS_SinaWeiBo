//
//  XMSearchBar.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/4.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMSearchBar.h"

@implementation XMSearchBar

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.font=[UIFont systemFontOfSize:15];
        self.placeholder=@"请输入搜索条件";
        self.background=[UIImage imageNamed:@"searchbar_textfield_background"];
        //通过initWithImage来创建初始化的UIImageView，UIImageView的尺寸默认等于image的尺寸
        UIImageView *searchIcon=[[UIImageView alloc] init];
        searchIcon.image=[UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width=30;
        searchIcon.height=30;
        searchIcon.contentMode=UIViewContentModeCenter;
        self.leftView=searchIcon;
        self.leftViewMode=UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar
{

    return [[self alloc] init];
}

@end
