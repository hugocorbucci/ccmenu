//
//  CCMLaunchAtLoginController.m
//  CCMenu
//
//  Created by HCorbucc on 10/25/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "CCMLaunchAtLoginController.h"
#import "CCMUserDefaultsManager.h"

@implementation CCMLaunchAtLoginController

static int const PrivateKVOContext;
- (id)initWithDefaultsManager:(CCMUserDefaultsManager *)manager
{
    defaultsManager = manager;
    [defaultsManager addObserver:self forKeyPath:CCMDefaultsLaunchAtLoginKey options:(NSKeyValueObservingOptionInitial+NSKeyValueObservingOptionNew) context: ((void*)&PrivateKVOContext)];
    return [super init];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == &PrivateKVOContext) {
        if (keyPath == CCMDefaultsLaunchAtLoginKey) {
            if (defaultsManager.launchAtLogin) {
                [self addAppAsLoginItem];
            } else {
                [self deleteAppFromLoginItem];
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void) addAppAsLoginItem {
    NSString * appPath = [[NSBundle mainBundle] bundlePath];
    CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath: appPath];
    
    LSSharedFileListRef loginItems =
    LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItems) {
        LSSharedFileListItemRef item =
        LSSharedFileListInsertItemURL(loginItems, kLSSharedFileListItemLast,
                                      NULL, NULL, url, NULL, NULL);
        if (item) {
            CFRelease(item);
        }
    }
    
    CFRelease(loginItems);
}

- (void) deleteAppFromLoginItem {
    NSString * appPath = [[NSBundle mainBundle] bundlePath];
    CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath: appPath];
    
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
                                                            kLSSharedFileListSessionLoginItems, NULL);
    if (loginItems) {
        UInt32 seedValue;
        NSArray  *loginItemsArray =
        (__bridge NSArray *) LSSharedFileListCopySnapshot(loginItems, &seedValue);
        for(int i = 0; i< [loginItemsArray count]; i++){
            LSSharedFileListItemRef itemRef =
            (__bridge LSSharedFileListItemRef)[loginItemsArray objectAtIndex: i];
            if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &url, NULL) == noErr) {
                NSString * urlPath = [(__bridge NSURL*) url path];
                if ([urlPath compare: appPath] == NSOrderedSame){
                    LSSharedFileListItemRemove(loginItems,itemRef);
                }
            }
        }
    }
}

@end