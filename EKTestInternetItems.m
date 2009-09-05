//
//  EKTestInternetItems.m
//  EMKeychainUnitTests
//
//  Created by Nathaniel Irons on 9/1/09.
//  Copyright 2009 Bumpposoft. All rights reserved.
//

#import "EKTestInternetItems.h"
#import "EMKeychain.h"

#define kServer @"testserver.emkeychain.com"
#define kUsername @"TestUsername"
#define kPassword @"TestPassword"
#define kPath @"/foo/bar/baz/luhrmann"
#define kPort 999
#define kProtocol (SecProtocolType)kSecProtocolTypeHTTPSProxy

@implementation EKTestInternetItems

-(void)setUp {
	
	
	EMKeychainItem *kcItem = [EMInternetKeychainItem addInternetKeychainItemForServer:kServer
																		 withUsername:kUsername
																			 password:kPassword 
																				 path:kPath 
																				 port:kPort 
																			 protocol:kProtocol];
	kcItem = nil;
	kcItem = [EMInternetKeychainItem internetKeychainItemForServer:kServer 
													  withUsername:kUsername
															  path:kPath 
															  port:kPort 
														  protocol:kProtocol];
	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation in setup");
}

-(void)tearDown {
	
	// Find the keychain item we created in setUp
	EMKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:kServer 
																			withUsername:kUsername
																					path:kPath 
																					port:kPort 
																				protocol:kProtocol];
	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation in teardown");
	
	// Now delete it
	NSError *err = nil;
	BOOL result = [EMKeychainItem deleteKeychainItem: kcItem error: &err];
	
	// Make sure we think it's gone
	STAssertTrue(result, @"Error deleting test keychain item: %d, %@", [err code], [[err userInfo] objectForKey: NSLocalizedDescriptionKey]);
	
	// Make sure we can't find it anymore
	kcItem = [EMInternetKeychainItem internetKeychainItemForServer:kServer 
													  withUsername:kUsername
															  path:kPath 
															  port:kPort 
														  protocol:kProtocol];
	STAssertNil(kcItem, @"Did not expect EMKeychainItem to be recoverable after we just deleted it");
}

-(void)testPassword {
	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:kServer 
																			  withUsername:kUsername
																					  path:kPath 
																					  port:kPort 
																				  protocol:kProtocol];
	STAssertEqualObjects([kcItem password], kPassword, @"Password from keychain did not match expected");
}

-(void)testServer {
	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:kServer 
																			  withUsername:kUsername
																					  path:kPath 
																					  port:kPort 
																				  protocol:kProtocol];
	STAssertEqualObjects([kcItem server], kServer, @"Server address from keychain did not match expected");
}

-(void)testUsername {
	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:kServer 
																			  withUsername:kUsername
																					  path:kPath 
																					  port:kPort 
																				  protocol:kProtocol];
	STAssertEqualObjects([kcItem username], kUsername, @"Username from keychain did not match expected");
}

-(void)testPath {
	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:kServer 
																			  withUsername:kUsername
																					  path:kPath 
																					  port:kPort 
																				  protocol:kProtocol];
	STAssertEqualObjects([kcItem path], kPath, @"Path from keychain did not match expected");
}

-(void)testPort {
	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:kServer 
																			  withUsername:kUsername
																					  path:kPath 
																					  port:kPort 
																				  protocol:kProtocol];
	STAssertEquals([kcItem port], kPort, @"Port from keychain ('%d') did not match expected ('%d')", [kcItem port], kPort);
}

-(void)testProtocol {
	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:kServer 
																			  withUsername:kUsername
																					  path:kPath 
																					  port:kPort 
																				  protocol:kProtocol];
	STAssertEquals([kcItem protocol], kProtocol, @"Protocol from keychain ('%@') did not match expected ('%@')", NSFileTypeForHFSTypeCode([kcItem protocol]), NSFileTypeForHFSTypeCode(kProtocol));
}


-(void)testFindByServerNameAlone {
	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:kServer 
																			  withUsername:nil
																					  path:nil 
																					  port:kAnyPort
																				  protocol:kSecProtocolTypeAny];

	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation");

	STAssertEqualObjects([kcItem server], kServer, @"Server address from keychain did not match expected");
	STAssertEqualObjects([kcItem password], kPassword, @"Password from keychain did not match expected");
	STAssertEqualObjects([kcItem username], kUsername, @"Username from keychain did not match expected");
	STAssertEqualObjects([kcItem path], kPath, @"Path from keychain did not match expected");
	STAssertEquals([kcItem port], kPort, @"Port from keychain did not match expected");
	STAssertEquals([kcItem protocol], kProtocol, @"Protocol from keychain ('%@') did not match expected ('%@')", NSFileTypeForHFSTypeCode([kcItem protocol]), NSFileTypeForHFSTypeCode(kProtocol));
}

