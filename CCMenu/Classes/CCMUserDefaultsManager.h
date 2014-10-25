
#import <Cocoa/Cocoa.h>

enum {
    CCMProjectOrderNatural = 0,
    CCMProjectOrderAlphabetic = 1,
    CCMProjectOrderByBuildTime = 2
};


@interface CCMUserDefaultsManager : NSObject 
{
	NSUserDefaults	*userDefaults;
}
@property BOOL launchAtLogin;

- (NSInteger)pollInterval;
- (BOOL)shouldShowTimerInMenu;
- (BOOL)shouldShowLastBuildTimes;
- (NSUInteger)projectOrder;

- (void)addProject:(NSString *)projectName onServerWithURL:(NSString *)serverUrl;
- (BOOL)projectListContainsProject:(NSString *)projectName onServerWithURL:(NSString *)serverUrl;
- (NSArray *)projectList;

- (void)addServerURLToHistory:(NSString *)serverUrl;
- (NSArray *)serverURLHistory;

- (void)convertDefaultsIfNecessary;

- (void)shouldLaunchAtLogin:(BOOL)shouldBeLaunched;

@end


extern NSString *CCMDefaultsPollIntervalKey;

extern NSString *CCMDefaultsProjectListKey;
extern NSString *CCMDefaultsProjectEntryNameKey;
extern NSString *CCMDefaultsProjectEntryServerUrlKey;

extern NSString *CCMDefaultsServerUrlHistoryKey;
extern NSString *CCMDefaultsLaunchAtLoginKey;