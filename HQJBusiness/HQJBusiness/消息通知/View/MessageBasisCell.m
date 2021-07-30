//
//  MessageBasisCell.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/30.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageBasisCell.h"

@implementation MessageBasisCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}


@end
