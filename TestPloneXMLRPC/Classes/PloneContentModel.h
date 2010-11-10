//
//  PloneContentModel.h
//  TestPloneXMLRPC
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PloneContentModel : NSObject {

    NSDictionary *content;
    NSString     *contentType;
    NSDictionary *misc;

}

@property (nonatomic, retain) NSDictionary *content;
@property (nonatomic, retain) NSString     *contentType;
@property (nonatomic, retain) NSDictionary *misc;

- (id)init;

@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
