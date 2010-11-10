//
//  ImageCache.h
//  Homepwner
//
//  Created by Stephan Eletzhofer on 10.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageCache : NSObject {
    NSMutableDictionary *dictionary;
}

+ (ImageCache *)sharedImageCache;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
