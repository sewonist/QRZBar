//
//  CallZBar.h
//  QRZBar
//
//  Created by JAN HEUFF on 15/02/2012.
//  Copyright (c) 2012 RANCON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "ZBarReaderController.h"

@interface CallZBar : NSObject < ZBarReaderDelegate >

-(void) scan:(FREContext *)ctx;
-(void) cancelScan:(FREContext *)ctx;

@end
