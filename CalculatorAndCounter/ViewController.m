//
//  ViewController.m
//  camera
//
//  Created by Junji on 2014/05/16.
//  Copyright (c) 2014年 IdeaNote. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    IBOutlet UIImageView *aImageView;
}

@end

@implementation ViewController



#pragma mark - 読み込み
//*****読み込み
- (void)viewDidLoad
{
    [super viewDidLoad];

//    *****ツールバー配置
/*
    toolBar = [ [ UIToolbar alloc ] initWithFrame:CGRectMake( 0, self.view.bounds.size.height - 44, 320, 44 ) ];
    
    UIBarButtonItem *btnCamera = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(openCamera:)];
    
    UIBarButtonItem *space1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *btnfilter = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(doFilter:)];

 
    UIBarButtonItem *space2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *btnsave = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(openPhotoLibruary:)];
     
    toolBar.items = [NSArray arrayWithObjects:btnCamera,space1,btnfilter, nil];
    
    [self.view addSubview:toolBar];
*/

//    *****ツールバー配置
    
}
//*****読み込み

#pragma mark - メモリーワーニング
//*****メモリーワーニング
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
//*****メモリーワーニング


#pragma mark - ボタン設定

//******ボタン関連：開始
#pragma mark - カメラボタン処理
-(IBAction)doCamera:(id)sender {
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController
          isSourceTypeAvailable:sourceType]) {
        return;
    }
    // カメラを起動する
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    [ipc setSourceType:sourceType];
    [ipc setDelegate:self];
    [ipc setAllowsEditing:YES];
    [self presentViewController:ipc animated:YES completion:^{
        [UIApplication sharedApplication].statusBarHidden = YES;
    }];
}

#pragma mark - 保存ボタン処理
-(IBAction)doSave:(id)sender {

    UIImage *aImage = [aImageView image];
    if ( aImage == nil ) {
        return;
    }
    UIImageWriteToSavedPhotosAlbum(aImage,self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
}

#pragma mark - 保存用アラート
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    
    if (error) {

    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存終了" message:@"写真アルバムに画像を保存しました。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - フィルタボタン処理


//撮影画面表示時に呼ばれるUINavigationControllerDelegateメソッド
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"撮影画面表示直前");
}

//撮影画面表示時に呼ばれるUINavigationControllerDelegateメソッド
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"撮影画面表示直後");
}




#pragma mark - アクションシート
-(IBAction)doFilter:(id)sender
{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"フィルター選択" delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:nil otherButtonTitles:@"モノクロフィルタ", @"セピアフィルタ", @"色反転フィルタ",@"色調節フィルタ",@"偽色フィルタ",@"トーンカーブフィルタ",@"色相調整フィルタ",nil];
    
    [sheet setActionSheetStyle:UIActionSheetStyleDefault];
    [sheet showInView:[self view]];
    
}

#pragma mark - アクションシートボタン
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [self toMono];
        
    } else if (buttonIndex == 1){
        
        [self toSepia];
        
    } else if (buttonIndex == 2) {
        
        [self toConvertColor];
        
    } else if (buttonIndex == 3) {
        
        [self toColorAdjust];
        
    } else if (buttonIndex == 4) {
        
        [self toFalseColor];
        
    } else if (buttonIndex == 5) {
        
        [self toTone];
        
    } else if (buttonIndex == 6) {
        
        [self toHueAdjust];
    }
    
}
//*****アクションシート（内容）


#pragma mark - 撮影完了時処理
//撮影完了時によばれるUIImagePickerControllerDelegateメソッド
- (void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *aImage = [info objectForKey:UIImagePickerControllerEditedImage];
    

    [aImageView setImage:aImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        [UIApplication sharedApplication].statusBarHidden = NO;
    }];
}

#pragma mark - 撮影キャンセル処理
//撮影キャンセル時によばれるUIImagePickerControllerDelegateメソッド
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:^{
        [UIApplication sharedApplication].statusBarHidden = NO;
    }];
}

//******ボタン関連：終了


#pragma mark - フィルタ処理
#pragma mark - モノクロ
-(void)toMono
{
    UIImage *imagePicture = [aImageView image];
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:imagePicture];
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIColorMonochrome"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          
                          @"inputColor",[CIColor colorWithRed:0.75 green:0.75 blue:0.75],
                          
                          @"inputIntensity",[NSNumber numberWithFloat:1.0],
                          
                          nil];
    
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [ciContext createCGImage:ciFilter.outputImage fromRect:[ciFilter.outputImage extent]];
    
    UIImage *retImage = [UIImage imageWithCGImage:cgImage scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(cgImage);
    
    [aImageView setImage:retImage];
    
}
//      *****フィルタの設定（モノクロ）

