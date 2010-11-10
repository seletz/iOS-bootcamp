//
//  PloneContentModel.m
//  TestPloneXMLRPC
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "PloneContentModel.h"

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)


@implementation PloneContentModel

#pragma mark -
#pragma mark properties {{{1

@synthesize content;
@synthesize contentType;
@synthesize misc;

#pragma mark -
#pragma mark initializers {{{1

- (id)init
{
    [super init];
    return self;
}

#pragma mark -
#pragma mark memory management {{{1

- (void)dealloc
{
    DBGS;
}

@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
