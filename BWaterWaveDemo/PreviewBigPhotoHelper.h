//
//  PreviewBigPhotoHelper.h
//  BWaterWaveDemo
//
//  Created by bill on 16/11/10.
//  Copyright © 2016年 bill. All rights reserved.
//  查看大图

#import <Foundation/Foundation.h>

@interface PreviewBigPhotoHelper : NSObject

+ (PreviewBigPhotoHelper *)sharePreviewBigPhotoHelper;



- (void)showImageWithImagesArray:(NSArray<UIImageView *>*)imageArray withImageIndex:(NSUInteger)index;


@end
