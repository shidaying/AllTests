//
//  SLHViewController.m
//  AllTests
//
//  Created by hour on 14-6-25.
//  Copyright (c) 2014年 上海思墨信息科技有限公司. All rights reserved.
//

#import "SLHViewController.h"

#define SCREEEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define distanceX 20

#define distanceY 100

#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define kAlpha      @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "

#define kNumbers     @"0123456789"

#define kNumbersPeriod  @"0123456789."

@interface SLHViewController ()

@end

@implementation SLHViewController

- (void)viewDidLoad
{
    [self firstTest];
    [self secondTest];
    [self thirdTest];
}
- (void)firstTest
{
    /*
     *first test 一个字符串里的每个字符后加上换行符，每行只显示一个字
     */
    
    NSString *name = @"是一个失败者，他还需要不断地成长完善，需要不断地努力";
    NSMutableString *menuName = [[NSMutableString alloc] initWithCapacity:10];
    for (int i=0; i<[name length]; i++) {
        NSString *tempStr = [NSString stringWithFormat:@"%C\n",[name characterAtIndex:i]];
        [menuName appendString:tempStr];
    }
    NSLog(@"menuName = %@",menuName);
}
- (void)secondTest
{
    /*
     *second first,验证旋转后frame 是否跟着变化
     */
    
    UILabel *testLabel = [[UILabel alloc] init];
    testLabel.frame = CGRectMake(distanceX, distanceY, SCREEEN_WIDTH - 2 * distanceX, 40);
    testLabel.text = @"是一个失败者，他还需要不断地成长完善，需要不断地努力";
    [self.view addSubview:testLabel];
    NSLog(@"testLabel.frame = %@",NSStringFromCGRect(testLabel.frame));
    
    testLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
    NSLog(@"new testLabel.frame = %@",NSStringFromCGRect(testLabel.frame));
    
}

- (void)thirdTest
{
    /*
     *third test 验证字符串里是或否含有英文是否全部为英文
     */
    
    NSString *firstString = @"是一个失败者，他还需要不断地成长完善，需要不断地努力";
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlpha] invertedSet];
    NSString *filtered = [[firstString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [firstString isEqualToString:filtered];
    if ([filtered length] == 0) {
        NSLog(@"firstString 没有英文");
    } else {
        if (basic) {
            NSLog(@"firstString 全是英文");
        } else {
            NSLog(@"firstString 有英文,不全是英文");
        }
        
    }
    
    NSString *secondString = @"时礼欢abc";
    NSString *secondFiltered = [[secondString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    basic = [secondString isEqualToString:secondFiltered];
    if ([secondFiltered length] == 0) {
        NSLog(@"secondString 没有英文");
    } else {
        if (basic) {
            NSLog(@"secondString 全是英文");
        }
        NSLog(@"secondString 有英文,不全是英文");
    }
    
    NSString *thirdString = @"abc";
    NSString *thirdFiltered = [[thirdString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    basic = [thirdString isEqualToString:thirdFiltered];
    if ([thirdFiltered length] == 0) {
        NSLog(@"thirdString 没有英文");
    } else {
        if (basic) {
            NSLog(@"thirdString 全是英文");
        } else {
            NSLog(@"thirdString 有英文,不全是英文");
        }
    }
}

@end
