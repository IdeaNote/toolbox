//
//  TimerViewController.m
//  TooLBox
//
//  Created by Junji on 2014/05/11.
//  Copyright (c) 2014年 Junji Yamamoto. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
{
    IBOutlet UILabel *label;
    
    IBOutlet UIButton *btnStart;
    IBOutlet UIButton *btnStop;
    IBOutlet UIButton *btnReset;
    
    IBOutlet UIButton *minutesPlus;
    IBOutlet UIButton *fivesecondPlus;
    
    
}

@end

@implementation TimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - 読み込み
//----------読み込み
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIApplication *application = [UIApplication sharedApplication];
    
    application.idleTimerDisabled = YES;
    

    startTime = [NSDate timeIntervalSinceReferenceDate];
    
    int totalM = timeNumber / 60;
    label.text = [NSString stringWithFormat:@"%02d:%02d", totalM , timeNumber %60];
    
}
//----------読み込み


#pragma mark - ボタン
//----------ボタン関連
//-----ボタン関連（開始、停止、リセット）
-(IBAction)pushStart:(id)sender{
    
    
    if ([countdownTimer isValid] == NO && timeNumber >0 ) {
    
    
            countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(update)
                                                    userInfo:nil
                                                     repeats:YES];
    
            [countdownTimer fire];
    
        
        btnStart.hidden = YES;
        btnStop.hidden = NO;
        btnReset.hidden = NO;
    }
    
}

-(IBAction)pushStop:(id)sender{
    
    [countdownTimer invalidate];
    
    btnStart.hidden = NO;
    btnStop.hidden = YES;
    btnReset.hidden = NO;
    
}

-(IBAction)pushReset:(id)sender{
    
    if ([countdownTimer isValid] == YES) {
        
        timeNumber = 0;
        
        int totalM = timeNumber / 60;
        label.text = [NSString stringWithFormat:@"%02d:%02d", totalM , timeNumber %60];
        
        [countdownTimer invalidate];
        
        
    } else if ( [countdownTimer isValid] == NO){
        
        timeNumber = 0;
        
        int totalM = timeNumber / 60;
        label.text = [NSString stringWithFormat:@"%02d:%02d", totalM , timeNumber %60];
        
    }
    
    btnStart.hidden = NO;
    btnStop.hidden = YES;
    btnReset.hidden = NO;
    
}


//-----ボタン関連（テンプレ時間設定）

#pragma mark - 各種の時間設定
//カップラーメン用ボタン（3分）
-(IBAction)textSet_3M:(id)sender{
    
    timeNumber = 60 * 3;
    
    int totalM = timeNumber / 60;
    label.text = [NSString stringWithFormat:@"%02d:%02d", totalM , timeNumber%60];
    
}

//ゆで卵用ボタン（6分）
-(IBAction)textSet_6M:(id)sender{
    
    timeNumber = 60 * 6;
    
    int totalM = timeNumber / 60;
    label.text = [NSString stringWithFormat:@"%02d:%02d", totalM , timeNumber%60];
    
}

//ゆで卵用ボタン（8分）
-(IBAction)textSet_8M:(id)sender{
    
    timeNumber = 60 * 8;
    
    int totalM = timeNumber / 60;
    label.text = [NSString stringWithFormat:@"%02d:%02d", totalM , timeNumber%60];
    
}


//ゆで卵用ボタン（10分）
-(IBAction)textSet_10M:(id)sender{
    
    timeNumber = 60 * 10;
    
    int totalM = timeNumber / 60;
    label.text = [NSString stringWithFormat:@"%02d:%02d", totalM , timeNumber%60];
    
}

//-----ボタン関連（テンプレ時間設定）

#pragma mark - 分、秒で加算設定
//-----ボタン関連（微調整時間）
-(IBAction)minutesPlus:(id)sender{
    
    timeNumber = timeNumber + 60;
    
    int totalM = timeNumber / 60;
    label.text = [NSString stringWithFormat:@"%02d:%02d", totalM , timeNumber%60];
    
}

-(IBAction)tenSecondPlus:(id)sender{
    
    timeNumber = timeNumber + 10;
    
    int totalM = timeNumber / 60;
    label.text = [NSString stringWithFormat:@"%02d:%02d", totalM , timeNumber%60];
    
}

//----------ボタン関連

#pragma mark - タイマーの呼び出し部分
- (void)update
{
    if (timeNumber <= 0) {
        [countdownTimer invalidate];
        
        btnStart.hidden = NO;
        btnStop.hidden = YES;
        btnReset.hidden = NO;
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"タイマー完了"
                              message:@"設定したタイマーが終了しました"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil];
       
        [alert show];
        
        
    }
    else {
        
        timeNumber--;
    }
    
    int totalM = timeNumber / 60;
    label.text = [NSString stringWithFormat:@"%02d:%02d", totalM , timeNumber%60];
    
}

#pragma mark - 表示後の処理
-(void)viewWillDisappear:(BOOL)animated {
    
    if ([countdownTimer isValid] == YES) {
        
        [countdownTimer invalidate];
        
    }
    
}

#pragma mark- メモリワーニング
//----------メモリワーニング
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//----------メモリワーニング


@end