
#import <Cocoa/Cocoa.h>
#import "CCMImageFactory.h"
#import "CCMServerMonitor.h"


@interface CCMStatusItemMenuController : NSObject 
{
    IBOutlet CCMUserDefaultsManager *defaultsManager;
    IBOutlet CCMServerMonitor       *serverMonitor;
	IBOutlet CCMImageFactory        *imageFactory;
	IBOutlet NSMenu                 *statusMenu;
    IBOutlet NSMenuItem             *launchAtLoginItem;

	NSStatusItem	*statusItem;
    NSTimer         *timer;

}

- (NSStatusItem *)statusItem;

- (void)displayProjects:(id)sender;
- (IBAction)openProject:(id)sender;
- (IBAction)toggleLaunchAtLogin:(id)sender;
@end
