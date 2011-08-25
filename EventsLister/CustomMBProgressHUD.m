//
//  CustomMBProgressHUD.m
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomMBProgressHUD.h"


@implementation CustomMBProgressHUD

static MBProgressHUD *defaultHUD;
static BOOL isShowing;

+ (void)hide {
    [[self defaultHUD] hide:YES];   
    isShowing = NO;
}

+ (void)showWithMessage:(NSString *)message detailMessage:(NSString *)detailMessage mode:(MBProgressHUDMode)mode {
    
    if (![message isEqualToString:defaultHUD.labelText] || mode != defaultHUD.mode || !isShowing) {
        [[self defaultHUD] setLabelText:message];
        if (detailMessage)
            [[self defaultHUD] setDetailsLabelText:detailMessage];
        else
            [[self defaultHUD] setDetailsLabelText:@""];
        
        [[self defaultHUD] show:YES];
        [[self defaultHUD] setMode:mode];    
        isShowing = YES;    
    }
}

+ (void)showWithMessage:(NSString *)message detailMessage:(NSString *)detailMessage {
    [self showWithMessage:message detailMessage:detailMessage mode:MBProgressHUDModeIndeterminate];
}

+ (void)setProgress:(CGFloat)progress {
    [[self defaultHUD] setProgress:progress];
}

+ (void)setDefaultHUD:(MBProgressHUD *)hud {
    @synchronized(self) {
        if (hud != defaultHUD) {            
            [defaultHUD release];
            defaultHUD  = [hud retain];    
        }
    }
}

+ (MBProgressHUD *)defaultHUD {
    @synchronized(self) {
        if (defaultHUD) {
            return defaultHUD;
        }
    }
    return nil;
}

+ (BOOL)isShowing {
    return isShowing;
}

@end