#pragma mark- セピア
-(void)toSepia
{
    
    UIImage *imagePicture = [aImageView image];
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:imagePicture];
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CISepiaTone"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          
                          @"inputIntensity",[NSNumber numberWithFloat:0.8],
                          
                          nil];
    
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [ciContext createCGImage:ciFilter.outputImage fromRect:[ciFilter.outputImage extent]];
    
    UIImage *retImage = [UIImage imageWithCGImage:cgImage scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(cgImage);
    
    [aImageView setImage:retImage];
    
}

//      *****フィルタの設定（セピア）

#pragma mark - 色の反転
-(void)toConvertColor
{
    UIImage *imagePicture = [aImageView image];
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:imagePicture];
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIColorInvert"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          
                          nil];
    
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [ciContext createCGImage:ciFilter.outputImage fromRect:[ciFilter.outputImage extent]];
    
    UIImage *retImage = [UIImage imageWithCGImage:cgImage scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(cgImage);
    
    [aImageView setImage:retImage];
    
}
//      *****フィルタの設定（色の反転）

#pragma mark- 色調整
-(void)toColorAdjust
{
    UIImage *imagePicture = [aImageView image];
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:imagePicture];
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIColorControls"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputSaturation",[NSNumber numberWithFloat:1.0],
                          @"inputBrightness",[NSNumber numberWithFloat:0.5],
                          @"inputContrast",[NSNumber numberWithFloat:3.0],
                          nil];
    
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [ciContext createCGImage:ciFilter.outputImage fromRect:[ciFilter.outputImage extent]];
    
    UIImage *retImage = [UIImage imageWithCGImage:cgImage scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(cgImage);
    
    [aImageView setImage:retImage];
    
}
//      *****フィルタの設定（色調整）

#pragma mark- 偽色
-(void)toFalseColor
{
    UIImage *imagePicture = [aImageView image];
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:imagePicture];
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIFalseColor"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputColor0",[CIColor colorWithRed:0.44 green:0.5 blue:0.2 alpha:1],
                          @"inputColor1",[CIColor colorWithRed:1 green:0.92 blue:0.50 alpha:1],
                          nil];
    
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [ciContext createCGImage:ciFilter.outputImage fromRect:[ciFilter.outputImage extent]];
    
    UIImage *retImage = [UIImage imageWithCGImage:cgImage scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(cgImage);
    
    [aImageView setImage:retImage];
    
    
}


//      *****フィルタの設定（偽色）

#pragma mark - トーン
-(void)toTone
{
    UIImage *imagePicture = [aImageView image];
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:imagePicture];
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIToneCurve"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputPoint0", [CIVector vectorWithX:0.0 Y:0.0],
                          @"inputPoint1", [CIVector vectorWithX:0.25 Y:0.1],
                          @"inputPoint2", [CIVector vectorWithX:0.5 Y:0.5],
                          @"inputPoint3", [CIVector vectorWithX:0.75 Y:0.9],
                          @"inputPoint4", [CIVector vectorWithX:1 Y:1],
                          nil];
    
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [ciContext createCGImage:ciFilter.outputImage fromRect:[ciFilter.outputImage extent]];
    
    UIImage *retImage = [UIImage imageWithCGImage:cgImage scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(cgImage);
    
    [aImageView setImage:retImage];

}

//      *****フィルタの設定（トーン）

#pragma mark - 色相
-(void)toHueAdjust
{
    UIImage *imagePicture = [aImageView image];
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:imagePicture];
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIHueAdjust"
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputAngle",[NSNumber numberWithFloat:3.14],
                          nil];
    
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [ciContext createCGImage:ciFilter.outputImage fromRect:[ciFilter.outputImage extent]];
    
    UIImage *retImage = [UIImage imageWithCGImage:cgImage scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(cgImage);
    
    [aImageView setImage:retImage];
    
}
//      *****フィルタの設定（色相）


#pragma mark - ツールバー表示メソッド
/*
//      *****ツールバー表示メソッド
-(void)showToolbar
{
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake( 0, self.view.bounds.size.height - 44, 320, 44 ) ];
    
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle:@"キャンセル" style:UIBarButtonItemStyleBordered target:self action:@selector(noShowToolbar)];
    
    UIBarButtonItem *space1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *btnSaveP = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(doSave:)];
    
    
    toolBar.items = [NSArray arrayWithObjects:btnCancel,space1,btnSaveP, nil];
    
    [self.view addSubview:toolBar];
}
//      *****ツールバー表示メソッド

-(void)noShowToolbar
{
    toolBar.hidden = YES;
    
}
*/

//*****メソッド：終了
@end
