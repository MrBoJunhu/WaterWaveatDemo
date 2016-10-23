//
//  RipplesView.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/12.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "RipplesView.h"

@implementation RipplesView

- (void)drawRect:(CGRect)rect {
  
    [super drawRect:rect];
    
    UIColor *superViewBackgroundColor = self.superview.backgroundColor;
    
    [superViewBackgroundColor setFill];
    
    UIRectFill(rect);
    
    NSInteger pulsingCount = _circleCount;
    
    CGFloat animationDuration = _animationTime;
   
    CALayer * animationLayer = [CALayer layer];

    for (int i = 0; i < pulsingCount; i++) {
       
        CALayer * pulsingLayer = [CALayer layer];
        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
       
        if (_isRandomColor) {
            
            self.borderColor = [UIColor colorWithRed:(random() % (255 - 1 ) + 1) / 255.0 green:(random() % (255 - 1 ) + 1) / 255.0 blue:(random() % (255 - 1 ) + 1) / 255.0 alpha:1.0];
            
        }
        
        pulsingLayer.borderColor = self.borderColor.CGColor;
        pulsingLayer.borderWidth = 1;
        pulsingLayer.cornerRadius = rect.size.height / 2;
        
        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.fillMode = kCAFillModeBackwards;
        animationGroup.beginTime = CACurrentMediaTime() + (double)i * animationDuration / (double)pulsingCount;
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = HUGE;
        animationGroup.timingFunction = defaultCurve;
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @1.4;
        scaleAnimation.toValue = @2.5;
        
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        
        opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
       
        if (_isRandomColor) {
            opacityAnimation.values = @[@0, @0.2, @0.4, @0.6, @0.8, @1, @0.8, @0.6, @0.4, @0.2, @0];
        }
        
        opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
        
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
        [animationLayer addSublayer:pulsingLayer];
    }
    
    
    [self.layer addSublayer:animationLayer];
    
}

/**
 *  <Error>: CGContextSetCompositeOperation: invalid context 0x0. If you want to see the backtrace, please set CG_CONTEXT_SHOW_BACKTRACE environmental variable.

 在苹果官方社区中，工作人员给出的答案是这可能是Xcode7的bug，已经有开发者上交了错误报告，我们暂时可以忽略这个警告。
 
 */


@end
