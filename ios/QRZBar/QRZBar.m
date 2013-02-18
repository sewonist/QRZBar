//
//  QRZBar.m
//  QRZBar
//
//  Created by JAN HEUFF on 15/02/2012.
//  Copyright (c) 2012 RANCON. All rights reserved.
//
#include "FlashRuntimeExtensions.h"
#import "CallZBar.h"

FREObject scan(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
    CallZBar *zBar = [[CallZBar alloc] init];
    [zBar scan:ctx];
    return NULL;
}


//------------------------------------
//
// Required Methods.
//
//------------------------------------

// ContextInitializer()
//
// The context initializer is called when the runtime creates the extension context instance.
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, 
						uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) 
{
    
	*numFunctionsToTest = 1;
    
	FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * 1);
	func[0].name = (const uint8_t*) "scan";
	func[0].functionData = NULL;
    func[0].function = &scan;
    
	*functionsToSet = func;
}


void ContextFinalizer(FREContext ctx) {
    
    NSLog(@"Entering ContextFinalizer()");
    
    // Nothing to clean up.
    
    NSLog(@"Exiting ContextFinalizer()");
    
	return;
}

void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, 
                    FREContextFinalizer* ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtInitializer()");
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;
    
    NSLog(@"Exiting ExtInitializer()");
}

void ExtFinalizer(void* extData) {
    
    NSLog(@"Entering ExtFinalizer()");
    
    // Nothing to clean up.
    
    NSLog(@"Exiting ExtFinalizer()");
    return;
}