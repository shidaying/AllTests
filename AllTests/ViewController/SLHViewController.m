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
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [self fifthTest];
    [self sixthTest];
}
#pragma mark -private method
- (void)firstTest
{
    /*
     *first test 一个字符串里的每个字符后加上换行符，每行只显示一个字
     */
    NSLog(@"************************************************************************************************");
    
    NSString *name = @"是一个失败者，他还需要不断地成长完善，需要不断地努力";
    NSMutableString *menuName = [[NSMutableString alloc] initWithCapacity:10];
    for (int i=0; i<[name length]; i++) {
        NSString *tempStr = [NSString stringWithFormat:@"%C\n",[name characterAtIndex:i]];
        [menuName appendString:tempStr];
    }
    NSLog(@" firstTest menuName = %@",menuName);
}

- (void)secondTest
{
    /*
     *second first,验证旋转后frame 是否跟着变化
     */
    
    NSLog(@"************************************************************************************************");
    
    UILabel *testLabel = [[UILabel alloc] init];
    testLabel.frame = CGRectMake(positionX, positionY, SCREEEN_WIDTH - 2 * positionX, controlHeight);
    testLabel.text = @"是一个失败者，他还需要不断地成长完善，需要不断地努力";
    [self.view addSubview:testLabel];
    NSLog(@"secondTest testLabel.frame = %@",NSStringFromCGRect(testLabel.frame));
    //angle为正得时候，是顺时针旋转，否则就是逆时针旋转
    testLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
    NSLog(@"secondTest new testLabel.frame = %@",NSStringFromCGRect(testLabel.frame));
    
    //两次旋转不会叠加，都是在原始的状态下旋转的
    testLabel.transform = CGAffineTransformMakeRotation(-M_PI/2);
    NSLog(@"secondTest latest testLabel.frame = %@",NSStringFromCGRect(testLabel.frame));
    
    testLabel.frame = CGRectMake(positionX, positionY, 40, SCREEEN_WIDTH - 2 * positionX);
    
    positionY = positionY + testLabel.frame.size.height + distanceY;
}

