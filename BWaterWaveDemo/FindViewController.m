//
//  FindViewController.m
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "FindViewController.h"

#import "PreviewManager.h"

#import "PreviewBigPhotoHelper.h"

@interface FindViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *firstImageV;

@property (weak, nonatomic) IBOutlet UIImageView *secondImageV;

@end

@implementation FindViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self createUI];
}


- (void)createUI {
    
    NSString *imageUrlString = @"http://c.hiphotos.baidu.com/zhidao/pic/item/7a899e510fb30f24c88c846bc895d143ad4b0347.jpg";
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlString]]];
    
    _firstImageV.image = image;
    
    _secondImageV.image = image;
    
    for (int i = 0; i < 2; i ++) {
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPhoto:)];
        
        if (i == 0) {
            
            [_firstImageV addGestureRecognizer:tapG];
            
            _firstImageV.tag = i;
            
        }else{
            
            [_secondImageV addGestureRecognizer:tapG];
            
            _secondImageV.tag = i;
            
        }
        
    }
}



- (void)showBigPhoto:(UITapGestureRecognizer *)tapG {
    
//    UIImageView *currentImageV = (UIImageView *)tapG.view;
//    
//    [PreviewManager showImage:currentImageV];
    
    UIImageView *currentImageV = (UIImageView *)tapG.view;
    
    NSUInteger tag = currentImageV.tag;
    
    [[PreviewBigPhotoHelper sharePreviewBigPhotoHelper] showImageWithImagesArray:@[_firstImageV, _secondImageV] withImageIndex:tag];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationItem.title = @"发现";

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
