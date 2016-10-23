//
//  SecondViewController.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/13.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "SecondViewController.h"
// 侧滑返回
#import "BSDemoNavigationController.h"

#import "RipplesView.h"

@interface SecondViewController () {
    
    
    RipplesView *ripplesV;
    
    
    UIView  *tempV;
    
    CADisplayLink *displayLink;
    
}

@end

@implementation SecondViewController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"SecondViewController";
   
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

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
    
    
    CGFloat temv_W = self.view.frame.size.width / 2;
    
    tempV = [[UIView alloc] initWithFrame:CGRectMake(0, 0,temv_W, temv_W)];
    
    tempV.center = self.view.center;
    
    tempV.backgroundColor = [UIColor greenColor];
    
    tempV.layer.masksToBounds = YES;
    
    tempV.layer.cornerRadius = tempV.frame.size.width / 2;
    
    [self addRipplesView];
    
    [self.view addSubview:tempV];
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeViewBackgroundColor)];
    /**
     *  CADisplayLink 默认一秒触发 60次; 默认frameInterval 为1(若要更改每秒触发次数需改此参数)
     */
    displayLink.frameInterval = 15; // 若为30, 则为一秒触发2次;
    
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}


- (void)addRipplesView {
    
    CGFloat rippleV_W = tempV.frame.size.width * 1.4 / 2;
    
    ripplesV = [[RipplesView alloc] initWithFrame:CGRectMake(0, 0, rippleV_W, rippleV_W)];
    
    ripplesV.center = tempV.center;
    
    ripplesV.circleCount = 20;
    
    ripplesV.animationTime = 5;
    
    ripplesV.borderColor = [UIColor greenColor];
    
    ripplesV.isRandomColor = YES;
    
    [self.view addSubview:ripplesV];
    
}

- (void)changeViewBackgroundColor {
    
    tempV.backgroundColor = [UIColor colorWithRed:(random() % (255 - 1 ) + 1) / 255.0 green:(random() % (255 - 1 ) + 1) / 255.0 blue:(random() % (255 - 1 ) + 1) / 255.0 alpha:1.0];
    
}

- (void)nextView:(UIButton *)sender {
    
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController  *thirdVC = [mainSb instantiateViewControllerWithIdentifier:@"ThirdViewController"];;
    
    [self.navigationController pushViewController:thirdVC animated:YES];
    
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
