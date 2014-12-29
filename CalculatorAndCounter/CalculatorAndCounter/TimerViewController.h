//
//  TimerViewController.h
//  TooLBox
//
//  Created by Junji on 2014/05/11.
//  Copyright (c) 2014年 Junji Yamamoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

//キッチンタイマーツール

@interface TimerViewController : UIViewController
{
    
    int timeNumber;
    
    NSTimer *countdownTimer;
    NSTimeInterval startTime;

}

@end
