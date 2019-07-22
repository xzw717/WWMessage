//
//  CatalogueViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/17.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CatalogueViewModel.h"
@interface CatalogueViewModel ()
@property (nonatomic, strong) GoodsCatalogueTopView *topView;
@end
@implementation CatalogueViewModel
- (instancetype)initWithTopView:(GoodsCatalogueTopView *)topView {
    self = [super init];
    if (self) {
        _topView = topView;
    }
    return self;
}
- (void)topViewWithItemTitle:(NSString *)title {
    
}

- (void)bootomViewWithText:(NSString *)text {
    [self.topView addItem:text];
}
@end
