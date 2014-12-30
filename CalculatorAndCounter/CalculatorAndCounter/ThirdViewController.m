//
//  ThirdViewController.m
//  CalculatorAndCounter
//
//  Created by Junji on 2014/04/17.
//  Copyright (c) 2014年 IdeaNote. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
{
    IBOutlet UIButton *btnStart;
    IBOutlet UIButton *btnStop;
    IBOutlet UIButton *btnReset;
}

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - 読み込み
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    startTime = [NSDate timeIntervalSinceReferenceDate];
    
    timeLabel.text = @"0.00";
     
    btnStop.hidden = YES;
    btnReset.hidden = YES;
    btnStart.hidden = NO;
}


#pragma mark - メモリーワーニング
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - スタート

-(IBAction) strart:(id) sender{
    
    if ([timeTicker isValid] == NO) {
        
        timeTicker = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                  target:self
                                                selector:@selector(showActivity)
                                                userInfo:nil
                                                repeats:YES ];
        
        [timeTicker fire];
    }
    
    btnStop.hidden = NO;
    btnReset.hidden = YES;
    btnStart.hidden = YES;

}


#pragma mark - ストップ

-(IBAction) stop:(id) sender{
    
    [timeTicker invalidate];

    btnStop.hidden = YES;
    btnReset.hidden = NO;
    btnStart.hidden = NO;
    
}

#pragma mark - クリア

-(IBAction) clear:(id) sender{
    
    if ([timeTicker isValid] == YES) {
        
        [timeTicker invalidate];
        timeLabel.text = @"0.00";
        
    } else if ([timeTicker isValid] == NO)
        
        timeLabel.text = @"0.00";
    
    btnStop.hidden = YES;
    btnReset.hidden = YES;
    btnStart.hidden = NO;
}

#pragma mark - 表示メソッド
-(void)showActivity{
    double currentTime = [timeLabel.text floatValue];
    double displayTime = currentTime + 0.01;
    
    timeLabel.text = [NSString stringWithFormat:@"%.2f", displayTime];
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


/*- (void)dealloc {
    [super dealloc];
}*/
@end
