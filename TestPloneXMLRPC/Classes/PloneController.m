//
//  PloneController.m
//  TestPloneXMLRPC
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "PloneController.h"

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

@implementation PloneController

#pragma mark -
#pragma mark properties {{{1

@synthesize connectionManager;
@synthesize delegate;
@synthesize baseURL;


#pragma mark -
#pragma mark Init, Dealloc {{{1

- (id)init
{
    DBGS;
    return [self initWithBaseURL:@"http://127.0.0.1:8080/plone"];
}

- (id)initWithBaseURL:(NSString *)url
{
    DBGS;
    if (self = [super init]) {

        connectionManager = [XMLRPCConnectionManager sharedManager];
        baseURL = [NSURL URLWithString: url];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark fetching {{{1

- (NSString *)fetchObject:(NSString *)path
{
    DBG(path);

    // create a request
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: baseURL];

    // set ethod and params
    NSArray *params = [[NSArray alloc] initWithObjects: path, nil];
    [request setMethod: @"get_object" withParameter:params];

    // .. and fire of async request
    NSString *reqId = [connectionManager spawnConnectionWithXMLRPCRequest: request delegate: self];

    [params release];
    [request release];

    return reqId;
}

#pragma mark -
#pragma mark XMLRPCConnectionDelegate Methods {{{1

- (void)    request: (XMLRPCRequest *)request
 didReceiveResponse: (XMLRPCResponse *)response
{
    DBGS;

    NSDictionary *ploneDict = [response object];
    //DBG(ploneDict);

    if ([delegate respondsToSelector:@selector(didReceiveObject:forPath:)]) {
        //DBG([request parameters]);
        //NSString *path = [self pathFromRequest: request];

        for (NSString *key in ploneDict) {
            NSArray *object = [ploneDict objectForKey:key];
            PloneContentModel *content = [[PloneContentModel alloc] init];

            content.content         = [object objectAtIndex:0];
            content.contentType     = [object objectAtIndex:1];
            content.misc            = [object objectAtIndex:2];

            [delegate didReceiveObject:[content autorelease] forPath:key];
        }

    }
}


- (void)    request:(XMLRPCRequest *)request
   didFailWithError: (NSError *)error;
{
    DBG(error);
    if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
        NSLog(@"informing delegate %@ of error %@", delegate, error);
        [delegate didFailWithError:error];
    }
}

- (BOOL)                        request: (XMLRPCRequest *)request
  canAuthenticateAgainstProtectionSpace: (NSURLProtectionSpace *)protectionSpace
{
    DBG(request);
    DBG(protectionSpace);
    DBG([protectionSpace authenticationMethod]);
    return YES;
}

- (void)                        request: (XMLRPCRequest *)request
      didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
    DBG(request);
    DBG(challenge);
    NSURLCredential *credential = [NSURLCredential credentialWithUser:@"admin" password:@"admin" persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential: credential forAuthenticationChallenge: challenge];
    
}

- (void)request: (XMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
    DBGS;
}

@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
