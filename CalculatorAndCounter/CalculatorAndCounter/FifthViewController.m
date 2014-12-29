//
//  FifthViewController.m
//  CalculatorAndCounter
//
//  Created by Junji on 2014/04/28.
//  Copyright (c) 2014年 Junji Yamamoto. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController () {
    
    int timerCount;
    
    NSTimer *timer;
    
    IBOutlet UILabel *timeLabel;
    
}

@end

@implementation FifthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(timerDevice:)
                                           userInfo:nil
                                            repeats:YES];
    
    timerCount = 10;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
-(IBAction)startButton:(id)sender{
    
    if (timerCount < 0) {
        
        [timer invalidate];
    
    } else {
        
        timerCount = timerCount -1;
    }

}
*/

-(void)timerDevice:(NSTimer *)timer {
    
    if (timerCount < 0) {
        
        [timer invalidate];
        
    } else {
        
        timerCount = timerCount -1;
    }
    
}
@end
