//
//  PloneController.h
//  TestPloneXMLRPC
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XMLRPC.h"
#import "PloneContentModel.h"

@protocol PloneControllerDelegate<NSObject>

- (void)didReceiveObject:(PloneContentModel *)object forPath:(NSString *)path;
- (void)didFailWithError:(NSError *)error;

@end


@interface PloneController : NSObject <XMLRPCConnectionDelegate> {

    id<PloneControllerDelegate> delegate;

    XMLRPCConnectionManager *connectionManager;
    NSURL                   *baseURL;

}

@property (nonatomic, assign) XMLRPCConnectionManager *connectionManager;
@property (nonatomic, retain) NSURL *baseURL;
@property (nonatomic, retain) id<PloneControllerDelegate> delegate;

- (id)initWithBaseURL:(NSString *)url;

- (NSString *)fetchObject:(NSString *)path;

@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
