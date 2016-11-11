//
//  SecondPictureViewController.m
//  BWaterWaveDemo
//
//  Created by bill on 16/11/10.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "SecondPictureViewController.h"


#import "PreviewBigPhotoHelper.h"

@interface SecondPictureViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation SecondPictureViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self createUI];
    
}



- (void)createUI {
    
    NSString *imageUrlString = @"http://c.hiphotos.baidu.com/zhidao/pic/item/7a899e510fb30f24c88c846bc895d143ad4b0347.jpg";
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlString]]];
    
    _testImageView.image = image;
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageView:)];
        
    [_testImageView addGestureRecognizer:tapG];
}




- (void)showImageView:(UITapGestureRecognizer *)tapG {
   
    UIImageView *currentImageV = (UIImageView *)tapG.view;
   
    [[PreviewBigPhotoHelper sharePreviewBigPhotoHelper] showImageWithImagesArray:@[currentImageV] withImageIndex:0];
    
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
