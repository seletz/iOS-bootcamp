//
//  MapAnnotation.m
//  Whereami
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (void)dealloc
{
	DBGS;
	[title release];
	[subtitle release];
	[super dealloc];
}

@end

@implementation MapAnnotationArray

- (void)addAnnotation:(id <MKAnnotation>)annotation
{
	DBGS;
	[annotations addObject:annotation];
}

- (void)dealloc
{
	DBGS;
	[annotations release];
	[super dealloc];
}

@end
