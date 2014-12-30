//
//  QRReaderVC.h
//  ToolBox
//
//  Created by Junji on 2014/12/31.
//  Copyright (c) 2014年 IdeaNote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRReaderVC : UIViewController
<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureSession *session;
@end
