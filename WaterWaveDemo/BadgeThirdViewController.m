//
//  BadgeThirdViewController.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/16.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "BadgeThirdViewController.h"
#import <Accelerate/Accelerate.h>
#import "PreviewManager.h"  // 查看大图
@interface BadgeThirdViewController ()

/**
 *  模糊效果去除白边
 */
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
/**
 *  原图
 */
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
/**
 *  高斯模糊, 但是有白边
 */
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@end

@implementation BadgeThirdViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_NoMsgToRead object:nil];
    
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    UIImage *testImage = [UIImage imageNamed:@"banner"];
    //
 
//    NSString *imageUrlString = @"http://c.hiphotos.baidu.com/zhidao/pic/item/7a899e510fb30f24c88c846bc895d143ad4b0347.jpg";

    
    NSString *imageUrlString = @"http://imgsrc.baidu.com/forum/pic/item/9ce4d20735fae6cd6a8e5c9c0fb30f2443a70f67.jpg";
    
    UIImage *testImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlString]]];
    
    _topImageView.image = [self boxblurImage:testImage withBlurNumber:0.3];
    
    _middleImageView.image = testImage;
    
    _bottomImageView.image = [self coreBlurImage:testImage withBlurNumber:5];
    
    
    // 轻拍查看大图
    for (int i = 0; i < 3; i ++) {
        
        UIImageView *imageV = (UIImageView *)[self.view viewWithTag:100 + i];
        
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewBigPicture:)];
        
        [imageV addGestureRecognizer:tapG];
        
    }
    
    
}

#pragma mark - 查看大图
- (void)previewBigPicture:(UITapGestureRecognizer *)tapG {
    
    UIImageView *currentImageV = (UIImageView *)tapG.view;
    
    [PreviewManager showImage:currentImageV];
    
}

#pragma mark - 高斯模糊效果
- (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(blur) forKey:@"inputRadius"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef  outImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *blurImage = [UIImage imageWithCGImage:outImage];
    
    CGImageRelease(outImage);
    
    return blurImage;
}


/*
 vImage属于Accelerate.Framework，需要导入Accelerate下的Accelerate头文件，Accelerate主要是用来做数字信号处理、图像处理相关的向量、矩阵运算的库。图像可以认为是由向量或者矩阵数据构成的，Accelerate里既然提供了高效的数学运算API，自然就能方便我们对图像做各种各样的处理，模糊算法使用的是vImageBoxConvolve_ARGB8888这个函数
 
 */
#pragma mark - 模糊去除白边问题
/**
 *   模糊去除白边问题
 *
 *  @param image image description
 *  @param blur  blur description  为0时为原图
 *
 *  @return return value description
 */
- (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
   
    if (blur < 0.f || blur > 1.f) {
   
        blur = 0.5f;
    
    }
    
    int boxSize = (int)(blur * 40);
    
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
   
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
    
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
