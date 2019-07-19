//
//  evaluationContentView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/13.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TextContentBlock)(NSString *content);
typedef void(^GoPhotoAlbumBlock)(void);

@interface UploadImageContentView : UIView
@property (nonatomic, copy) TextContentBlock textContentBlock;
@property (nonatomic, copy) GoPhotoAlbumBlock goPhotoAlbumBlock;

@property (nonatomic, strong) NSMutableArray <UIImage *>*imageArray;

- (void)setDataImagearray:(NSMutableArray <UIImage *>*)imageArray;

@end
