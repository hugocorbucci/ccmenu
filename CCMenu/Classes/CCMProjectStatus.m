
#import "CCMProjectStatus.h"


static NSSet *infoKeys;


@implementation CCMProjectStatus

+ (void)initialize
{
	infoKeys = [[NSSet setWithObjects:@"activity", @"lastBuildStatus", @"lastBuildLabel", @"lastBuildTime", @"webUrl", nil] retain];
}

+ (id)statusWithDictionary:(NSDictionary *)serverInfo
{
    return [[[CCMProjectStatus alloc] initWithDictionary:serverInfo] autorelease];
}

- (id)initWithDictionary:(NSDictionary *)serverInfo
{
    self = [super init];
    info = [serverInfo copy];
    return self;
}

- (void)dealloc
{
    [info release];
    [super dealloc];
}

- (NSDictionary *)info
{
    return info;
}

- (BOOL)isBuilding
{
    return [[info valueForKey:@"activity"] isEqualToString:@"Building"];
}

- (BOOL)buildDidFail
{
    NSString *status = [info valueForKey:@"lastBuildStatus"];
    return [status isEqualToString:@"Failure"] || [status isEqualToString:@"Error"];
}

- (BOOL)buildWasSuccessful
{
    return [[info valueForKey:@"lastBuildStatus"] isEqualToString:@"Success"];
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
	if([infoKeys containsObject:NSStringFromSelector(selector)]) 
    {
        NSString *types = [NSString stringWithFormat:@"%s%s%s", @encode(id), @encode(id), @encode(SEL)];
        return [NSMethodSignature signatureWithObjCTypes:[types UTF8String]];
    }
	return [super methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
	NSString *value = [info objectForKey:NSStringFromSelector([invocation selector])];
	[invocation setReturnValue:&value];
}

- (id)valueForUndefinedKey:(NSString *)key
{
	return [info objectForKey:key]; 
}

@end
