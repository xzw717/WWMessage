//
//  UploadImageContentView.m
//
//
//  Created by mymac on 2017/7/13.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "UploadImageContentView.h"
//#import "PhotoImageView.h"
//#import "EvaluationTextView.h"
#import "PhotoView.h"
#import "HQJTZImagePickerController.h"
#define ImageWidth ((WIDTH - 29  - 35 / 3 * 2) / 4.f)
#define ImageCount 4
#define SpacingImage (29 / 3.f)
#define LeftRIgthSpeacingImage (35 / 3.f)
@interface UploadImageContentView ()<UITextViewDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, strong) UIView *contentBackgroundView;
//@property (nonatomic, strong) EvaluationTextView *textView;
@property (nonatomic, strong) UIButton *photographButton;
@property (nonatomic, strong) NSMutableArray *imageViewCopyArray;

//@property (nonatomic, strong) PhotoImageView *photoImageView;
@property (nonatomic, strong) UILabel *remainingStringLabel;
@property (nonatomic, strong) NSMutableArray  <PhotoView *> *imageViewArray;

@end

@implementation UploadImageContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        self.imageViewArray = [NSMutableArray array];
        self.imageArray     = [NSMutableArray array];
        self.imageViewCopyArray = [NSMutableArray array];
        [self updateConstraintsIfNeeded];
        [self setNeedsUpdateConstraints];
    }
    return self;
}


- (void)goPhotoAlbum {
    [self addPotho2];
//    !self.goPhotoAlbumBlock ? : self.goPhotoAlbumBlock();
}

- (void)addSubviews {
    [self addSubview:self.contentBackgroundView];
    [self.contentBackgroundView addSubview:self.photographButton];
    [self.contentBackgroundView addSubview:self.remainingStringLabel];
}

- (void)updateConstraints {
    [self.contentBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    [self.photographButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LeftRIgthSpeacingImage);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(ImageWidth, ImageWidth));
    }];
    
    
    [self.remainingStringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        
    }];
    
    
    [super updateConstraints];
}

- (UIView *)contentBackgroundView {
    if (!_contentBackgroundView) {
        _contentBackgroundView = [[UIView alloc]init];
        [_contentBackgroundView setBackgroundColor:[UIColor whiteColor]];
    }
    return _contentBackgroundView;
}



- (UIButton *)photographButton {
    if (!_photographButton) {
        _photographButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photographButton  setImage:[UIImage imageNamed:@"goodsRelease_camera"] forState:UIControlStateNormal];
        [_photographButton addTarget:self action:@selector(goPhotoAlbum) forControlEvents:UIControlEventTouchUpInside];
#warning 评价添加图片按钮
//        _photographButton.hidden = YES;
        
    }
    return _photographButton;
}

#pragma mark ---设置图片imageView
- (void)setDataImagearray:(NSMutableArray<UIImage *> *)imageArray {
//    if (self.imageArray.count == 4) {
//
//    } else {
         [self.imageArray addObjectsFromArray:imageArray];
        /// 已经有图片了
        if (self.imageViewArray.count != 0) {
            
            for (PhotoView *oldView in self.imageViewArray) {
                
                NSLog(@"----%ld--_%ld",oldView.tag,self.imageViewArray.count);
                if (oldView.tag == self.imageViewArray.count - 1 +1000) {
                    __block PhotoView *lastView = nil;
                    for (NSInteger i = 0; i < imageArray.count; i ++) {
                        PhotoView *photoImageView = [[PhotoView alloc]init];
                        [self.imageViewArray addObject:photoImageView];

                        [photoImageView.photoDeleteButton addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
                        [photoImageView setPhotoImage:imageArray[i]];
                        [photoImageView setTag:self.imageViewArray.count - 1 + 1000 ];

                        NSLog(@"delete:%ld",self.imageViewArray.count - 1 + 1000);
                        [self.contentBackgroundView  addSubview: photoImageView];
                        [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                            if (lastView) {
                                make.left.mas_equalTo(lastView.mas_right).offset(SpacingImage);
                            } else {
                                make.left.mas_equalTo(oldView.mas_right).offset(SpacingImage);
                            }
                            
                            make.top.mas_equalTo(27 / 3.f);
                            make.size.mas_equalTo(CGSizeMake(ImageWidth, ImageWidth));
                        }];
                        lastView = photoImageView;
                    }
                    [self updateButtonLayout];
                }
            }
            
        } else {
            /// 还没有图片了
            __block PhotoView *lastView = nil;
            for (NSInteger i = 0; i < imageArray.count; i ++) {
                PhotoView *photoImageView = [[PhotoView alloc]init];
                [photoImageView setPhotoImage:imageArray[i]];
                [photoImageView.photoDeleteButton addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
                [photoImageView setTag:i + 1000];
                [self.contentBackgroundView  addSubview: photoImageView];
                
                [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (lastView) {
                        make.left.mas_equalTo(lastView.mas_right).offset(SpacingImage);
                    } else {
                        make.left.mas_equalTo(self.contentBackgroundView.mas_left).offset(15);
                    }
                    make.top.mas_equalTo(27 / 3.f);
                    make.size.mas_equalTo(CGSizeMake(ImageWidth, ImageWidth));
                }];
                lastView = photoImageView;
                [self.imageViewArray addObject:photoImageView];
                
            }
            [self updateButtonLayout];
            //    }
            
            
            
        }
//    }
    
   
}