- (void)thirdTest
{
    /*
     *third test 验证字符串里是或否含有英文是否全部为英文
     */
    
    NSLog(@"************************************************************************************************");
    
    NSString *firstString = @"是一个失败者，他还需要不断地成长完善，需要不断地努力";
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlpha] invertedSet];
    NSString *filtered = [[firstString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [firstString isEqualToString:filtered];
    if ([filtered length] == 0) {
        NSLog(@"thirdTest firstString 没有英文");
    } else {
        if (basic) {
            NSLog(@"thirdTest firstString 全是英文");
        } else {
            NSLog(@"thirdTest firstString 有英文,不全是英文");
        }
        
    }
    
    NSString *secondString = @"时礼欢abc";
    NSString *secondFiltered = [[secondString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    basic = [secondString isEqualToString:secondFiltered];
    if ([secondFiltered length] == 0) {
        NSLog(@"thirdTest secondString 没有英文");
    } else {
        if (basic) {
            NSLog(@"thirdTest secondString 全是英文");
        }
        NSLog(@"thirdTest secondString 有英文,不全是英文");
    }
    
    NSString *thirdString = @"abc";
    NSString *thirdFiltered = [[thirdString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    basic = [thirdString isEqualToString:thirdFiltered];
    if ([thirdFiltered length] == 0) {
        NSLog(@"thirdTest thirdString 没有英文");
    } else {
        if (basic) {
            NSLog(@"thirdTest thirdString 全是英文");
        } else {
            NSLog(@"thirdTest thirdString 有英文,不全是英文");
        }
    }
}

- (void)forthTest
{
    /*
     *fortth test 测试的是 NSValue 的应用，键盘出现时，获取键盘的大小位置等相关得信息
     */
    
    NSLog(@"************************************************************************************************");
    
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

- (void)fifthTest
{
    /*
     *fifth Test 测试的是时间与字符串间得相互转化，时间与时间戳之间的转化
     */
    
    NSLog(@"************************************************************************************************");
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy年MM月dd日HH时mm分ss秒"];//大写HH表示的是24小时制，小写的hh代表的是12小时制
    [myDateFormatter setLocale:[NSLocale currentLocale]];//设置地区
    [myDateFormatter setTimeZone:[NSTimeZone localTimeZone]];//设置时区
    
    NSDate *nowDate = [NSDate date];//和中国上海时间相差了八个小时
    NSLog(@"fifthTest nowDate = %@",nowDate);
    
    CGFloat seconds = 8 * 60 * 60;//8个小时的秒数
    NSDate *nowLocalDate = [nowDate dateByAddingTimeInterval:seconds];
    NSLog(@"fifthTest nowLocalDate = %@",nowLocalDate);
    
    //时间转化为字符串
    NSString *nowDateStr = [myDateFormatter stringFromDate:nowDate];
    NSLog(@"fifthTest nowDateStr = %@",nowDateStr);
    
    NSString *nowLocalDateStr = [myDateFormatter stringFromDate:nowLocalDate];
    NSLog(@"fifthTest nowLocalDateStr = %@",nowLocalDateStr);
    
    //字符串转化为时间
    NSDate *dateFromStr = [myDateFormatter dateFromString:nowLocalDateStr];
    NSLog(@"fifthTest dateFromStr = %@",dateFromStr);
    
    //时间转化为时间戳
    NSInteger nowTimeInterval = [dateFromStr timeIntervalSince1970];
    NSLog(@"fifthTest nowTimeInterval = %d",nowTimeInterval);
    
    //时间戳转化为时间
    NSDate *dateFromInteger = [NSDate dateWithTimeIntervalSince1970:nowTimeInterval];
    NSLog(@"fifthTest dateFromInteger = %@",dateFromInteger);
}
- (void)sixthTest
{
    /*
     *sixthTest 测试的是图片的压缩拉伸，剪切，缩小
    */
    
    NSLog(@"************************************************************************************************");
    
    CGSize targetSize = CGSizeMake(80, 80);
    UIImage *myOriginImage = [UIImage imageNamed:@"nopic.png"];
    NSLog(@"sixthTest myOriginImage frame = %@",NSStringFromCGSize(myOriginImage.size));
    
    NSData *myOriginImagePNGData = UIImagePNGRepresentation(myOriginImage);
    NSLog(@"sixthTest myOriginImagePNGData length = %d",myOriginImagePNGData.length);//转化成png格式
    
    NSData *myOriginImageJPEGData = UIImageJPEGRepresentation(myOriginImage, 1.0);
    NSLog(@"sixthTest myOriginImageJPGData length = %d",myOriginImageJPEGData.length);//转化成jpeg格式
    
    NSData *myOriginImageJPEGLowerData = UIImageJPEGRepresentation(myOriginImage, 0.5);
    NSLog(@"sixthTest myOriginImageJPEGLowerData length = %d",myOriginImageJPEGLowerData.length);//转化成jpeg格式，降低图片质量
    
    UIImage *thumbImage = [self createThumbImage:myOriginImage size:targetSize percent:1 toPath:[self fielPath]];
    NSLog(@"sixthTest thumbImage size = %@",NSStringFromCGSize(thumbImage.size));
    
    NSData *thumbImageJPEGData = UIImageJPEGRepresentation(thumbImage, 1);
    NSLog(@"sixthTest thumbImageJPEGData length = %d",thumbImageJPEGData.length);
    
    UIImage *scaleImage = [self scale:myOriginImage toSize:targetSize];
    NSData *scaleImageData = UIImageJPEGRepresentation(scaleImage, 1);
    NSLog(@"sixthTest scaleImageData length = %d",scaleImageData.length);
    
    UIImage *scaleAndCroppingImage = [self imageByScalingAndCroppingWithImage:myOriginImage forSize:targetSize];
    NSData *scaleAndCroppingImageData = UIImageJPEGRepresentation(scaleAndCroppingImage, 1);
    NSLog(@"sixthTest scaleAndCroppingImageData length = %d",scaleAndCroppingImageData.length);
    
    UIImage *imageLocal = [myOriginImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    
    UIImage *srcimg = [UIImage imageNamed:@"test.png"];//test.png宽172 高192
    NSLog(@"image width = %f,height = %f",srcimg.size.width,srcimg.size.height);
    UIImageView *imgview = [[UIImageView alloc] init];
    imgview.frame = CGRectMake(10, 150, 300, 220);
    CGRect rect =  CGRectMake(0, 0, 300, 100);//要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
    CGImageRef cgimg = CGImageCreateWithImageInRect([srcimg CGImage], rect);
    imgview.image = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);／／用完一定要释放，否则内存泄露
    [self.view addSubview:imgview];
}
/*
 *沙盒路径
 */
- (NSString*)fielPath
{
    NSArray *fielPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [fielPathArray firstObject];
    NSString *fielPath = [documentPath stringByAppendingPathComponent:@"files"];
    return fielPath;
}
/*
 *传入的参数：1、生成图片的大小 2、压缩比 3、存放图片的路径
 */
- (UIImage*)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat scaleFactor = 0.0;
    CGPoint thumbPoint = CGPointMake(0.0,0.0);
    CGFloat widthFactor = thumbSize.width / width;
    CGFloat heightFactor = thumbSize.height / height;
    if (widthFactor > heightFactor)  {
        scaleFactor = widthFactor;
    }
    else {
        scaleFactor = heightFactor;
    }
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (widthFactor > heightFactor)
    {
        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
    }
    else if (widthFactor < heightFactor)
    {
        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
    }
    UIGraphicsBeginImageContext(thumbSize);
    CGRect thumbRect = CGRectZero;
    thumbRect.origin = thumbPoint;
    thumbRect.size.width  = scaledWidth;
    thumbRect.size.height = scaledHeight;
    [image drawInRect:thumbRect];
    
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *thumbImageData = UIImageJPEGRepresentation(thumbImage, percent);
    [thumbImageData writeToFile:thumbPath atomically:NO];
    
    return thumbImage;
}
/*
 *下面的这个方法适用于 对压缩后的图片的质量要求不高或者没有要求,因为这种方法只是压缩了图片的大小
 */
 - (UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/*
 *缩小 UIImage,缩放和剪切
 */
- (UIImage*)imageByScalingAndCroppingWithImage:(UIImage*)originImage forSize:(CGSize)targetSize
{
    UIImage *sourceImage = originImage;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor){
            scaleFactor = widthFactor; // scale to fit height
        }
        else {
            scaleFactor = heightFactor; // scale to fit width
        }
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"could not scale image");
    }
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

    
#pragma mark -notification
/*
 *键盘将出现
 */
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
/*
 *键盘将消失
 */
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
