//
//  BookScoreCell.h
//  WuWuMap
//
//  Created by 姚志中 on 2020/11/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BooKScoreModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookScoreCell : ZW_TableViewCell
@property (nonatomic, strong) BooKScoreModel *model;
@end

NS_ASSUME_NONNULL_END
