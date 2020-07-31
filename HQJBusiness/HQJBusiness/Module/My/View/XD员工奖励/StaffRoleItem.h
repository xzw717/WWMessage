//
//  StaffRoleItem.h
//  HQJBusiness
//
//  Created by mymac on 2020/7/31.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DeleteBlock)(NSString *title);
NS_ASSUME_NONNULL_BEGIN

@interface StaffRoleItem : UICollectionViewCell
@property (nonatomic, strong) NSString *roleTitle;
@property (nonatomic, copy  ) DeleteBlock clickDelete;
@end

NS_ASSUME_NONNULL_END
