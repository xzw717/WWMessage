//
// HQJTZImagePickerController.m
//
//
//  Created by mymac on 2017/8/25.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HQJTZImagePickerController.h"

@interface HQJTZImagePickerController ()

@end

@implementation HQJTZImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)cancelButtonClick {
    [super cancelButtonClick];
     !self.cancelButtonClickBlock ? : self.cancelButtonClickBlock ();
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
