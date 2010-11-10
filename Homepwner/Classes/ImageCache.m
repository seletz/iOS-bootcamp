//
//  ImageCache.m
//  Homepwner
//
//  Created by Stephan Eletzhofer on 10.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "ImageCache.h"

static ImageCache *sharedImageCache = nil;

@implementation ImageCache

#pragma mark -
#pragma mark initializer {{{1

- (id)init
{
    [super init];
    dictionary = [[NSMutableDictionary alloc] init];
    return self;
}

#pragma mark -
#pragma mark Image Cache {{{1

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [dictionary setObject:image forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key
{
    return [dictionary objectForKey:key];
}

- (void)deleteImageForKey:(NSString *)key
{
    [dictionary removeObjectForKey:key];
}

#pragma mark -
#pragma mark singleton {{{1

+ (ImageCache*)sharedImageCache
{
    if (sharedImageCache == nil) {
        sharedImageCache = [[super allocWithZone:NULL] init];
    }
    return sharedImageCache;
}
 
+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedImageCache] retain];
}
 
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
 
- (id)retain
{
    return self;
}
 
- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}
 
- (void)release
{
    //do nothing
}
 
- (id)autorelease
{
    return self;
}

@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
