//
//  OrderNoteCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/10/22.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderNoteCell : ZW_TableViewCell
@property (nonatomic, strong) UILabel *noteLabel;
- (CGFloat)orderNoteHeight;
@end

NS_ASSUME_NONNULL_END
