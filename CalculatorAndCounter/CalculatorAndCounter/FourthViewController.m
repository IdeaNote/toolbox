//
//  FourthViewController.m
//  CalculatorAndCounter
//
//  Created by Junji on 2014/04/22.
//  Copyright (c) 2014年 Junji Yamamoto. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController (){
    
    IBOutlet UILabel *textLabel;
    IBOutlet UIButton *switchButton;
    
    bool condition;
}

@end


@implementation FourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}


#pragma mark - 読み込み
//----------------------読み込み

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    [textLabel setText:[NSString stringWithFormat:@"点灯するには ON を押してね！"]];
    textLabel.textColor = [UIColor whiteColor];
    
    [switchButton setBackgroundImage:[UIImage imageNamed:@"light_on_button.png"] forState:UIControlStateNormal];
    
    
    condition = NO;

}
//----------------------読み込み　終了

#pragma mark - メモリーワーニング
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 点灯・消灯ボタン
-(IBAction)pushButton:(id)sender{
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (condition == NO) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        [captureDevice lockForConfiguration:NULL];
        captureDevice.torchMode = AVCaptureTorchModeOn;
        [captureDevice unlockForConfiguration];
        
        [textLabel setText:[NSString stringWithFormat:@"消灯するには OFF を押してね！"]];
        textLabel.textColor = [UIColor grayColor];
        
        [switchButton setBackgroundImage:[UIImage imageNamed:@"light_off_button.png"] forState:UIControlStateNormal];
        
        condition = YES;
    
    } else if (condition == YES) {
        
        self.view.backgroundColor = [UIColor grayColor];
        
        [captureDevice lockForConfiguration:NULL];
        captureDevice.torchMode = AVCaptureTorchModeOff;
        [captureDevice unlockForConfiguration];
        
        [textLabel setText:[NSString stringWithFormat:@"点灯するには ON を押してね！"]];
        textLabel.textColor = [UIColor whiteColor];
        
        [switchButton setBackgroundImage:[UIImage imageNamed:@"light_on_button.png"] forState:UIControlStateNormal];
        
        condition = NO;
    }
}

@end
