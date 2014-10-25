//
//  CCMLaunchAtLoginController.h
//  CCMenu
//
//  Created by HCorbucc on 10/25/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#ifndef CCMenu_CCMLaunchAtLoginController_h
#define CCMenu_CCMLaunchAtLoginController_h

#import <Foundation/Foundation.h>
#import "CCMUserDefaultsManager.h"

@interface CCMLaunchAtLoginController : NSObject {
    CCMUserDefaultsManager *defaultsManager;
}
- (id) initWithDefaultsManager: (CCMUserDefaultsManager*) manager;
@end
#endif
