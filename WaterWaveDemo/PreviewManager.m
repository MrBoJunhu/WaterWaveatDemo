//
//  PreviewManager.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/19.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "PreviewManager.h"

@implementation PreviewManager

static CGRect oldframe;

+ (void)showImage:(UIImageView *)avatarImageView {
    
    UIImage *image = avatarImageView.image;
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    backgroundView.backgroundColor=[UIColor blackColor];
    
    backgroundView.alpha = 0;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    
    imageView.userInteractionEnabled = YES; // 长按手势;
    
    imageView.image = image;
    
    imageView.tag = 1;
    
    [backgroundView addSubview:imageView];
    
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    
    [backgroundView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
    
    // 长按手势
    UILongPressGestureRecognizer *longG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImage:)];
    
    [imageView addGestureRecognizer:longG];
    
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
  
    UIView *backgroundView = tap.view;
    
    UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
    
        imageView.frame = oldframe;
        
        backgroundView.alpha = 0;
    
    } completion:^(BOOL finished) {
    
        [backgroundView removeFromSuperview];
    
    }];

}

+ (void)saveImage:(UILongPressGestureRecognizer *)longPressG {
    
    UIViewController *tempVC = [[UIViewController alloc] init];
    
    UIImageView *imageV = (UIImageView *)longPressG.view;
    
    UIImage *currentImage = imageV.image;
    
    UIAlertController *alterC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否保存到本地相册" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        UIImageWriteToSavedPhotosAlbum(currentImage, nil, nil, nil);
   
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [alterC dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [alterC addAction:saveAction];
    
    [alterC addAction:cancelAction];
    
    [tempVC presentViewController:alterC animated:YES completion:nil];
    
    
}

@end
