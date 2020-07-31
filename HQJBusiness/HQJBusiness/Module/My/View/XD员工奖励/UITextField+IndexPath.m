//
//  UITextField+IndexPath.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/29.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UITextField+IndexPath.h"
#import <objc/runtime.h>


@implementation UITextField (IndexPath)
static char indexPathKey;
- (NSIndexPath *)indexPath {
    return objc_getAssociatedObject(self, &indexPathKey);
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
