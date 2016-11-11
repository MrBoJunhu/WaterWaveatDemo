//
//  PreviewBigPhotoHelper.m
//  BWaterWaveDemo
//
//  Created by bill on 16/11/10.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "PreviewBigPhotoHelper.h"

@interface PreviewBigPhotoHelper()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *bottomSCV;

@property (nonatomic, strong) NSMutableArray *totalImageVArray;

@property (nonatomic, assign) NSUInteger imageIndex;

@property (nonatomic, strong) UIView *savePictureView;

@property (nonatomic, strong) UIImage *savePhoto;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) CGFloat currentScale;

@end


@implementation PreviewBigPhotoHelper

+ (PreviewBigPhotoHelper *)sharePreviewBigPhotoHelper {
    
    static PreviewBigPhotoHelper *helper = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        helper = [[self alloc] init];
        
    });
    
    return helper;
        
}

- (void)showImageWithImagesArray:(NSArray<UIImageView *> *)imageArray withImageIndex:(NSUInteger)index{

    [_totalImageVArray removeAllObjects];
    _totalImageVArray = [NSMutableArray arrayWithArray:imageArray];
    
    self.imageIndex = index;

    [self createSCV];
    
    
    if (_totalImageVArray.count > 1) {
        
        [self addPageControlAction];
        
    }
    
    [self createSaveView];
    
}

#pragma mark -
- (void)createSCV {
    
    if (_bottomSCV) {
        
        [_bottomSCV removeFromSuperview];
        
    }

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
    
    _bottomSCV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    
    _bottomSCV.backgroundColor = [UIColor clearColor];
    
    _bottomSCV.alpha = 0;
        
    _bottomSCV.pagingEnabled = YES;
    
    _bottomSCV.scrollEnabled = YES;
    
    _bottomSCV.delegate = self;
    
    [keyWindow addSubview:_bottomSCV];
    
    NSUInteger count = _totalImageVArray.count;
    
    _bottomSCV.contentSize = CGSizeMake(screen_width * count, screen_height);
    
    for (NSUInteger i = 0 ; i < count; i++) {
        
        UIImageView *avatarImageView = (UIImageView *)_totalImageVArray[i];
        
        CGFloat newWidth = _bottomSCV.frame.size.width ;
        
        CGFloat newHeight = avatarImageView.image.size.height * newWidth / avatarImageView.image.size.width;
        
        UIImageView *showImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, _bottomSCV.frame.size.height / 2 - newHeight / 2, newWidth, newHeight)];
        
        showImageV.image = avatarImageView.image;
        
        showImageV.userInteractionEnabled = YES;
        
        showImageV.tag = i;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenCurrentImage:)];
        
        tap.numberOfTouchesRequired = 1;
        
        tap.numberOfTapsRequired = 1;
        
        [showImageV addGestureRecognizer:tap];
        
        
        UIScrollView *subSCV = [[UIScrollView alloc] initWithFrame:CGRectMake(screen_width * i, 0, screen_width, screen_height)];
        
        subSCV.backgroundColor = [UIColor clearColor];
        
        subSCV.contentSize = showImageV.image.size;
        
        subSCV.backgroundColor = [UIColor redColor];
        
        subSCV.minimumZoomScale = 0.5;
        
        subSCV.maximumZoomScale = 3.0;
        
        subSCV.delegate = self;
        
        [_bottomSCV addSubview:subSCV];
        
        
        //支持多点触摸
        showImageV.multipleTouchEnabled = YES;
        
//        UIPinchGestureRecognizer *pinG = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImageViewFunction:)];
//        
//        [showImageV addGestureRecognizer:pinG];
        
        [subSCV addSubview:showImageV];
        
        
        UILongPressGestureRecognizer *longG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePhoto:)];
        
        longG.minimumPressDuration = 1;
        
        [showImageV addGestureRecognizer:longG];
        
        
        UITapGestureRecognizer *hiddenG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSaveView)];
        
        [subSCV addGestureRecognizer:hiddenG];
        
        
        
    }
    
    [_bottomSCV setContentOffset:CGPointMake(screen_width * self.imageIndex, 0) animated:NO];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _bottomSCV.backgroundColor = [UIColor blackColor];
        
        _bottomSCV.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
    
}

- (void)addPageControlAction {
    
    if (_pageControl) {
        
        [_pageControl removeFromSuperview];
        
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_bottomSCV.frame) - 40, _bottomSCV.frame.size.width - 20, 30)];
    
    _pageControl.numberOfPages = _totalImageVArray.count;
    
    _pageControl.currentPage = _imageIndex;
    
    [[UIApplication sharedApplication].keyWindow addSubview:_pageControl];
    
}


- (void)createSaveView {
    
    CGFloat buttonHeight = 40;
    
    _savePictureView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_bottomSCV.frame) + 10, _bottomSCV.frame.size.width, buttonHeight * 2)];
    
    _savePictureView.backgroundColor = [UIColor whiteColor];
    
    NSArray *buttonTitleArray = @[@"保存到相册", @"取消"];
    
    for (int i = 0 ; i < 2; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(_savePictureView.frame.size.width / 2 - buttonHeight, buttonHeight * i , buttonHeight * 2 , buttonHeight);
        
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        button.tag = i + 100;
        
        [_savePictureView addSubview:button];
        
        [button addTarget:self action:@selector(touchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UILabel *sepLB =  [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight, _savePictureView.frame.size.width, 1.0f)];
    
    sepLB.backgroundColor = [UIColor blackColor];
    
    [_savePictureView addSubview:sepLB];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_savePictureView];
    
}


