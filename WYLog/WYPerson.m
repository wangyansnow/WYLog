//
//  WYPerson.m
//  WYLog
//
//  Created by 王俨 on 2018/3/2.
//  Copyright © 2018年 https://github.com/wangyansnow. All rights reserved.
//

#import "WYPerson.h"
#import "WYLog-Swift.h"

@implementation WYPerson

+ (void)log {
    
    [WYLogUtil wy_log:@"I want to go to eat dinner" isWriteToFile:YES filePath:[NSString stringWithUTF8String:__FILE__] function:[NSString stringWithUTF8String:__func__] line:__LINE__];

}

@end
