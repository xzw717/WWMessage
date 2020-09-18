//
//  ScoreGiftViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/9/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ScoreGiftViewModel.h"

@implementation ScoreGiftViewModel

- (RACSignal *)submitClick{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self sunmitGifterInfo:self.phoneNumer smsCode:self.authCode score:self.score completion:^(id responsObject) {
            [subscriber sendNext:responsObject];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        RACSignal *phoneSignal = [RACObserve(self, phoneNumer) map:^id(NSString *value) {
            if (value.length == 11 ) {
                return @(YES);
                
            } else {
                return @(NO);
            }
            
        }];
        
        RACSignal *authCodeSignal = [RACObserve(self, authCode) map:^id(NSString *value) {
            if (value.length == 6) {
                return @(YES);
            }else{
                return @(NO);
            }
            
        }];
        RACSignal *scoreSignal = [RACObserve(self, score) map:^id(NSString *value) {
            if (value.integerValue > 0 && value.integerValue < 2000) {
                return @(YES);
            }else{
                return @(NO);
            }
            
        }];
        
        _codeBtnEnable = [RACSignal combineLatest:@[phoneSignal] reduce:^id(NSNumber *phoneNumer){
            return @([phoneNumer boolValue]);
        }];
        
        _codeBtnCommand =  [[RACCommand alloc]initWithEnabled:_codeBtnEnable signalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [self senderCodePhone:self.phoneNumer completion:^(id responsObject) {
                    [subscriber sendNext:responsObject];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
        
        _summitBtnEnable = [RACSignal combineLatest:@[phoneSignal,authCodeSignal,scoreSignal] reduce:^id(NSNumber *phoneNumer,NSNumber *authCodeNumber,NSNumber *scoreNumber){
            return @([phoneNumer boolValue] && [authCodeNumber boolValue] && [scoreNumber boolValue]);
        }];
        
        _summitBtnCommand =   [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [self submitClick];
        }];
        
        
        
        
    }
    return self;
}
- (void)senderCodePhone:(NSString *)phone completion:(void(^)(id responsObject))completion{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBXdAwardSmsInterface];
    
    NSDictionary *parameterDict = @{@"myid":MmberidStr,
                                    @"merchantId":MmberidStr,
                                    @"mobile":phone,
                                    @"hash":HashCode};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:parameterDict complete:^(NSDictionary *dic) {
        !completion ? :completion(dic);
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
    
}
- (void)sunmitGifterInfo:(NSString *)mobile smsCode:(NSString *)smsCode score:(NSString *)score completion:(void(^)(id responsObject))completion{
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBMerchantAwardToConsumerInterface];
    
    NSDictionary *parameterDict = @{@"myid":MmberidStr,
                                    @"merchantId":MmberidStr,
                                    @"mobile":mobile,
                                    @"verifyCode":smsCode,
                                    @"amount":score,
                                    @"orderNo":[NSString stringWithFormat:@"%@%@",MmberidStr,[ManagerEngine currentTimeStr]],
                                    @"hash":HashCode};
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:parameterDict complete:^(NSDictionary *dic) {
        !completion ? :completion(dic);
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
