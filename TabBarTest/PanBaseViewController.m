//
//  PanBaseViewController.m
//  TabBarTest
//
//  Created by zry on 2016/12/26.
//  Copyright © 2016年 ZRY. All rights reserved.
//

#import "PanBaseViewController.h"

@interface PanBaseViewController ()
@property (nonatomic, strong) UIImageView *imageviewLeft;
@property (nonatomic, strong) UIImageView *imageviewRight;


@end

@implementation PanBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    if (selectedIndex) {
        UIViewController* v1 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex-1];
        UIImage* image1 = [self imageByCropping:v1.view toRect:v1.view.bounds];
        _imageviewLeft = [[UIImageView alloc] initWithImage:image1];
        _imageviewLeft.frame = CGRectMake(_imageviewLeft.frame.origin.x - [UIScreen mainScreen].bounds.size.width, _imageviewLeft.frame.origin.y , _imageviewLeft.frame.size.width, _imageviewLeft.frame.size.height);
        [self.view addSubview:_imageviewLeft];
    }
    if (selectedIndex < 3){
        UIViewController* v2 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex+1];
        UIImage* image2 = [self imageByCropping:v2.view toRect:v2.view.bounds];
        _imageviewRight = [[UIImageView alloc] initWithImage:image2];
        _imageviewRight.frame = CGRectMake(_imageviewRight.frame.origin.x + [UIScreen mainScreen].bounds.size.width, 0, _imageviewRight.frame.size.width, _imageviewRight.frame.size.height);
        [self.view addSubview:_imageviewRight];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    /********用于移除pan时的左右两边的view********/
    if (_imageviewLeft) {
        [_imageviewLeft removeFromSuperview];
    }
    if (_imageviewRight) {
        [_imageviewRight removeFromSuperview];
    }
    /********用于移除pan时的左右两边的view********/
}


-(void)handlePan:(UIPanGestureRecognizer *)pan
{
    NSUInteger index = [self.tabBarController selectedIndex];
    static BOOL canMove = YES;
    //    CGPoint locationBegin = [pan locationInView:self.view];//手势初始位置
    CGPoint velocity = [pan velocityInView:self.view];//加速度
    /******根据加速度方向判断手势方向*******/
    if (pan.state == UIGestureRecognizerStateBegan) {
        if (velocity.x < 0 && index == 3) {
            canMove = NO;
        }else if (velocity.x > 0 && index == 0){
            canMove = NO;
        }else{
            canMove = YES;
        }
    }else if (pan.state == UIGestureRecognizerStateChanged){
        if (!canMove) {
            return;
        }
        CGPoint offset = [pan translationInView:self.view];
        pan.view.center = CGPointMake(pan.view.center.x + offset.x, pan.view.center.y);
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
    }else if (pan.state == UIGestureRecognizerStateEnded){
        canMove = YES;
        if (pan.view.center.x < [UIScreen mainScreen].bounds.size.width && pan.view.center.x > 0) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                pan.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                
            }];
        } else if (pan.view.center.x <= 0){
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                pan.view.center = CGPointMake(-[UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                [self.tabBarController setSelectedIndex:index+1];
                pan.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }];
        } else {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                pan.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width*1.5 ,[UIScreen mainScreen].bounds.size.height/2);
            }completion:^(BOOL finished) {
                [self.tabBarController setSelectedIndex:index-1];
                pan.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 ,[UIScreen mainScreen].bounds.size.height/2);
            }];
        }
    }
    
    
}

//与pan结合使用 截图方法，图片用来做动画
-(UIImage*)imageByCropping:(UIView*)imageToCrop toRect:(CGRect)rect
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize pageSize = CGSizeMake(scale*rect.size.width, scale*rect.size.height) ;
    UIGraphicsBeginImageContext(pageSize);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);
    
    CGContextRef resizedContext =UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext,-1*rect.origin.x,-1*rect.origin.y);
    [imageToCrop.layer renderInContext:resizedContext];
    UIImage*imageOriginBackground =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageOriginBackground = [UIImage imageWithCGImage:imageOriginBackground.CGImage scale:scale orientation:UIImageOrientationUp];
    
    return imageOriginBackground;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
