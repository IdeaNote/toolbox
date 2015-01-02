//
//  RootTableViewController.m
//  ToolBox
//
//  Created by Junji on 2014/05/28.
//  Copyright (c) 2014年 IdeaNote. All rights reserved.
//

#import "RootTableViewController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "TimerViewController.h"

@interface RootTableViewController ()
{
    NSMutableArray *sectionList;
    NSDictionary *dataSource;
}


@end

@implementation RootTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - 読み込み(ViewDidLoad)
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //グループの設定
    sectionList = [NSMutableArray arrayWithObjects:@"計算小箱",@"カウント小箱",@"ツール小箱",@"タイム小箱",@"カメラ小箱",@"位置小箱",nil ];
    
    //各セルの設定
    NSMutableArray *calculatorTool = [NSMutableArray arrayWithObjects:@"消費税計算", nil];
    NSMutableArray *countTool = [NSMutableArray arrayWithObjects:@"カウンター", nil];
    NSMutableArray *convenienceTool = [NSMutableArray arrayWithObjects:@"懐中電灯", nil];
    NSMutableArray *timerTool = [NSMutableArray arrayWithObjects:@"ストップウォッチ",@"料理タイマー", nil];
    NSMutableArray *cameraTool = [NSMutableArray arrayWithObjects:@"簡易カメラ",@"QRカメラ",nil];
    NSMutableArray *locationTool = [NSMutableArray arrayWithObjects:@"ここの住所", nil];
    
    
    NSMutableArray *datas = [NSMutableArray arrayWithObjects: calculatorTool, countTool, convenienceTool, timerTool,cameraTool,locationTool,nil];
    
    dataSource = [NSDictionary dictionaryWithObjects:datas forKeys:sectionList];
    
}


#pragma mark - メモリワーニング
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - TableViewのセル数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *sectionName = [sectionList objectAtIndex:section];
    return [[dataSource objectForKey:sectionName ]count];
    
}


#pragma mark - TableViewのセクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [dataSource count];
}


#pragma mark - TableVIewのセクション名の設定
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionList objectAtIndex:section];
    
}

#pragma mark - 指定された箇所のセルの作成
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *cellIdentifier = @"sendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    // セルが作成されているか確認
    if (!cell) { // yes
        // セルを作成
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // セクション名を取得する
    NSString *sectionName = [sectionList objectAtIndex:indexPath.section];
    
    // セクション名をキーにしてそのセクションの項目をすべて取得
    NSArray *items = [dataSource objectForKey:sectionName];
    
    // セルにテキストを設定
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    
    //各セルに画像を配置
    if (indexPath.section == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"iconmonstr-calculator-5-icon-32.png"];//消費税ツール
        
    } else if (indexPath.section == 1){
        
        cell.imageView.image = [UIImage imageNamed:@"iconmonstr-calculator-4-icon-32.png"];//カウンター
        
    } else if (indexPath.section == 2){
        
        cell.imageView.image = [UIImage imageNamed:@"iconmonstr-light-bulb-18-icon-32.png"];//懐中電灯
        
    } else if (indexPath.section == 3){
        
        if (indexPath.row == 0) {
            
            cell.imageView.image = [UIImage imageNamed:@"iconmonstr-time-9-icon-32.png"];//ストップウォッチ
            
        } else if (indexPath.row == 1){
            
            cell.imageView.image = [UIImage imageNamed:@"iconmonstr-time-12-icon-32.png"];//キッチンタイマー
        }
        
    } else if (indexPath.section == 4){
        
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"iconmonstr-photo-camera-6-icon-32.png"];//トイカメラ
        } else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"iconmonstr-photo-camera-6-icon-32.png"];//QRコード
        }
    
    } else if (indexPath.section == 5){
        
        cell.imageView.image = [UIImage imageNamed:@"iconmonstr-location-16-icon-32.png"];//現在地表示
    }
    
    return cell;
}


#pragma mark - セルが選択時の処理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //各セクション、セルを選択した際の条件分岐
    if (indexPath.section == 0) {
    
        [self performSegueWithIdentifier:@"toFirstViewController" sender:self];//消費税ツール
    
    } else if (indexPath.section == 1){
        
        [self performSegueWithIdentifier:@"toSecondViewController" sender:self];//カウンター
    
    } else if (indexPath.section == 2){
        
        [self performSegueWithIdentifier:@"toFourthViewController" sender:self];//懐中電灯
    
    } else if (indexPath.section == 3){
        
        if (indexPath.row == 0) {
        
            [self performSegueWithIdentifier:@"toThirdViewController" sender:self];//ストップウォッチ
        
        } else if (indexPath.row == 1){
        
            [self performSegueWithIdentifier:@"toTimerViewController" sender:self];//キッチンタイマー
        }
    } else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            
            [self performSegueWithIdentifier:@"TocameraViewcontroller" sender:self];//トイカメラ
        } else if (indexPath.row == 1) {
            
            [self performSegueWithIdentifier:@"toQRReader" sender:self];//QRコード
        }
        
    } else if (indexPath.section == 5){
        
        [self performSegueWithIdentifier:@"ToNowLocationVIew" sender:self];//トイカメラ
    }
}



@end