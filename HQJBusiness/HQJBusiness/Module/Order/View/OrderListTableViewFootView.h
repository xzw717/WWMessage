//
//  WaitingEvaluationTableViewFootView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/18.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
typedef void (^ClickEvaluationHeaderViewButtonBlock)(void);
typedef void (^ClickEvaluationHeaderViewUserButtonBlock)(UIButton *btn);

@interface OrderListTableViewFootView : UITableViewHeaderFooterView
@property (nonatomic, copy) ClickEvaluationHeaderViewButtonBlock evaluationBlcok;
@property (nonatomic, copy) ClickEvaluationHeaderViewUserButtonBlock useBlock;
@property (nonatomic, copy) ClickEvaluationHeaderViewButtonBlock payBlock;
@property (nonatomic, copy) ClickEvaluationHeaderViewButtonBlock cancelBlock;

@property (nonatomic, copy) NSString *payTimer;
@property (nonatomic, copy) NSString *goodsNumber;
@property (nonatomic, copy) NSString *allPrice;
@property (nonatomic, strong) OrderModel *model;


@end
