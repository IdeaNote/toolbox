//
//  QRReaderVC.m
//  ToolBox
//
//  Created by Junji on 2014/12/31.
//  Copyright (c) 2014年 IdeaNote. All rights reserved.
//

#import "QRReaderVC.h"

@interface QRReaderVC ()
{
    AVCaptureMetadataOutput *output;
}
@end

@implementation QRReaderVC
@synthesize session;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /////
    //ここからQRセット
    /////
    self.session = [[AVCaptureSession alloc] init];
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *device = nil;
    AVCaptureDevicePosition camera = AVCaptureDevicePositionBack; // Back or Front
    for (AVCaptureDevice *d in devices) {
        device = d;
        if (d.position == camera) {
            break;
        }
    }
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                        error:&error];
    [self.session addInput:input];
    
    output = [AVCaptureMetadataOutput new];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.session addOutput:output];
    
    // QR コードのみ
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    // 全部認識させたい場合
    // (
    // face,
    // "org.gs1.UPC-E",
    // "org.iso.Code39",
    // "org.iso.Code39Mod43",
    // "org.gs1.EAN-13",
    // "org.gs1.EAN-8",
    // "com.intermec.Code93",
    // "org.iso.Code128",
    // "org.iso.PDF417",
    // "org.iso.QRCode",
    // "org.iso.Aztec"
    // )
    output.metadataObjectTypes = output.availableMetadataObjectTypes;
    
    NSLog(@"%@", output.availableMetadataObjectTypes);
    NSLog(@"%@", output.metadataObjectTypes);
    
    [self.session startRunning];
    
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    preview.frame = self.view.bounds;
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:preview];
}

////////////////////////////
//ここから出力したものを取得
////////////////////////////
#pragma mark -データを取得
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"----");
    for (AVMetadataObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            // 複数の QR があっても1度で読み取れている
            NSString *qrcode = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
            NSLog(@"%@", qrcode);
            [self performSegueWithIdentifier:@"toQRReader" sender:self];//確認画面遷移
        }
    }
    //ここでキューを「nil」に変更
    [output setMetadataObjectsDelegate:nil queue:dispatch_get_main_queue()];
}

////////////////////////////
//ここからメモリアラート
////////////////////////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
