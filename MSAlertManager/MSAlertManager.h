//
//  MSAlertManager.h
//  
//
//  Created by mihaiserban on 15/11/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSAlertManager : NSObject

+(instancetype)sharedInstance;
-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message andCancelMessage:(NSString*)cancelMsg withTag:(int)tag andOtherButtonTitles:(NSArray*)otherButtons andCallbackDelegate:(id)callbackDelegate;

@end
