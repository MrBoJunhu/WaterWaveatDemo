
//
//  ThirdViewController.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/13.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "ThirdViewController.h"
#import "RipplesView.h"


@interface ThirdViewController ()
@property (nonatomic, strong) RipplesView *centerRadarView;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTestView];
}

- (void)addTestView {
    
    _centerRadarView = [[RipplesView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    _centerRadarView.center = self.view.center;
    
    _centerRadarView.circleCount = 4;
    
    _centerRadarView.animationTime = 5;
    
    _centerRadarView.borderColor = [UIColor redColor];
    
    [self.view addSubview:_centerRadarView];
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    
}

- (IBAction)goBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
            
}


- (IBAction)toTheBadgeTabbarController:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITabBarController *badgeTBC = [sb instantiateViewControllerWithIdentifier:@"badgeTabbarController"];
    
    [self.navigationController pushViewController:badgeTBC animated:YES];
    
    
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