#pragma mark --- 删除按钮
- (void)deleteBtn:(UIButton *)btn  {
    [self.imageArray removeObjectAtIndex:btn.tag - 1000];
    [self.imageViewArray removeObjectAtIndex:btn.tag - 1000];
    __block PhotoView *lastView = nil;
    for (NSInteger i = 0; i < self.imageArray.count; i ++) {
        PhotoView *photoImageView = self.imageViewArray[i];
        [photoImageView setTag:i + 1000];
        [self.contentBackgroundView  addSubview: photoImageView];
        if (lastView) {
            [photoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView.mas_right).offset(10);
                make.top.mas_equalTo(27 / 3.f);
                make.size.mas_equalTo(CGSizeMake(ImageWidth, ImageWidth));
            }];
        } else {
            [photoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentBackgroundView.mas_left).offset(15);
                make.top.mas_equalTo(27 / 3.f);
                make.size.mas_equalTo(CGSizeMake(ImageWidth, ImageWidth));
            }];
        }
       
        lastView = photoImageView;
    }
    [btn.superview removeFromSuperview];
    [self updateButtonLayout];
}

#pragma mark --- 更新添加按钮的位置
- (void)updateButtonLayout {

    if (self.imageViewArray.count == ImageCount) {
        [self.photographButton setHidden:YES];
    } else {
         [self.photographButton setHidden:NO];
        
        if (self.imageViewArray.count == 0) {
            [self.photographButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(LeftRIgthSpeacingImage);
                make.top.mas_equalTo(20);
                make.size.mas_equalTo(CGSizeMake(75, 75));
            }];
        } else {
            for (PhotoView *lastView in self.imageViewArray) {
                [self.photographButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(lastView.mas_right).offset(SpacingImage);
                    make.top.mas_equalTo(20);
                    make.size.mas_equalTo(CGSizeMake(75, 75));
                }];
            }
        }
        
    }
    
}
- (void)addPotho2 {
    // 还剩可选的张数
    NSInteger optionalCount = ImageCount - self.imageArray.count ;
    HQJTZImagePickerController *imagePickerVc = [[HQJTZImagePickerController alloc] initWithMaxImagesCount:optionalCount delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    @weakify(self);
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        
        
        @strongify(self);
        [self.imageViewCopyArray addObjectsFromArray:photos];
        
        [self setDataImagearray:[photos copy]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray<NSString*>* imageArray = [[NSMutableArray alloc]init];
            [self.imageArray enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSData * imageData = UIImageJPEGRepresentation(obj, 0.5);
                NSString * dataStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                //        dataStr = [dataStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                //        dataStr = [dataStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                //        dataStr = [dataStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                //        dataStr = [dataStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
                //        [dataStr writeToFile:@"/Users/kevin/Desktop/dataStr.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
                //        dataStr = [@"data:image/jpeg;base64,\n" stringByAppendingString:dataStr];
                NSString * mimeType = @"image/jpeg";
                dataStr = [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,dataStr];
                [imageArray addObject:dataStr];
                
#pragma mark ====image
                //        NSData * XH_imageData = [[NSData alloc]initWithBase64EncodedString:dataStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
                //        UIImage * XH_image = [UIImage imageWithData:XH_imageData];
                //        UIImageView * imageV = [[UIImageView alloc]initWithImage:XH_image];
                //        imageV.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                //        [self.view addSubview:imageV];
            }];
            //            [self.evaluateViewModel uploadBase64EncodedPictureWithDataArray:imageArray resultMsg:^(NSString *appendedStr) {
            //                self.appendedStr = appendedStr;
            //                self.uploadState = UploadImageCompleteState;
            //            }];
        });
        
        
        
    }];
    imagePickerVc.cancelButtonClickBlock = ^{
        //        if (self.imageViewCopyArray.count == 0) {
        //            self.uploadState = NoChoiceImageState;
        //        }
    };
    
    
    [[ManagerEngine currentViewControll] presentViewController:imagePickerVc animated:YES completion:nil];
}

//#pragma mark --- 还剩 XXX 个字
//- (UILabel *)remainingStringLabel {
//    if (!_remainingStringLabel) {
//        _remainingStringLabel = [[UILabel alloc]init];
//        [_remainingStringLabel setFont:[UIFont systemFontOfSize:12.0]];
//        [_remainingStringLabel setTextColor:[UIColor lightGrayColor]];
//        [_remainingStringLabel setText:@"0/300"];
//    }
//    return _remainingStringLabel;
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView {
//    !self.textContentBlock ? : self.textContentBlock(textView.text);
//}
//- (void)textViewDidChangeSelection:(UITextView *)textView {
//    self.remainingStringLabel.text = [NSString stringWithFormat:@"%ld/300",textView.text.length];
//}

@end
