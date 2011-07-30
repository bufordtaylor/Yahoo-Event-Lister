//
//  EventsListerAppDelegate.h
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventsListerViewController;

@interface EventsListerAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EventsListerViewController *viewController;

@end
