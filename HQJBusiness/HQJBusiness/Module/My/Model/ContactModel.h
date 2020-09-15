//
//  ContactModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/21.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactModel : NSObject
//"type": 1,      ----1：物联网新商业 2：国物追溯平台
//            "signUrl": "合同预览签署地址",
//"peugeotid": 3,   -----标识id
//            "signtime": "签署时间"

/*
 {
     "resultHint": "查询成功",
     "resultCode": 2100,
     "resultMsg": [
         {
             "docId": "63ed3ece4bd540b09378ba82915c4c9b",
             "roleid": 2,
             "rolename": "战略联盟商家",
             "signUrl": "https://smlfront.tsign.cn:8820?flowId=5b7ada010fff4a929350baa7094c361c&accountGid=6d2ed3bbfad74410a4b1f2dad8eaac7a&accountOid=2e52feb4938f472b821295f51973573d",
             "accountid": "2e52feb4938f472b821295f51973573d",
             "signtime": "2019-03-16 16:44:15",
             "signResul": 2,
             "shopid": "fe469ab8-55a2-45a2-82dc-d2e3186ba79c",
             "id": 59,
             "resultDescription": "执行成功",
             "time": "2019-03-16 16:42:35",
             "flowid": "5b7ada010fff4a929350baa7094c361c",
             "signResulName": "已签"
         },
 
 */
@property (nonatomic, strong) NSString *docid;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *signUrl;
@property (nonatomic, strong) NSString *peugeotid;
@property (nonatomic, strong) NSString *signtime;
@property (nonatomic, strong) NSString *docId;
@property (nonatomic, strong) NSString *roleid;
@property (nonatomic, strong) NSString *rolename;
@property (nonatomic, strong) NSString *accountid;
@property (nonatomic, strong) NSString *signResul;
@property (nonatomic, strong) NSString *shopid;
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *resultDescription;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *flowid;
@property (nonatomic, strong) NSString *signResulName;


@end

NS_ASSUME_NONNULL_END
