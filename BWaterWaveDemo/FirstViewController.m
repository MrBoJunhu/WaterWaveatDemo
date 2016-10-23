//
//  FirstViewController.m
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (IBAction)clickDemo:(id)sender {
    
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITabBarController *homepageC = [mineSB instantiateViewControllerWithIdentifier:@"MyTabbarController"];
    
    [self.navigationController pushViewController:homepageC animated:YES];
    
    
}





@end
