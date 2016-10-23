//
//  ThirdViewController.m
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "ThirdViewController.h"

#import "WaterWaveView.h"
#import "LXWaveProgressView.h"


@interface ThirdViewController () {
    
    WaterWaveView *waterWaveView;
    
    LXWaveProgressView *progressView;
    
    UIImageView *ballImageView;
    
}

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self createUI];

}

- (void)createUI {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat statusBar_H = 64;
    
    CGFloat d = 160;
    CGRect rect = CGRectMake(0, 0, d, d);
    waterWaveView = [[WaterWaveView alloc] initWithFrame:rect];
    
    waterWaveView.center = CGPointMake(self.view.center.x, self.view.center.y - 80 + statusBar_H);
    waterWaveView.layer.cornerRadius = d / 2;
    waterWaveView.clipsToBounds = YES;
    waterWaveView.restoreLevel = NO;
    [self.view addSubview:waterWaveView];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect buttonRect = CGRectMake(0, 0, 60, 40);
    resetButton.frame = buttonRect;
    resetButton.backgroundColor = [UIColor whiteColor];
    [resetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [resetButton setTitle:@"复位" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(resetWaveView:) forControlEvents:UIControlEventTouchUpInside];
    resetButton.center = CGPointMake(self.view.center.x, CGRectGetMaxY(waterWaveView.frame) + 30);
    [self.view addSubview:resetButton];
    
    
    // 水波动态
    CGRect progressRect = CGRectMake(0, 0, 80, 80);
    progressView =[[LXWaveProgressView alloc] initWithFrame:progressRect];
    progressView.firstWaveColor = [UIColor colorWithRed:134/255.0 green:116/255.0 blue:210/255.0 alpha:1];
    progressView.secondWaveColor = [UIColor colorWithRed:134/255.0 green:116/255.0 blue:210/255.0 alpha:0.5];
    progressView.center = CGPointMake(self.view.center.x, CGRectGetMaxY(resetButton.frame) + 60);
    // 属性更改
    progressView.progress = 0.5;
    
    [self.view addSubview:progressView];

    
    // 弹球
    ballImageView = [[UIImageView alloc] init];
    
    ballImageView.backgroundColor = [UIColor redColor];
    ballImageView.frame = CGRectMake(10, 30 + statusBar_H, 40, 40);
    
    ballImageView.layer.masksToBounds = YES;
    
    ballImageView.layer.cornerRadius = 20;
    
    // 渐变色
    CAGradientLayer *backCAGradientLayer = [CAGradientLayer layer];
    
    backCAGradientLayer.colors = @[[UIColor redColor], [UIColor greenColor]];
    
    backCAGradientLayer.frame = ballImageView.bounds;
    
    [ballImageView.layer addSublayer:backCAGradientLayer];
    
    ballImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:ballImageView];
    
}


- (void)resetWaveView:(UIButton *)sender {
    
    progressView.progress = (arc4random() % (50 -20) + 20 ) / 100.0f;
    
    [waterWaveView startWaveToPercent:progressView.progress];
    
}

#pragma mark - 弹性


// 弹球动画
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *fingerTouch = touches.anyObject;
    
    CGPoint locationPoint = [fingerTouch locationInView:self.view];
    
    /*创建弹性动画
     damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
     velocity:弹性复位的速度
     UIViewAnimationOptionCurveLinear : 曲线动画选项
     
     */
    
    [UIView animateWithDuration:3.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:3 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        
        ballImageView.center = locationPoint;
        
    } completion:^(BOOL finished) {
        
    }];
    
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
