//
//  ViewController.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/12.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "ViewController.h"
#import "WaterWaveView.h"
#import "LXWaveProgressView.h"
#import "RipplesView.h"

#import "SecondViewController.h"
@interface ViewController (){
    
    WaterWaveView *waterWaveView;
    
    LXWaveProgressView *progressView;
    
    UIImageView *ballImageView;
    
    UIView *tempV;
}

@property (nonatomic, strong) RipplesView *centerRadarView;



@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"涟漪.弹性.水波";
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [_centerRadarView drawRect:_centerRadarView.frame];

}


- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
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
    
    
    
    // 涟漪效果
    CGFloat bigWidth = 80;
    CGRect tempRect = CGRectMake(0, 0, bigWidth, bigWidth);
    tempV = [[UIView alloc] initWithFrame:tempRect];
    tempV.center = CGPointMake(self.view.center.x, bigWidth + statusBar_H);
    tempV.layer.masksToBounds = YES;
    tempV.layer.cornerRadius = bigWidth / 2.0;
    tempV.backgroundColor = [UIColor greenColor];
    
    CGFloat temp_W = 1.4 * tempRect.size.width / 2;
    CGRect centerRadarViewRect = CGRectMake(0, 0, temp_W, temp_W);
    _centerRadarView = [[RipplesView alloc] initWithFrame:centerRadarViewRect];
    _centerRadarView.center = tempV.center;
    _centerRadarView.borderColor = [UIColor whiteColor];
    _centerRadarView.animationTime = 4.0f;
    _centerRadarView.circleCount = 2;
    [self.view addSubview:_centerRadarView];
    [self.view addSubview:tempV];
    
    
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
    
    
   
    CGFloat origin_X = self.view.bounds.size.width - 40;
    
    CGFloat origin_Y = self.view.frame.size.height - 50;
    
    CGFloat button_W = 40;
    
    CGFloat button_H = 40;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    nextButton.frame = CGRectMake(origin_X, origin_Y, button_W, button_H);
    
    [nextButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    
    [nextButton addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];
    
}


- (void)resetWaveView:(UIButton *)sender {
    
    progressView.progress = (arc4random() % (50 -20) + 20 ) / 100.0f;
    
    [waterWaveView startWaveToPercent:progressView.progress];

}



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


- (void)nextView:(UIButton *)sender {
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    
    [self.navigationController pushViewController:secondVC animated:YES];
        
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
