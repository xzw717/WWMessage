//
//  CatalogueViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/17.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsCatalogueTopView.h"
#import "GoodsCatalogueBottomView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CatalogueViewModel : NSObject <GoodsCatalogueTopViewDelegate,GoodsCatalogueBottomViewDelegate>
- (instancetype)initWithTopView:(GoodsCatalogueTopView *)topView;
@end

NS_ASSUME_NONNULL_END
