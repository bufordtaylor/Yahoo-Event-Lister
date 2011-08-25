#import "EventListingCell.h"
#import "Event.h"
#import "GenLib.h"

@implementation EventListingCell

@synthesize titleLabel;
@synthesize dateLabel;
static UIFont *titleFont = nil;
static UIFont *detailFont = nil;

+ (id)cellForTableView:(UITableView *)tableView {
    NSString *reuseID = [[self class] reuseIdentifier];
    EventListingCell *cell = (EventListingCell *)[tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!titleFont) {
        titleFont = [[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0] retain];
        detailFont = [[UIFont fontWithName:@"HelveticaNeue" size:14.0] retain];        
    }
    
    if (!cell) {
        cell = [[[EventListingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID] autorelease];

        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AttendeeCellBkgnd.png"]] autorelease];
        
        cell.titleLabel = [[[UILabel alloc] init] autorelease];
        cell.dateLabel = [[[UILabel alloc] init] autorelease];
        
        cell.titleLabel.font = titleFont;
        cell.titleLabel.lineBreakMode = UILineBreakModeMiddleTruncation;
        cell.titleLabel.numberOfLines = 2;
        cell.titleLabel.backgroundColor = [UIColor clearColor];
        cell.titleLabel.highlightedTextColor = [UIColor whiteColor];
        
        cell.dateLabel.font = detailFont;
        cell.dateLabel.textColor = [UIColor colorWithWhite:.486 alpha:1.0];
        cell.dateLabel.backgroundColor = [UIColor clearColor];
        cell.dateLabel.highlightedTextColor = [UIColor whiteColor];
        
        cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EventDetailArrow.png"]] autorelease];
        [cell.contentView addSubview:cell.titleLabel];
        [cell.contentView addSubview:cell.dateLabel];        
    }
    
    return cell;
}

-(void) dealloc {
    [titleLabel release];
    [dateLabel release];
	[super dealloc];
}

-(void) setupWithEvent:(Event*)e {	
	// constrain the UILabel to its minimum height so that we can position it aligned to the top of 2 lines instead of being centered
    static int titlePadding = 3;
    
	self.titleLabel.text = e.title;
	CGSize maximumSize = CGSizeMake(250, 39);
	UIFont *font = self.titleLabel.font;
	CGSize stringSize = [e.title sizeWithFont:font constrainedToSize:maximumSize lineBreakMode:UILineBreakModeMiddleTruncation];
	self.titleLabel.frame = CGRectMake(15, 
                                       8,
                                       stringSize.width,
                                       stringSize.height - titlePadding);
    

    self.dateLabel.text = [GenLib dateAndTimeString:e.startDate];


    CGSize detailStringSize = [self.dateLabel.text sizeWithFont:self.dateLabel.font constrainedToSize:maximumSize];
    self.dateLabel.frame = CGRectMake(15, 
                                      49, 
                                      self.frame.size.width,
                                      detailStringSize.height);

	self.accessibilityLabel = e.title;
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (NSString *)reuseIdentifier {
    return [[self class] reuseIdentifier];
}
@end
