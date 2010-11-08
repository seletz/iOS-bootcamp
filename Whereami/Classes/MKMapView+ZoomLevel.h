// MKMapView+ZoomLevel.h
// from:
//
// http://troybrant.net/blog/2010/01/set-the-zoom-level-of-an-mkmapview/
//
#import <MapKit/MapKit.h>

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
    zoomLevel:(NSUInteger)zoomLevel
    animated:(BOOL)animated;

@end

