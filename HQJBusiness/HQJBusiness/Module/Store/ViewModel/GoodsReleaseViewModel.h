//
//  GoodsReleaseViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/12.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReleaseButtonView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodsReleaseViewModel : NSObject <ReleaseButtonViewDelegate>
@property (nonatomic, strong) NSArray <NSArray <NSString *>*> *keyAry;
@property (nonatomic, strong) NSArray <NSArray <NSString *>*> *placeholderAry;
@end

NS_ASSUME_NONNULL_END
