
#import "CCMImageFactoryTest.h"
#import "CCMProject.h"


@implementation CCMImageFactoryTest

- (void)setUp
{
	factory = [[[CCMImageFactory alloc] init] autorelease];
}

- (void)testLastBuildSuccessfulSleepingImage
{
    NSDictionary *d = @{ @"activity": @"Sleeping", @"lastBuildStatus": @"Success" };
    NSImage *image = [factory imageForStatus:[CCMProjectStatus statusWithDictionary:d]];
    STAssertEqualObjects(@"icon-success", [image name], @"Should have loaded correct image.");
}

- (void)testLastBuildFailedSleepingImage
{
    NSDictionary *d = @{ @"activity": @"Sleeping", @"lastBuildStatus": @"Failure" };
    NSImage *image = [factory imageForStatus:[CCMProjectStatus statusWithDictionary:d]];
	STAssertEqualObjects(@"icon-failure", [image name], @"Should have loaded correct image.");
}

- (void)testLastBuildSuccessfulBuildingImage
{
    NSDictionary *d = @{ @"activity": @"Building", @"lastBuildStatus": @"Success" };
    NSImage *image = [factory imageForStatus:[CCMProjectStatus statusWithDictionary:d]];
    STAssertEqualObjects(@"icon-success-building", [image name], @"Should have loaded correct image.");
}

- (void)testLastBuildFailedBuildingImage
{
    NSDictionary *d = @{ @"activity": @"Building", @"lastBuildStatus": @"Failure" };
    NSImage *image = [factory imageForStatus:[CCMProjectStatus statusWithDictionary:d]];
	STAssertEqualObjects(@"icon-failure-building", [image name], @"Should have loaded correct image.");
}

- (void)testLastBuildNeitherSuccessfulNorFailedBuildingImage
{
    NSDictionary *d = @{ @"activity": @"Building", @"lastBuildStatus": @"Unknown" };
    NSImage *image = [factory imageForStatus:[CCMProjectStatus statusWithDictionary:d]];
    STAssertEqualObjects(@"icon-success-building", [image name], @"Should have loaded correct image.");
}

- (void)testLastBuildSuccessfulOtherActivityImage
{
    NSDictionary *d = @{ @"activity": @"some random activity", @"lastBuildStatus": @"Success" };
    NSImage *image = [factory imageForStatus:[CCMProjectStatus statusWithDictionary:d]];
    STAssertEqualObjects(@"icon-success", [image name], @"Should have loaded correct image.");
}

- (void)testLastBuildStatusIsUnknownImage
{
    // Jenkins uses "unknown" for builds that are inactive
    NSDictionary *d = @{ @"lastBuildStatus": @"Unknown" };
    NSImage *image = [factory imageForStatus:[CCMProjectStatus statusWithDictionary:d]];
    STAssertEqualObjects(@"icon-pause", [image name], @"Should have loaded correct image.");
}

- (void)testNoBuildStatusImage
{
    NSDictionary *d = @{ @"activity": @"some random activity"};
    NSImage *image = [factory imageForStatus:[CCMProjectStatus statusWithDictionary:d]];
	STAssertEqualObjects(@"icon-inactive", [image name], @"Should have loaded correct image.");
}

- (void)testUnexpectedBuildStatusImage
{
    NSDictionary *d = @{ @"lastBuildStatus": @"Exception" };
    NSImage *image = [factory imageForStatus:[CCMProjectStatus statusWithDictionary:d]];
	// note: different to old behaviour
    STAssertEqualObjects(@"icon-inactive", [image name], @"Should have loaded correct image.");
}


- (void)testCachesMenuImages
{
	NSImage *original = [[NSImage alloc] init];
	STAssertTrue([original setName:@"testCachesMenuImages"], @"Should have been able to set image name.");
	NSImage *menu1 = [factory convertForMenuUse:original];
	STAssertTrue(![[menu1 name] isEqualToString:[original name]], @"Should have used different name.");
	NSImage *menu2 = [factory convertForMenuUse:original];
	STAssertTrue(menu1 == menu2, @"Should have reused same image object.");
}

@end
