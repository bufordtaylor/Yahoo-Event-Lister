#import <Foundation/Foundation.h>

@class Event;

@interface EventListingCell : UITableViewCell {
}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *dateLabel;

-(void) setupWithEvent:(Event*)e;
+ (NSString *)reuseIdentifier;
+ (id)cellForTableView:(UITableView *)tableView;

@end