#pragma mark - 隐藏图片

- (void)hiddenCurrentImage:(UITapGestureRecognizer*)tap{
    
    [self hiddenSaveView];
    
    UIImageView *currentImageView = (UIImageView *)tap.view;
    
    NSUInteger index = currentImageView.tag;
    
    UIImageView *originalImageView = (UIImageView *)_totalImageVArray[index];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        currentImageView.frame = originalImageView.frame;
        
        _bottomSCV.alpha = 0;
        
        _bottomSCV.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        
        [_bottomSCV removeFromSuperview];
        
        [_savePictureView removeFromSuperview];
        
        [_pageControl removeFromSuperview];
        
    }];
    
}


#pragma  mark - 长按保存图片
- (void)savePhoto:(UILongPressGestureRecognizer *)longG {

    if (_savePhoto) {
        
        _savePhoto = nil;
        
    }
    
    UIImageView *imageV = (UIImageView *)longG.view;
    
    _savePhoto = imageV.image;
    
    [self showSaveView];
    
}

#pragma mark - 保存到相册结果
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if(!error){
    
        NSLog(@"save success");
        
   
    }else{
    
        NSLog(@"save failed");
    
    }
    
    [self hiddenSaveView];

}


- (void)touchButtonAction:(UIButton *)button {
    
    switch (button.tag) {
       
        case 100:
        {
      
            UIImageWriteToSavedPhotosAlbum(_savePhoto, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        }
            break;
            
        case 101:{
            {
                
                [self hiddenSaveView];
                
            }
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark - 显示隐藏保存界面

- (void)showSaveView {
    
    CGRect frame = _savePictureView.frame;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _savePictureView.frame = CGRectMake(0, CGRectGetMaxY(_bottomSCV.frame) - frame.size.height, frame.size.width, frame.size.height);

        
    }];

}


- (void)hiddenSaveView {
    
   CGRect frame = _savePictureView.frame;
    
   [UIView animateWithDuration:0.2 animations:^{
       
        _savePictureView.frame = CGRectMake(0,CGRectGetMaxY(_bottomSCV.frame) + 10, frame.size.width, frame.size.height);
       
   }];
    
}

#pragma mark - 捏合缩放照片
//
//- (void)scaleImageViewFunction:(UIPinchGestureRecognizer *)pinG {
//    
//    UIImageView *imageV = (UIImageView *)pinG.view;
//    
//    UIImage *scrImage = imageV.image;
//    
//    CGFloat scale = pinG.scale;
//    
//    if (pinG.state == UIGestureRecognizerStateBegan) {
//        
//        // 计算当前缩放比
//        _currentScale = imageV.frame.size.width / scrImage.size.width;
//        
//    }
//    
//    // 根据手势处理器的缩放比例计算图片缩放后的目标大小
//    CGSize targeSize = CGSizeMake(scrImage.size.width * scale * _currentScale, scrImage.size.height * scale * _currentScale);
//    
//    imageV.image = [self imageByScalingToSize:targeSize sourceImage:scrImage];
//    
//}
//
//// 对图片做缩放
//- (UIImage *)imageByScalingToSize:(CGSize)targetSize sourceImage:(UIImage *)tempImage{
//  
//    UIImage *sourceImage = tempImage;
//    
//    UIImage *newImage = nil;
//    
//    CGSize imageSize = sourceImage.size;
//    
//    CGFloat width = imageSize.width;
//    
//    CGFloat height = imageSize.height;
//    
//    CGFloat targetWidth = targetSize.width;
//    
//    CGFloat targetHeight = targetSize.height;
//    
//    CGFloat scaleFactor = 0.0;
//    
//    CGFloat scaledWidth = targetWidth;
//    
//    CGFloat scaledHeight = targetHeight;
//    
//    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
//   
//    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
//      
//        CGFloat widthFactor = targetWidth / width;
//        
//        CGFloat heightFactor = targetHeight / height;
//        
//        if (widthFactor < heightFactor)
//           
//            scaleFactor = widthFactor;
//        
//        else
//            scaleFactor = heightFactor;
//        scaledWidth  = width * scaleFactor;
//        scaledHeight = height * scaleFactor;
//        // center the image
//        if (widthFactor < heightFactor) {
//            
//            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
//        } else if (widthFactor > heightFactor) {
//            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
//        }
//    }
//    // this is actually the interesting part:
//    UIGraphicsBeginImageContext(targetSize);
//    CGRect thumbnailRect = CGRectZero;
//    thumbnailRect.origin = thumbnailPoint;
//    thumbnailRect.size.width  = scaledWidth;
//    thumbnailRect.size.height = scaledHeight;
//    [sourceImage drawInRect:thumbnailRect];
//    newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    if(newImage == nil)
//        NSLog(@"could not scale image");
//    return newImage ;
//}
//


#pragma mark - UIScrollView delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    UIImageView *currentImageView = _totalImageVArray[_imageIndex];
    
    return currentImageView;
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == _bottomSCV) {
        
        CGFloat offsetX = _bottomSCV.contentOffset.x;
        
        _imageIndex = offsetX / _bottomSCV.frame.size.width;
        
        _pageControl.currentPage = _imageIndex;
        
    }
    
}

@end
