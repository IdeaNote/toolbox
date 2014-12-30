//
//  ThirdViewController.h
//  CalculatorAndCounter
//
//  Created by Junji on 2014/04/17.
//  Copyright (c) 2014年 IdeaNote. All rights reserved.
//

#import <UIKit/UIKit.h>

//ストップウォッチツール

@interface ThirdViewController : UIViewController {
    
    IBOutlet UILabel *timeLabel;
    
    NSTimer          *timeTicker;
    NSTimeInterval    startTime;
    
    double total;
}

#pragma mark - プロパティ設定
@property(nonatomic, retain) UILabel *time;

-(IBAction) strart:(id) sender;
-(IBAction) stop:(id) sender;
-(IBAction) clear:(id) sender;

-(void)showActivity;

@end
