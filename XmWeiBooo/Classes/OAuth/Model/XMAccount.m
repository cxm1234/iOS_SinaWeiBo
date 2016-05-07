//
//  XMAccount.m
//  XmWeiBooo
//
//  Created by blackapple on 16/4/10.
//  Copyright © 2016年 blackapple. All rights reserved.
//

#import "XMAccount.h"

@implementation XMAccount

+(instancetype)accountWithDict:(NSDictionary *)dict
{
    XMAccount *account=[[self alloc] init];
    
    account.access_token=dict[@"access_token"];
    account.uid=dict[@"uid"];
    account.expires_in=dict[@"expires_in"];
    account.created_time=[NSDate date];
    return account;
}


//在这个方法中说明这个对象的哪些方法哪些属性存进沙盒
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}


//当从沙盒中解档一个对象时，会调用这个方法
//说明沙盒中的属性该怎么解析
-(id)initWithCoder:(NSCoder *)decoder
{
    if(self=[super init])
    {
        self.access_token=[decoder decodeObjectForKey:@"access_token"];
        self.uid=[decoder decodeObjectForKey:@"uid"];
        self.expires_in=[decoder decodeObjectForKey:@"expires_in"];
        self.created_time=[decoder decodeObjectForKey:@"created_time"];
        self.name=[decoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
