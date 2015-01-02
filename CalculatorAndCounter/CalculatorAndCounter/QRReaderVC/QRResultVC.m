//
//  QRResultVC.m
//  ToolBox
//
//  Created by Junji on 2015/01/01.
//  Copyright (c) 2015年 Junji Yamamoto. All rights reserved.
//

#import "QRResultVC.h"

@interface QRResultVC ()
{
    IBOutlet UITextView *textView;
}
@end

@implementation QRResultVC
@synthesize QRResultStr;

- (void)viewDidLoad {
    [super viewDidLoad];

    textView.text = QRResultStr;
    
    ////////////////////////////
    //ナビゲーション
    ////////////////////////////
    //ナビゲーションコントロールを表示する
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //タイトルを「QRカメラ」にする
    self.navigationItem.title = @"QRカメラ";
    
    //右側にカメラボタンを表示する
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]
                            initWithTitle:@"閉じる"
                            style:UIBarButtonItemStyleBordered
                            target:self
                            action:@selector(closeBtn:)];
    self.navigationItem.rightBarButtonItem = btn;
}

-(void)closeBtn:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////
//ボタンアクション（IBOutlet)
////////////////////////////
-(IBAction)openSafariBtn:(id)sender
{
    NSURL *url = [NSURL URLWithString:QRResultStr];
    // メールアプリを起動
//     NSURL *url = [NSURL URLWithString:@"mailto:murapong@example.com"];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
