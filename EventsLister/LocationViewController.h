//
//  LocationViewController.h
//  EventsLister
//
//  Created by Buford Taylor on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LocationViewControllerDelegate
-(void) startLocationSearch:(NSString*) location;
@end

@interface LocationViewController : UIViewController {
    IBOutlet UIButton* goButton;
    IBOutlet UITextField* zipLabel;
    id<LocationViewControllerDelegate> delegate;  //This should be a weak ivar reference for ARC
}


@property (nonatomic, retain) id<LocationViewControllerDelegate> delegate;
-(IBAction) didPressGoButton:(id)sender;

@end
