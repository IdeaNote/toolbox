//
//  SecondViewController.m
//  CalculatorAndCounter
//
//  Created by Junji on 2014/04/11.
//  Copyright (c) 2014年 Junji Yamamoto. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController (){
    
    IBOutlet UILabel *numberLabel;
    
    IBOutlet UIButton *btnPlus;
    IBOutlet UIButton *btnMinus;
    IBOutlet UIButton *btnReset;
    
    NSString *numberLabelText;
    
    int number;
    
}

@end

@implementation SecondViewController


#pragma mark - 読み込み
//----------読み込み
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    number = 0;
    
    NSNumber *priceNumber = [[NSNumber alloc] initWithInteger:number];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    
    NSString *result = [formatter stringFromNumber:priceNumber];
    
    numberLabelText = [NSString stringWithFormat:@"%@",result];
    
    [numberLabel setText:numberLabelText];
    
    btnReset.hidden = YES;
    btnPlus.hidden = NO;
    btnMinus.hidden = NO;
	
}
//----------読み込み

#pragma mark - ボタン
//----------UI（ボタン関連）

//-----ボタン（プラス）
-(IBAction)plusPush:(id)sender{
    
    number++;
    
    NSNumber *priceNumber = [[NSNumber alloc] initWithInteger:number];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    
    NSString *result = [formatter stringFromNumber:priceNumber];
    
    
    numberLabelText = [NSString stringWithFormat:@"%@",result];
    
    [numberLabel setText:numberLabelText];
    
    btnReset.hidden = NO;
    btnPlus.hidden = NO;
    btnMinus.hidden = NO;
    
}

//-----ボタン（マイナス）
-(IBAction)minusPush:(id)sender{
    
    if (number > 0) {
        
        number--;
        
        btnReset.hidden = NO;
        btnPlus.hidden = NO;
        btnMinus.hidden = NO;
    
        if (number == 0){
        
            btnReset.hidden = YES;
            btnPlus.hidden = NO;
            btnMinus.hidden = NO;
   
        }
    }
    
    NSNumber *priceNumber = [[NSNumber alloc] initWithInteger:number];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    
    NSString *result = [formatter stringFromNumber:priceNumber];
    
    
    numberLabelText = [NSString stringWithFormat:@"%@",result];
    
    [numberLabel setText:numberLabelText];
    
}

//-----ボタン（リセット）
-(IBAction)resetPush:(id)sender {
    
    number = 0;
    
    NSNumber *priceNumber = [[NSNumber alloc] initWithInteger:number];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    
    NSString *result = [formatter stringFromNumber:priceNumber];
    
    
    numberLabelText = [NSString stringWithFormat:@"%@",result];
    
    [numberLabel setText:numberLabelText];

    btnReset.hidden = YES;
    btnPlus.hidden = NO;
    btnMinus.hidden = NO;

}

//----------UI（ボタン関連）

#pragma mark - メモリーワーニング
//----------メモリワーニング
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//----------メモリワーニング



@end

