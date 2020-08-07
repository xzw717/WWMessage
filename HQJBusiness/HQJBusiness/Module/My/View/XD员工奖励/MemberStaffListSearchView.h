//
//  MemberStaffListSearchView.h
//  HQJBusiness
//  搜索结果列表
//  Created by mymac on 2020/7/27.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//
@class MemberStaffModel;

@protocol ResultsListDelegate <NSObject>

@optional
- (void)didSelectRowAtIndexPathWithName:(MemberStaffModel *_Nullable)model;
@end
#import <UIKit/UIKit.h>
@class MemberStaffListModel;
NS_ASSUME_NONNULL_BEGIN

@interface MemberStaffListSearchView : UIView
//@property (nonatomic, strong) NSMutableArray <NSString *>*resultsArray;
@property (nonatomic, strong) MemberStaffListModel *searchModel;

@property (nonatomic,   weak) id<ResultsListDelegate> delegate;
- (void)reloadSearchList;
@end

NS_ASSUME_NONNULL_END
