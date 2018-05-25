//
//  FileEngine.h
//  HQJFacilitator
//
//  Created by mymac on 16/9/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileEngine : NSObject
typedef NS_ENUM(NSInteger,filenameStlye)
{
    
    /**
     *fileLoginStyle - 用户id 及用户名
     *fileDefaultStyle - 用户积分,姓名,及用户类型
     *fileHomeDataStyle - 
     *filePathlocationStyle - 定位信息
     */
    
    
    fileLoginStyle = 0,
    
    fileDefaultStyle,
    
    fileHomeDataStyle,
    
    filePathlocationStyle
    
};
/**
 *  查询
 *
 *  @param str 需要查询的字符串
 *  @param isC 查询的种类
 *
 *  @return 对应的字符串下储存的信息
 */
+(id)filePathNameReadName:(NSString *)str andstye:(filenameStlye)isC;

/**
 *  存用户的ID等信息
 *
 *  @param dic  需要存的字典

 */
+(void)filePathNameCreateandNameMutablefilePatch:(filenameStlye)type Dictionary:(NSMutableDictionary *)dic;

/**
 *  删除对应的文件
 *
 *  @param style 文件类型
 */
+(void)fileRemove:(filenameStlye)style;
@end
