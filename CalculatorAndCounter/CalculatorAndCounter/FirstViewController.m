//
//  FirstViewController.m
//  CalculatorAndCounter
//
//  Created by Junji on 2014/04/11.
//  Copyright (c) 2014年 IdeaNote. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController (){
    
    IBOutlet UILabel *taxedNumber;
    
    int outputNumber;
    int inputNumber;
    NSString *numberLabelText;
    
}

@end



@implementation FirstViewController


//--- viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];

#pragma mark - 3桁ずつのカンマ表示
    NSNumber *priceNumber = [[NSNumber alloc] initWithInteger:outputNumber];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    
    NSString *result = [formatter stringFromNumber:priceNumber];
    
    numberLabelText = [NSString stringWithFormat:@"%@",result];
    
    [taxedNumber setText:numberLabelText];


#pragma mark - テキストフィールドの設定
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
   
    //４インチの場合
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        
        UITextField *textfield = [[UITextField alloc] init];
        textfield.frame = CGRectMake(50, 280, 220, 40);
        
        textfield.delegate = self;
        textfield.font = [UIFont systemFontOfSize:36];
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        textfield.clearsOnBeginEditing = YES;
        textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
        [self.view addSubview:textfield];
    
    //3.5インチの場合
    }else {
    
        UITextField *textfield = [[UITextField alloc] init];
        textfield.frame = CGRectMake(50, 217, 220, 40);

        textfield.delegate = self;
        textfield.font = [UIFont systemFontOfSize:36];
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        textfield.clearsOnBeginEditing = YES;
        textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
        [self.view addSubview:textfield];
    }
}

#pragma mark - 数値の変換
-(void)change {
    
    outputNumber = inputNumber * 1.08;
    
    [taxedNumber setText:[NSString stringWithFormat:@"%d",outputNumber]];
    

    NSNumber *priceNumber = [[NSNumber alloc] initWithInteger:outputNumber];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    
    NSString *result = [formatter stringFromNumber:priceNumber];
    
    numberLabelText = [NSString stringWithFormat:@"%@",result];
    
    [taxedNumber setText:numberLabelText];
}

#pragma mark - デキストフィールド入力
-(BOOL)textFieldShouldReturn:(UITextField *)textfield {
    
    inputNumber = [textfield.text intValue];
    
    [textfield resignFirstResponder];
    
    [self change];
    
    return YES;
    
}

#pragma mark - メモリーワーニング

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end