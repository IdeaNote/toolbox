//
//  TopViewController.m
//  ToolBox
//
//  Created by Junji on 2014/05/30.
//  Copyright (c) 2014年 Junji Yamamoto. All rights reserved.
//

#import "TopViewController.h"

@interface TopViewController ()
{
    NSMutableArray *dataSource;
    
}

@end

@implementation TopViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataSource = [[NSMutableArray alloc] initWithObjects:@"計算ツール",@"カウントツール",@"便利ツール",@"タイマーツール",@"カメラツール", nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // セルにテキストを設定
    cell.textLabel.text = [dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"「%@」が選択されました", [dataSource objectAtIndex:indexPath.row]);
}


@end
