//
//  CustomMBProgressHUD.h
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MBProgressHUD.h"


@interface CustomMBProgressHUD : MBProgressHUD {
    
}

/**
 * Set a default / global HUD
 */
+ (void)setDefaultHUD:(MBProgressHUD *)hud;
+ (MBProgressHUD *)defaultHUD;
+ (void)showWithMessage:(NSString *)message detailMessage:(NSString *)detailMessage;
+ (void)showWithMessage:(NSString *)message detailMessage:(NSString *)detailMessage mode:(MBProgressHUDMode)mode;
+ (void)hide;
+ (BOOL)isShowing;
+ (void)setProgress:(CGFloat)progress;

@end
