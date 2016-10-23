//
//  BSDemoNavigationController.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/13.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "BSDemoNavigationController.h"

@interface BSDemoNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIViewController *currentShowVC;

@end

@implementation BSDemoNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (id)initWithRootViewController:(UIViewController *)rootViewController {
    
    // 覆盖创建
    BSDemoNavigationController *navC = [super initWithRootViewController:rootViewController];
    
    navC.interactivePopGestureRecognizer.delegate = self;
    
    navC.delegate = self;
    
    return navC;
    
}

#pragma mark - UIGestureRecognizerDelegate
//这个方法在视图控制器完成push的时候调用

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (navigationController.viewControllers.count == 1) {
       
        //如果堆栈内的视图控制器数量为1 说明只有根控制器，将currentShowVC 清空，为了下面的方法禁用侧滑手势
        self.currentShowVC = nil;
    
    }else{
        
        //将push进来的视图控制器赋值给currentShowVC
        self.currentShowVC = viewController;
        
    }
    
}

//这个方法是在手势将要激活前调用：返回YES允许侧滑手势的激活，返回NO不允许侧滑手势的激活

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
     
        if (self.currentShowVC == self.topViewController) {
           
            //如果 currentShowVC 存在说明堆栈内的控制器数量大于 1 ，允许激活侧滑手势
            return YES;
      
        }else{
            
            //如果 currentShowVC 不存在，禁用侧滑手势。如果在根控制器中不禁用侧滑手势，而且不小心触发了侧滑手势，会导致存放控制器的堆栈混乱，直接的效果就是你发现你的应用假死了，点哪都没反应，感兴趣是神马效果的朋友可以自己试试 = =。
            
            return NO;
            
        }
        
    }
    
    return YES;
}


/*
 
 我们既然不想同时响应侧滑和 scrollView 的滑动事件，那么我要要做的就是让 scrollView 在侧滑手势判定为失败后再响应滚动事件
 
 */

//获取侧滑返回手势
- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer
{
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.view.gestureRecognizers.count > 0)
    {
        for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers)
        {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
            {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
}





#pragma mark - 用法
/*
 
 然后在需要优化的控制中取得我们 BSDemoNavigationController 的实例对象，如何取得方法很多，self.navigationController、单例、appDelegate 等都可以，就不一一赘述了，这里我使用的是 在控制器中使用self.navigationController 获得。
 
 //禁止侧滑手势和tableView同时滑动
 BSDemoNavigationController *navController = (BSDemoNavigationController *)self.navigationController;
 if ([navController screenEdgePanGestureRecognizer]) {
 //指定滑动手势在侧滑返回手势失效后响应
 [self.friendsDemoTableView.panGestureRecognizer requireGestureRecognizerToFail:[navController screenEdgePanGestureRecognizer]];
 }
 
 */



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
