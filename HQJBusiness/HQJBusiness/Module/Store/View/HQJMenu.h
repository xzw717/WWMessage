//
//  HQJMenu.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/25.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  FTPopOverMenuDoneBlock
 *
 *  @param selectedIndex SlectedIndex
 */
typedef void (^HQJPopMenuDoneBlock)(NSInteger selectedIndex);
/**
 *  FTPopOverMenuDismissBlock
 */
typedef void (^HQJPopMenuDismissBlock)(void);

/**
 *  -----------------------FTPopOverMenuModel-----------------------
 */
@interface HQJPopMenuModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) id image;
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithTitle:(NSString *)title image:(id)image selected:(BOOL)selected;

@end

/**
 *  -----------------------FTPopOverMenuConfiguration-----------------------
 */
@interface HQJPopMenuConfiguration : NSObject

@property (nonatomic, assign) CGFloat menuTextMargin;// Default is 6.
@property (nonatomic, assign) CGFloat menuIconMargin;// Default is 6.
@property (nonatomic, assign) CGFloat menuRowHeight;
@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, assign) CGFloat menuCornerRadius;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) UIEdgeInsets separatorInset;
@property (nonatomic, assign) BOOL ignoreImageOriginalColor;// Default is 'NO', if sets to 'YES', images color will be same as textColor.
@property (nonatomic, assign) BOOL allowRoundedArrow;// Default is 'NO', if sets to 'YES', the arrow will be drawn with round corner.
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *selectedCellBackgroundColor;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGFloat shadowOpacity;
@property (nonatomic, assign) CGFloat shadowRadius;
@property (nonatomic, assign) CGFloat shadowOffsetX;
@property (nonatomic, assign) CGFloat shadowOffsetY;
@property (nonatomic, strong) UIColor *coverBackgroundColor;


/**
 *  defaultConfiguration
 *
 *  @return curren configuration
 */
+ (HQJPopMenuConfiguration *)defaultConfiguration;

@end

/**
 *  -----------------------FTPopOverMenuCell-----------------------
 */
@interface HQJPopMenuCell : UITableViewCell

@end
/**
 *  -----------------------FTPopOverMenuView-----------------------
 */
@interface HQJPopMenuView : UIControl

@end

/**
 *  -----------------------FTPopOverMenu-----------------------
 */
@interface HQJMenu : NSObject

//    menuArray supports following context:
//    1. image name (NSString, only main bundle),
//    2. image (UIImage),
//    3. image remote URL string (NSString),
//    4. image remote URL (NSURL),
//    5. model (FTPopOverMenuModel, select state support)

/**
 show method with sender without images
 
 @param sender sender
 @param menuArray menuArray
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void) showForSender:(UIView *)sender
         withMenuArray:(NSArray *)menuArray
             doneBlock:(HQJPopMenuDoneBlock)doneBlock
          dismissBlock:(HQJPopMenuDismissBlock)dismissBlock;

/**
 show method with sender and image resouce Array
 
 @param sender sender
 @param menuArray menuArray
 @param imageArray imageArray
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void) showForSender:(UIView *)sender
         withMenuArray:(NSArray *)menuArray
            imageArray:(NSArray *)imageArray
             doneBlock:(HQJPopMenuDoneBlock)doneBlock
          dismissBlock:(HQJPopMenuDismissBlock)dismissBlock;

/**
 show method with sender, image resouce Array and configuration
 
 @param sender sender
 @param menuArray menuArray
 @param imageArray imageArray
 @param configuration configuration
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void) showForSender:(UIView *)sender
         withMenuArray:(NSArray *)menuArray
            imageArray:(NSArray *)imageArray
         configuration:(HQJPopMenuConfiguration *)configuration
             doneBlock:(HQJPopMenuDoneBlock)doneBlock
          dismissBlock:(HQJPopMenuDismissBlock)dismissBlock;

/**
 show method for barbuttonitems with event without images
 
 @param event event
 @param menuArray menuArray
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void) showFromEvent:(UIEvent *)event
         withMenuArray:(NSArray *)menuArray
             doneBlock:(HQJPopMenuDoneBlock)doneBlock
          dismissBlock:(HQJPopMenuDismissBlock)dismissBlock;

/**
 show method for barbuttonitems with event and imageArray
 
 @param event event
 @param menuArray menuArray
 @param imageArray imageArray
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void) showFromEvent:(UIEvent *)event
         withMenuArray:(NSArray *)menuArray
            imageArray:(NSArray *)imageArray
             doneBlock:(HQJPopMenuDoneBlock)doneBlock
          dismissBlock:(HQJPopMenuDismissBlock)dismissBlock;


/**
 show method for barbuttonitems with event, imageArray and configuration
 
 @param event event
 @param menuArray menuArray
 @param imageArray imageArray
 @param configuration configuration
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void) showFromEvent:(UIEvent *)event
         withMenuArray:(NSArray *)menuArray
            imageArray:(NSArray *)imageArray
         configuration:(HQJPopMenuConfiguration *)configuration
             doneBlock:(HQJPopMenuDoneBlock)doneBlock
          dismissBlock:(HQJPopMenuDismissBlock)dismissBlock;
/**
 show method with SenderFrame without images
 
 @param senderFrame senderFrame
 @param menuArray menuArray
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void) showFromSenderFrame:(CGRect )senderFrame
               withMenuArray:(NSArray *)menuArray
                   doneBlock:(HQJPopMenuDoneBlock)doneBlock
                dismissBlock:(HQJPopMenuDismissBlock)dismissBlock;

/**
 show method with SenderFrame and image resouce Array
 
 @param senderFrame senderFrame
 @param menuArray menuArray
 @param imageArray imageArray
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void) showFromSenderFrame:(CGRect )senderFrame
               withMenuArray:(NSArray *)menuArray
                  imageArray:(NSArray *)imageArray
                   doneBlock:(HQJPopMenuDoneBlock)doneBlock
                dismissBlock:(HQJPopMenuDismissBlock)dismissBlock;

/**
 show method with SenderFrame, image resouce Array and configuration
 
 @param senderFrame senderFrame
 @param menuArray menuArray
 @param imageArray imageArray
 @param configuration configuration
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void) showFromSenderFrame:(CGRect )senderFrame
               withMenuArray:(NSArray *)menuArray
                  imageArray:(NSArray *)imageArray
               configuration:(HQJPopMenuConfiguration *)configuration
                   doneBlock:(HQJPopMenuDoneBlock)doneBlock
                dismissBlock:(HQJPopMenuDismissBlock)dismissBlock;
/**
 *  dismiss method
 */
+ (void) dismiss;

@end
