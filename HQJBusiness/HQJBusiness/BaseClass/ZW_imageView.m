//
//  @property (nonatomic,copy)NSString *zw_image; @property (nonatomic,copy)NSString *zw_image; ZW_imageView.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_imageView.h"

@implementation ZW_imageView

-(void)setZw_image:(NSString *)zw_image {
    
    self.image = [UIImage imageNamed:zw_image];
    
    
}

@end
