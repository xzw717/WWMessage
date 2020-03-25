//
//  PushViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/3/25.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "PushViewController.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>
@interface PushViewController (){
    NSURL *pushURL;
}
@property (nonatomic, strong) PLMediaStreamingSession *session;
@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
    self.session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:nil];
    [self.view addSubview:self.session.previewView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"start" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 44);
    button.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 80);
    [button addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    pushURL = [NSURL URLWithString:@"rtmp://live.wuwuditu.com/zhibo/live?auth_key=1585697961-0-0-475b0ad2f66a63ae164048fbd95c82c3"];
    // Do any additional setup after loading the view.
}
- (void)actionButtonPressed:(id)sender {
    [self.session startStreamingWithPushURL:pushURL feedback:^(PLStreamStartStateFeedback feedback) {
            if (feedback == PLStreamStartStateSuccess) {
                NSLog(@"Streaming started.");
            }
            else {
                NSLog(@"Oops.");
            }
     }];
}


@end
