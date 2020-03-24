//
//  FileEngine.m
//  HQJFacilitator
//
//  Created by mymac on 16/9/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "FileEngine.h"

@implementation FileEngine
+(void)filePathNameCreateandNameMutablefilePatch:(filenameStlye)type Dictionary:(NSMutableDictionary *)dic
{
    
    
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:[self nameStr:type]];
    

    
    [dic writeToFile:filePatch atomically:YES];
    
}

+(NSString *)nameStr:(filenameStlye)isC
{
    NSString *fileName;
    
    
    switch (isC) {
        case fileDefaultStyle:
            fileName =@"userInfo.plist";
            
            break;
        case fileLoginStyle:
            fileName = @"userInfos.plist";
            
            break;
            
        case fileHomeDataStyle:
            fileName = @"homeData.plist";
            
            break;
        case filePathlocationStyle:
            fileName = @"typeData.plist";
            
            break;
        default:
            break;
    }
    
    return fileName;
    

}

+(id)filePathNameReadName:(NSString *)str andstye:(filenameStlye)isC
{
    
    
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:[self nameStr:isC]];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePatch];
    if (dataDictionary!=nil)
    {
        NSString *currentCity = [dataDictionary objectForKey:str];
        return currentCity;
    }
    else
    {
        
        return nil;
    }
}
+(void)fileRemove:(filenameStlye)style
{
    
    NSFileManager *fileMger = [NSFileManager defaultManager];
    
    NSString *xiaoXiPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:[self nameStr:style]];
    
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:xiaoXiPath];
    
    if (bRet) {
        
        NSError *err;
        
        [fileMger removeItemAtPath:xiaoXiPath error:&err];
    }
}

+ (void)storeToolArray:(NSMutableArray *)array{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(array==nil)
    {
        [defaults setObject:@"" forKey:@"ToolItem"];
    }
    else
    {
        [defaults setObject:array forKey:@"ToolItem"];
    }
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:StoreAddTool object:nil userInfo:nil];

}

/**
 *  存储商品model
 */
+ (void)storeModel:(id)model{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFilePath = paths.firstObject;
    NSString *filePath = [documentFilePath stringByAppendingPathComponent:@"shopModel"];
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
}
/**
 *  得到对应的model
 */
+(id)getModel{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFilePath = paths.firstObject  ;
    NSString *filePath = [documentFilePath stringByAppendingPathComponent:@"shopModel"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}
    



@end
