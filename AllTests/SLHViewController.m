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

#define Add_Notification(selectorName, notificationName) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectorName) name:notificationName object:nil];


#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define kAlpha      @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "

#define kNumbers     @"0123456789"

#define kNumbersPeriod  @"0123456789."

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface SLHViewController ()
{
    CGFloat positionX;
    CGFloat positionY;
    CGFloat controlHeight;
    CGFloat distanceY;
    UIFont *myFont;
    
    UITextField *nameTextField;
}
@end

@implementation SLHViewController

- (void)viewWillAppear:(BOOL)animated
{
    Add_Notification(onKeyboardWillShowNotification:, UIKeyboardWillShowNotification);
    Add_Notification(onKeyboardWillHideNotification:, UIKeyboardWillHideNotification)
}
- (void)viewDidLoad
{
    positionX = 20;
    positionY = 0;
    controlHeight = 35;
    distanceY = 10;
    
    myFont = [UIFont systemFontOfSize:20];
    
    [self firstTest];
    [self secondTest];
    [self thirdTest];
    [self forthTest];
}
#pragma mark -private method
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
    testLabel.frame = CGRectMake(positionX, positionY, SCREEEN_WIDTH - 2 * positionX, controlHeight);
    testLabel.text = @"是一个失败者，他还需要不断地成长完善，需要不断地努力";
    [self.view addSubview:testLabel];
    NSLog(@"testLabel.frame = %@",NSStringFromCGRect(testLabel.frame));
    //angle为正得时候，是顺时针旋转，否则就是逆时针旋转
    testLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
    NSLog(@"new testLabel.frame = %@",NSStringFromCGRect(testLabel.frame));
    
    testLabel.frame = CGRectMake(positionX, positionY, 40, SCREEEN_WIDTH - 2 * positionX);
    
    positionY = positionY + testLabel.frame.size.height + distanceY;
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

- (void)forthTest
{
    /*
     *fortth test 测试的是 NSValue 的应用，键盘出现时，获取键盘的大小位置等相关得信息
     */
    
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(positionX, positionY , SCREEEN_WIDTH - 2 * positionX, controlHeight)];
    nameTextField.backgroundColor = [UIColor redColor];
    nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nameTextField.placeholder = @"请输入邮箱";
    nameTextField.tag = 1;
    nameTextField.delegate = self;
    nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    nameTextField.returnKeyType = UIReturnKeyDone;
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    nameTextField.text = @"";
    nameTextField.font = myFont;
    [self.view addSubview:nameTextField];
    
    positionY = positionY + controlHeight + distanceY;
}
#pragma mark -notification
- (void)onKeyboardWillShowNotification:(NSNotification*)notify
{
    NSDictionary* info = [notify userInfo];
    
    //获取键盘大小
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    // 获取动画时间
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^{
        nameTextField.frame = CGRectMake(nameTextField.frame.origin.x, nameTextField.frame.origin.y - keyboardSize.height, nameTextField.frame.size.width, nameTextField.frame.size.height);
    }];
}
- (void)onKeyboardWillHideNotification:(NSNotification*)notify
{
    NSDictionary* info = [notify userInfo];
    
    //获取键盘大小
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    // 获取动画时间
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^{
        nameTextField.frame = CGRectMake(nameTextField.frame.origin.x, nameTextField.frame.origin.y + keyboardSize.height, nameTextField.frame.size.width, nameTextField.frame.size.height);
    }];
}
#pragma mark -textfiled delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [nameTextField resignFirstResponder];
    return YES;
}
@end
