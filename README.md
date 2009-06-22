EMKeychain: A Cocoa Keychain Wrapper
====================================

by Brian Amerige of Extendmac, LLC., 12/15/2007
http://extendmac.com/EMKeychain/
© Copyright 2007 Extendmac, LLC.  All Rights Reserved.

**Purpose:** To create a cocoa wrapper class (not a bloated framework) to proxy between your application and the unfortunately-carbon based keychain.

**Current State:** Usable in what I expect to be most simple application scenarios. See the class overview information below to verify that EMKeychain is the best fit for your project.

**Requirements:**
* Link your application against the Security frameworks in /System/Library (Carbon is not necessary!)

Class Overview
==============

* EMKeychainItem
	* A container object that houses information about your keychain item, and provides modification functionality.
	* Locking the Keychain:
		* `+ (void)lockKeychain;`
		* `+ (void)unlockKeychain;`
	* Getters
		* `- (NSString *)password;`
		* `- (NSString *)username;`
	* Setters
		* `- (BOOL)setPassword:(NSString *)newPassword;`
		* `- (BOOL)setUsername:(NSString *)newUsername;`
	* Subclasses
		* EMGenericKeychainItem
			* Convenience methods for Getting and Setting a password on a generic Keychain
				* `+ (void) setKeychainPassword:(NSString*)password forUsername:(NSString*)username service:(NSString*)serviceName;`
				* `+ (NSString*) passwordForUsername:(NSString*)username service:(NSString*)serviceName;`
			* Getting or Creating new Keychain items
				* `+ (EMGenericKeychainItem *)genericKeychainItemForService:(NSString *)serviceNameString withUsername:(NSString *)usernameString;`
				* `+ (EMGenericKeychainItem *)addGenericKeychainItemForService:(NSString *)serviceNameString withUsername:(NSString *)usernameString password:(NSString *)passwordString;`
			* Getters
				* `- (NSString *)serviceName;`
			* Setter Methods
				* `- (BOOL)setServiceName:(NSString *)newServiceName;`
		* EMInternetKeychainItem
			* Getting or Creating new Keychain items
				* `+ (EMInternetKeychainItem *)internetKeychainItemForServer:(NSString *)serverString withUsername:(NSString *)usernameString path:(NSString *)pathString port:(int)port protocol:(SecProtocolType)protocol;`
				* `+ (EMInternetKeychainItem *)addInternetKeychainItemForServer:(NSString *)serverString withUsername:(NSString *)usernameString password:(NSString *)passwordString path:(NSString *)pathString port:(int)port protocol:(SecProtocolType)protocol;`
			* Getters
				* `- (NSString *)server;`
				* `- (NSString *)path;`
				* `- (int)port;`
				* `- (SecProtocolType)protocol;`
			* Setters
				* `- (BOOL)setServer:(NSString *)newServer;`
				* `- (BOOL)setPath:(NSString *)newPath;`
				* `- (BOOL)setPort:(int)newPort;`
				* `- (BOOL)setProtocol:(SecProtocolType)newProtocol;`

Example Usage
=============

Adding a generic keychain item

[EMGenericKeychainItem addGenericKeychainItemForService:@"SomeApplicationService" withUsername:@"Joe" password:@"SuperSecure!"];

Adding an internet keychain item

[EMInternetKeychainItem addInternetKeychainItemForServer:@"apple.com" withUsername:@"sjobs" password:@"magic" path:@"/httpdocs/" port:21 protocol:kSecProtocolTypeFTP];

Note that the "protocol" asks for a SecProtocolType. 

Working with a keychain item

EMInternetKeychainItem *keychainItem = [EMInternetKeychainItem internetKeychainItemForServer:@"apple.com" withUsername:@"sjobs" path:@"/httpdocs" port:21 protocol:kSecProtocolTypeFTP];

//Get the password
NSString *password = [keychainItem password];

//Change the password and user
[keychainItem setPassword:@"mynewpass"];
[keychainItem setUsername:@"phil"];