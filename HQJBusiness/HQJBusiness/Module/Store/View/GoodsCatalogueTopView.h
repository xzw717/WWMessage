//
//  GoodsCatalogueTopView.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/16.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class GoodsCatalogueModel;
@protocol GoodsCatalogueTopViewDelegate <NSObject>

@optional
/// 点击的目录
- (void)topViewWithItemTitle:(NSString *)title;
@end
typedef void(^SelectedItem)(NSString *title);
@interface GoodsCatalogueTopView : UIScrollView
@property (nonatomic, copy) SelectedItem itemtitleBolck;
@property (nonatomic, weak) id <GoodsCatalogueTopViewDelegate> topViewdelegate;
- (void)itemArray:(NSArray <GoodsCatalogueModel *>*)ary;
- (void)addItem:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
