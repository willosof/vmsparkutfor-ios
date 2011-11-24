//
//  sparkvmFirstViewController.h
//  vmsparkhurdal
//
//  Created by William Viker on 11/23/11.
//  Copyright (c) 2011 Kokong AS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import "SBJson.h"



@interface sparkvmFirstViewController : UIViewController {
}
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, atomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (NSDictionary *) getData;
- (id) objectWithUrl:(NSURL *)url;
- (NSString *)stringWithUrl:(NSURL *)url;
- (double) StringToDouble:(NSString *)str;


@end


@interface SSMapAnnotation : NSObject <MKAnnotation> {
    
@private
    
	CLLocationCoordinate2D _coordinate;
	NSString * _title;
	NSString * _subtitle;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)aCoordinate;
+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle;
+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle subtitle:(NSString *)aSubtitle;

- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate;
- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle;
- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle subtitle:(NSString *)aSubtitle;

@end
