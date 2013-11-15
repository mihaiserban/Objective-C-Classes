//
//  MSAlertManager.m
//  
//
//  Created by mihaiserban on 15/11/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "MSAlertManager.h"
#import "MSAlertView.h"

@interface MSAlertManager ()
@property (nonatomic, strong) NSMutableArray *visibleAlerts;
@end

@implementation MSAlertManager

+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init
{
    if (self == [super init]) {
        //setup
        _visibleAlerts = [NSMutableArray array];
    }
    return self;
}

-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message andCancelMessage:(NSString*)cancelMsg withTag:(int)tag andOtherButtonTitles:(NSArray*)otherButtons andCallbackDelegate:(id)callbackDelegate
{
    //check if we have a alert with this tag added
    for (UIAlertView *alert in self.visibleAlerts) {
        if (alert.tag == tag) {
            return;
        }
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        MSAlertView* alert = [[MSAlertView alloc] initWithTitle:title
                                                        message:message delegate:self
                                              cancelButtonTitle:cancelMsg
                                              otherButtonTitles: nil];
        for( NSString *title in otherButtons)  {
            [alert addButtonWithTitle:title];
        }
        [alert setCallbackDelegate:callbackDelegate];
        [alert setTag:tag];
        
        [self.visibleAlerts addObject:alert];
        
        [alert show];
    });
}

- (void)alertView:(MSAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.visibleAlerts removeObject:alertView];
    
    //forward to delegate
    if ([alertView.callbackDelegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [alertView.callbackDelegate alertView:alertView willDismissWithButtonIndex:buttonIndex];
    }
}

- (void)alertView:(MSAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //forward to delegate
    if ([alertView.callbackDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [alertView.callbackDelegate alertView:alertView clickedButtonAtIndex:buttonIndex];
    }
}

@end
