//
//  GoodsModel.h
//  HQJBusiness
//
//  Created by mymac on 2017/8/17.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsModel : NSObject
@property (nonatomic, strong) NSString *goodsname;
@property (nonatomic, strong) NSString *goodsid;
@property (nonatomic, assign) CGFloat   goodsprice;
@property (nonatomic, assign) NSInteger goodscount;
@property (nonatomic, strong) NSString *mainpicture;
@end