-(void)testFindByUsernameAlone {
	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:nil 
																			  withUsername:kUsername
																					  path:nil 
																					  port:kAnyPort
																				  protocol:kSecProtocolTypeAny];
	
	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation");
	
	STAssertEqualObjects([kcItem server], kServer, @"Server address from keychain did not match expected");
	STAssertEqualObjects([kcItem password], kPassword, @"Password from keychain did not match expected");
	STAssertEqualObjects([kcItem username], kUsername, @"Username from keychain did not match expected");
	STAssertEqualObjects([kcItem path], kPath, @"Path from keychain did not match expected");
	STAssertEquals([kcItem port], kPort, @"Port from keychain did not match expected");
	STAssertEquals([kcItem protocol], kProtocol, @"Protocol from keychain ('%@') did not match expected ('%@')", NSFileTypeForHFSTypeCode([kcItem protocol]), NSFileTypeForHFSTypeCode(kProtocol));
}

-(void)testFindByPathAlone {
	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:nil 
																			  withUsername:nil
																					  path:kPath 
																					  port:kAnyPort
																				  protocol:kSecProtocolTypeAny];
	
	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation");
	
	STAssertEqualObjects([kcItem server], kServer, @"Server address from keychain did not match expected");
	STAssertEqualObjects([kcItem password], kPassword, @"Password from keychain did not match expected");
	STAssertEqualObjects([kcItem username], kUsername, @"Username from keychain did not match expected");
	STAssertEqualObjects([kcItem path], kPath, @"Path from keychain did not match expected");
	STAssertEquals([kcItem port], kPort, @"Port from keychain did not match expected");
	STAssertEquals([kcItem protocol], kProtocol, @"Protocol from keychain ('%@') did not match expected ('%@')", NSFileTypeForHFSTypeCode([kcItem protocol]), NSFileTypeForHFSTypeCode(kProtocol));
}

-(void)testFindByPortAlone {
	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:nil 
																			  withUsername:nil
																					  path:nil 
																					  port:kPort
																				  protocol:kSecProtocolTypeAny];
	
	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation");
	
	STAssertEqualObjects([kcItem server], kServer, @"Server address from keychain did not match expected");
	STAssertEqualObjects([kcItem password], kPassword, @"Password from keychain did not match expected");
	STAssertEqualObjects([kcItem username], kUsername, @"Username from keychain did not match expected");
	STAssertEqualObjects([kcItem path], kPath, @"Path from keychain did not match expected");
	STAssertEquals([kcItem port], kPort, @"Port from keychain did not match expected");
	STAssertEquals([kcItem protocol], kProtocol, @"Protocol from keychain ('%@') did not match expected ('%@')", NSFileTypeForHFSTypeCode([kcItem protocol]), NSFileTypeForHFSTypeCode(kProtocol));
}

-(void)testFindByProtocolAlone {
	// This test may fail if you have a keychain item for an HTTPS proxy service.
	// This just means it's grabbing the wrong item. In reality, you probably 
	// shouldn't fetch keychain items by protocol alone.

	EMInternetKeychainItem *kcItem = [EMInternetKeychainItem internetKeychainItemForServer:nil 
																			  withUsername:nil
																					  path:nil 
																					  port:kAnyPort
																				  protocol:kProtocol];
	
	STAssertNotNil(kcItem, @"Did not expect EMKeychainItem to be nil after creation");
	
	STAssertEqualObjects([kcItem server], kServer, @"Server address from keychain did not match expected");
	STAssertEqualObjects([kcItem password], kPassword, @"Password from keychain did not match expected");
	STAssertEqualObjects([kcItem username], kUsername, @"Username from keychain did not match expected");
	STAssertEqualObjects([kcItem path], kPath, @"Path from keychain did not match expected");
	STAssertEquals([kcItem port], kPort, @"Port from keychain did not match expected");
	STAssertEquals([kcItem protocol], kProtocol, @"Protocol from keychain ('%@') did not match expected ('%@')", NSFileTypeForHFSTypeCode([kcItem protocol]), NSFileTypeForHFSTypeCode(kProtocol));
}

@end
