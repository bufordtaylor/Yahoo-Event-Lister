//
//  EventsListerAppDelegate.m
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventsListerAppDelegate.h"
#import "CustomMBProgressHUD.h"
#import "EventsListerViewController.h"

@implementation EventsListerAppDelegate

@synthesize window;
@synthesize viewController;

#define kHUDHideDelay 0.5;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CustomMBProgressHUD *hud = (CustomMBProgressHUD*)[[MBProgressHUD alloc] initWithWindow:window];
    hud.minShowTime = kHUDHideDelay;
    hud.animationType = MBProgressHUDAnimationZoom;
    
    if(
	   getenv("NSZombieEnabled") || getenv("NSAutoreleaseFreedObjectCheckEnabled")
	   ) {
		DLog(@"NSZombieEnabled/NSAutoreleaseFreedObjectCheckEnabled enabled!");
	}
    
    [CustomMBProgressHUD setDefaultHUD:hud];
    
    viewController = [[EventsListerViewController alloc] initWithStyle:UITableViewStylePlain]; 
    // Reveal main application
    viewController.view.backgroundColor = [UIColor clearColor];
    
    nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [window insertSubview:nav.view belowSubview:[CustomMBProgressHUD defaultHUD]];    
    
    [window addSubview:[CustomMBProgressHUD defaultHUD]];    
    
    // Override point for customization after application launch.
//    self.viewController = [[EventsListerViewController alloc] initWithNibName:@"EventsListerViewController" bundle:nil]; 
    DLog(@"appdidfinishlaunching");
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
