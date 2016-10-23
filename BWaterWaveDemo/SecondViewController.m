//
//  SecondViewController.m
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "SecondViewController.h"

#import "RipplesView.h"

@interface SecondViewController (){
    
    CADisplayLink *displayLink;

}

@property (nonatomic, strong) RipplesView *centerRadarView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTestView];
}


- (void)addTestView {
    
    CGFloat width = ( self.view.frame.size.width - 10 ) / 3;
    
    _centerRadarView = [[RipplesView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    
    _centerRadarView.center = self.view.center;
    
    _centerRadarView.circleCount = 10;
    
    _centerRadarView.animationTime = 5;
    
//    _centerRadarView.borderColor = [UIColor greenColor];
    
    _centerRadarView.isRandomColor = YES;
    
    [self.view addSubview:_centerRadarView];
    /**
     *  CADisplayLink 默认一秒触发 60次; 默认frameInterval 为1(若要更改每秒触发次数需改此参数)
     */
    displayLink.preferredFramesPerSecond = 15; // 若为30, 则为一秒触发2次;
    
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}
- (void)changeViewBackgroundColor {
    
    self.view.backgroundColor = [UIColor colorWithRed:(random() % (255 - 1 ) + 1) / 255.0 green:(random() % (255 - 1 ) + 1) / 255.0 blue:(random() % (255 - 1 ) + 1) / 255.0 alpha:1.0];
    
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
