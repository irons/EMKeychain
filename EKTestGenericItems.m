//
//  EKTestGenericItems.m
//  EMKeychainUnitTests
//
//  Created by Nathaniel Irons on 9/1/09.
//  Copyright 2009 Bumpposoft. All rights reserved.
//

#import "EKTestGenericItems.h"
#import "EMKeychain.h"
#import <Security/Security.h>

#define kServiceName @"EMKeychainUnitKitTest"
#define kUsername @"TestUsername"
#define kPassword @"TestPassword"

@implementation EKTestGenericItems

-(void)setUp {

	EMKeychainItem *kcItem = [EMGenericKeychainItem addGenericKeychainItemForService: kServiceName 
																		withUsername: kUsername 
																			password: kPassword];
	kcItem = nil;
	kcItem = [EMGenericKeychainItem genericKeychainItemForService: kServiceName withUsername: kUsername];
	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation in setup");

}

-(void)tearDown {

	// Find the keychain item we created in setUp
	EMKeychainItem *kcItem = [EMGenericKeychainItem genericKeychainItemForService: kServiceName withUsername: kUsername];
	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation in teardown");

	// Now delete it
	NSError *err = nil;
	BOOL result = [EMKeychainItem deleteKeychainItem: kcItem error: &err];

	// Make sure we think it's gone
	STAssertTrue(result, @"Error deleting test keychain item: %d, %@", [err code], [[err userInfo] objectForKey: NSLocalizedDescriptionKey]);

	// Make sure we can't find it anymore
	kcItem = [EMGenericKeychainItem genericKeychainItemForService: kServiceName withUsername: kUsername];
	STAssertNil(kcItem, @"Did not expect EMKeychainItem to be recoverable after we just deleted it");
}

-(void)testPassword {
	EMKeychainItem *kcItem = [EMGenericKeychainItem genericKeychainItemForService: kServiceName withUsername: nil];
	STAssertEqualObjects([kcItem password], kPassword, @"Password from keychain did not match expected password");
}

-(void)testUsername {
	EMKeychainItem *kcItem = [EMGenericKeychainItem genericKeychainItemForService: kServiceName withUsername: nil];
	STAssertEqualObjects([kcItem username], kUsername, @"Username from keychain did not match expected username");
}

-(void)testServiceName {
	EMGenericKeychainItem *kcItem = [EMGenericKeychainItem genericKeychainItemForService: kServiceName withUsername: nil];
	STAssertEqualObjects([kcItem serviceName], kServiceName, @"Service name from keychain did not match expected service name");
}

-(void)testFindByServiceNameAlone {

	EMGenericKeychainItem *kcItem = [EMGenericKeychainItem genericKeychainItemForService: kServiceName withUsername: nil];
	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation in setup");

	STAssertEqualObjects([kcItem serviceName], kServiceName, @"Service name from keychain did not match expected service name");
	STAssertEqualObjects([kcItem password], kPassword, @"Password from keychain did not match expected password");
	STAssertEqualObjects([kcItem username], kUsername, @"Username from keychain did not match expected username");
}

-(void)testFindByUsernameAlone {
	
	EMGenericKeychainItem *kcItem = [EMGenericKeychainItem genericKeychainItemForService: nil withUsername: kUsername];
	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation in setup");
	
	STAssertEqualObjects([kcItem serviceName], kServiceName, @"Service name from keychain did not match expected service name");
	STAssertEqualObjects([kcItem password], kPassword, @"Password from keychain did not match expected password");
	STAssertEqualObjects([kcItem username], kUsername, @"Username from keychain did not match expected username");
}


@end
