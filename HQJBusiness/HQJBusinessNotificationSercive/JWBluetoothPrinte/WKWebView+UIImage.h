//
//  WKWebView+UIImage.h
//  HQJBusinessNotificationSercive
//
//  Created by Ethan on 2020/9/16.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (UIImage)
/**
 *  获取当前加载的网页的截图
 *
 *  @return 图片
 */
- (UIImage *)imageForWebView;

@end

NS_ASSUME_NONNULL_END
