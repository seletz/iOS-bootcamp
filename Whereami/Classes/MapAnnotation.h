//
//  MapAnnotation.h
//  Whereami
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import <MapKit/MapKit.h>

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

@interface MapAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D         coordinate;
	NSString                       *title;
	NSString                       *subtitle;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

@end

@interface MapAnnotationArray : NSObject
{
	NSMutableArray                 *annotations;
}

- (void)addAnnotation:(id <MKAnnotation>)annotation;

@end
