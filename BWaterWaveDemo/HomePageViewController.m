//
//  HomePageViewController.m
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "HomePageViewController.h"
#import "UITabBar+UITabBar_Badge.h"
@interface HomePageViewController ()<UIScrollViewDelegate>

// 测试缩放
@property (nonatomic, strong) UIScrollView *SCV;

@property (nonatomic, strong) UIImageView *imageV;


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRedBadge:) name:App_HasNewMsg object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenRedBadge:) name:App_HasNoMsg object:nil];
    
    [self createSCVTest];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title =  @"首页";
    
    NSUInteger msgNum = arc4random() % 10  + 1;
    
    NSDictionary *msgDic = @{ @"msgNum" : [NSString stringWithFormat:@"%ld", msgNum]};
    
    [[ShowRedBadgeHelper shareShowRedBadgeHelper] showRedBadge:YES userInfo:msgDic];
    
}


- (void)showRedBadge:(NSNotification *)notification {
    
    NSString *msgNums = notification.userInfo[@"msgNum"];
    
    [self.tabBarController.tabBar showBadgeOnItemIndex:1 WithMessageNums:msgNums totalTabbarItemNums:3];
    
}

- (void)hiddenRedBadge:(NSNotification *)notification {
   
    NSLog(@"%@", notification.userInfo);
    
    [self.tabBarController.tabBar hiddenBadgeOnItemIndex:1];

}


- (void)createSCVTest {
    
    _SCV = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_SCV];
    
    UIImage *image = [UIImage imageNamed:@"ball.jpg"];
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 200, 200)];
    
    _imageV.image = image;
    
    [_SCV addSubview:_imageV];
    
    _SCV.contentSize = _imageV.image.size;
    
    _SCV.delegate = self;
    
    _SCV.minimumZoomScale = 0.5;
    
    _SCV.maximumZoomScale = 3.0;
    
}

#pragma mark - UIScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return _imageV;
    
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
