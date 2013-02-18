//
//  CallZBar.m
//  QRZBar
//
//  Created by JAN HEUFF on 15/02/2012.
//  Copyright (c) 2012 RANCON. All rights reserved.
//

#import "CallZBar.h"

@implementation CallZBar

FREContext *context;

- (void) scan:(FREContext *)ctx
{
    context = ctx;
    NSLog(@"Build 0.0.0.9");
    NSLog(@"JAMES RANCON Scan");
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    //[self presentModalViewController: reader animated: YES];
    
    //id delegate = [[UIApplication sharedApplication] delegate];
    //[[[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController] view] addSubview:[self view]];
    
    id delegate = [[UIApplication sharedApplication] delegate];
    [[[delegate window] rootViewController] presentModalViewController:reader animated:YES];
    [reader release];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    NSLog(@"JAMES RANCON Callback function");
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    //resultText.text = symbol.data;
    
    NSLog([symbol data]);
    
    NSString *event_name = @"SCANNED";
    FREDispatchStatusEventAsync(context, (uint8_t*)[event_name UTF8String], (uint8_t*)[[symbol data] UTF8String]);
     
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
    context = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagePickerControllerDidCancel");
    
    NSString *event_name = @"CANCLED";
    NSString *level = @"";
    
    FREDispatchStatusEventAsync(context, (uint8_t*)[event_name UTF8String], (uint8_t*)[level UTF8String]);
    
    [picker dismissModalViewControllerAnimated: YES];
    context = nil;
}


- (void) cancelScan:(FREContext *)ctx
{
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    //[reader dismissModalViewControllerAnimated: YES];
    NSLog(@"JAMES RANCON Cancel Scan");
    //[[self view] removeFromSuperview];
    context = nil;
}

@end
