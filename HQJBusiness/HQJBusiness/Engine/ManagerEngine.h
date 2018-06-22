//
//  ManagerEngine.h
//  BeiBeiDemo
//
//  Created by mac on 16/2/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  提示视图的类型
 */
typedef NS_ENUM(NSInteger,promptViewStyle) {
    /**
     *  从上往下,默认是这个(在有Nav )
     */
    promptViewDefault = 0,
    /**
     *  逐渐消失
     */
    promptViewFadeAway
};

///**
// *  提示框按钮数量
// */
//typedef NS_ENUM(NSInteger,ZWAlertViewStyle) {
//    /**
//     *  一个按钮
//     */
//    ZWAlertViewAButtonType = 0,
//    /**
//     *  两个按钮
//     */
//     ZWAlertViewTheTwoBUttonsType
//};
//
//typedef void(^AlertButtonBlock)(id _Nonnull sender);
@interface ManagerEngine : NSObject
+(void)GoMainView;
//+(UIFont *)font_s:(CGFloat)x ;    //字体适配
+ (UIColor *_Nonnull)getColor:(NSString *_Nonnull)hexColor;//-----颜色值转换
+ (UIImage *_Nonnull)createImageWithColor:(UIColor *_Nonnull)color;// ---颜色转换图片




/**
 提示框

 @param tit  提示内容
 @param view 所在视图
 @param type 显示类型
 */
+(void)homeSvpStr:(NSString *_Nonnull)tit andcenterView:(UIView *_Nonnull)view  andStyle:(promptViewStyle)type;


/**
 删除提示框
 */
+(void)dismissHomeSvP;    



+(NSString *_Nonnull)networkStatus;        // --- 网络状态

+(NSInteger)statusBarNetWork;      //----从状态栏获取当前网络状态

+ (NSDate *_Nonnull)getInternetDate; //-----获取网络时间




@property (nonatomic, copy) void(^_Nonnull doTransferMsg)(id _Nonnull str);
//@property (nonatomic, copy) _Nonnull AlertButtonBlock oneBtnBlcok;
//@property (nonatomic, copy) _Nonnull AlertButtonBlock twoBtnBlcok;

/**
 *  封住系统的提醒框 AlertViewController
 *
 *  @param controller 控制器对象
 *  @param tit        标题
 *  @param message    内容
 *  @param oneBtntit  按钮一的内容
 *  @param twoBtntit  按钮二的内容
 *  @param style      按钮数量
 */
//-(void)ZWAlertView:(UIViewController * _Nonnull)controller title:(NSString *_Nullable )tit message:(NSString *_Nonnull)message oneBtnTitle:(NSString  * _Nonnull)oneBtntit twoBtnTitle:(NSString *_Nullable)twoBtntit type:(ZWAlertViewStyle)style ;


#pragma mark - base64
//+ (NSString* _Nonnull)encodeBase64String:(NSString * _Nonnull)input;
//+ (NSString* _Nonnull)decodeBase64String:(NSString * _Nonnull)input;
//+ (NSString* _Nonnull)encodeBase64Data:(NSData * _Nonnull)data;
//+ (NSString* _Nonnull)decodeBase64Data:(NSData * _Nonnull)data;





/**
 *  导航控制器的颜色
 *
 *  @param viewController 视图控制器
 */
//+ (void)navColorStyle:(UIViewController *_Nonnull)viewController;

/**
 *  去掉导航控制器的颜色
 *
 *  @param viewController 视图控制器
 */
+ (void)navUnColorStyle:(UIViewController *_Nonnull)viewController;




/**
 *  更改lebel某个字符的颜色大小
 *
 *  @param  label    需要改变的label
 *  @param  font     字体大小
 *  @param  rag      想要改变的字符
 *  @param  vaColor  改变后的颜色
 */
//+(void)setTextColor:(UILabel *_Nonnull)label FontNumber:(id _Nonnull)font AndRange:(NSRange)range AndColor:(UIColor *_Nonnull)vaColor;
+(void)setTextColor:(UILabel *_Nonnull)label FontNumber:(id _Nonnull)font AndRange:(NSString *_Nonnull)rag AndColor:(UIColor * _Nonnull)vaColor;

/**
 * 计算字体宽度
 *
 * @param str 字符串
 * @paran fonts 字体大小
 * return 字符串的CGRect
 */
+(CGFloat)setTextWidthStr:(NSString *_Nonnull)str andFont:(UIFont *_Nonnull)fonts;


/**
 判断名字是否合法

 @param name 名字

 @return 是否
 */
+ (BOOL)isNameValid:(NSString *_Nonnull)name;


/**
 判断身份证是否合法

 @param identityCard 身份证

 @return 是否
 */
+ (BOOL) validateIdentityCard: (NSString *_Nonnull)identityCard;





/**
 判断手机号是否合法

 @param mobile 手机号

 @return 是否
 */
+ (BOOL)valiMobile:(NSString *_Nonnull)mobile;



/**
 判断邮箱是否合法

 @param email 邮箱

 @return 是否
 */
+ (BOOL) validateEmail:(NSString *_Nonnull)email;



/**
 提示框

 @param str            提示内容
 @param selfController 所在视图控制器对象
 @param back           是否返回
 */
+(void)customAlert:(NSString *_Nonnull)str andViewController:(UIViewController *_Nonnull)selfController isBack:(BOOL)back;




/**
 导航控制器风格

 @param viewConoller 当前控制器对象
 @param send 返回按钮
 */
+(void)navViewWillAppearColor:(UIViewController *_Nonnull)viewConoller  andConmp:(void(^_Nonnull)(id _Nonnull sender))send;




/**
 导航控制器标题

 @param viewConoller 当前控制器对象
 @param title 标题
 */
+(void)navTitle:(UIViewController *_Nonnull)viewConoller andTitle:(NSString *_Nonnull)title;



+ (void)navColorStyle:(UIViewController *_Nonnull)viewController andColor:(UIColor *_Nonnull)color ;


+(void)navViewWillDisappearColor:(UIViewController *_Nonnull)viewContoller;

/**
 小菊花开始
 
 @param view 所在的按钮
 @param center 菊花位置
 */
+(void)loadDateView:(UIButton *_Nonnull)view andPoint:(CGPoint)center;




/**
 * 小菊花结束
 *
 * @param view 所在的按钮
 * @param str 菊花消失
 */
+(void)dimssLoadView:(UIButton *_Nonnull)view andtitle:(NSString *_Nonnull)str;




/**
 * SVP 消失后的行为
 *
 * @param str SVP 提示字符
 * @param jump 跳转或者其他操作
 */
+(void)SVPAfter:(NSString *_Nonnull)str complete:(void(^_Nonnull)(void))jump ;



+ (UIViewController *_Nullable)currentViewControll;

/**
 时间戳转化

 @param str 时间戳
 @return 时间
 */
+(NSString *_Nonnull)reverseSwitchTimer:(NSString *_Nonnull)str ;

/**
 时间戳转化
 
 @param str 时间戳
 @return 时间
 */
+(NSString *_Nonnull)zzReverseSwitchTimer:(NSString *_Nonnull)str;

/**
 生成二维码

 @param str 码的内容
 
 @return CIImage 对象
 */
+ (CIImage *_Nonnull)outputImageStr:(NSString *_Nonnull)str;
+ (UIImage *_Nonnull)createNonInterpolatedUIImageFormCIImage:(CIImage *_Nonnull)image withSize:(CGFloat) size;
@end
