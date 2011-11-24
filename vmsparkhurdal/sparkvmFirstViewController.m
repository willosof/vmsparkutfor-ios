//
//  sparkvmFirstViewController.m
//  vmsparkhurdal
//
//  Created by William Viker on 11/23/11.
//  Copyright (c) 2011 Kokong AS. All rights reserved.
//

#import "sparkvmFirstViewController.h"
#import "MKMapView ZoomLevel.h"


#define SPARKVM_LATITUDE 60.435
#define SPARKVM_LONGITUDE 11.065633
#define ZOOM_LEVEL_FIRST 14



@implementation sparkvmFirstViewController
@synthesize map;
@synthesize locationManager;
@synthesize searchBar;


//@synthesize receivedData;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"didRecieveMemoryWarning");
    // Release any cached data, images, etc that aren't in use.
}











- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"ViewDidLoad");

	// Do any additional setup after loading the view, typically from a nib.
    
    CLLocationCoordinate2D centerCoord = { SPARKVM_LATITUDE, SPARKVM_LONGITUDE };
    [map setCenterCoordinate:centerCoord zoomLevel:ZOOM_LEVEL_FIRST animated:NO];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 10; // or whatever
    [self.locationManager startUpdatingLocation];
    
    [self.map.userLocation addObserver:self 
                            forKeyPath:@"location" 
                               options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) 
                               context:NULL];
    self.map.showsUserLocation = YES; // starts updating user location

    
    NSDictionary *appdata = [self getData];

    
    NSMutableArray *arr = [appdata mutableArrayValueForKey:@"pins"];
    
    for(NSObject *st in arr) {
        
        CLLocationCoordinate2D inscord = {
            [self StringToDouble:[st valueForKey:@"lat"]],
            [self StringToDouble:[st valueForKey:@"lon"]]
        };
        SSMapAnnotation* annotation = [[SSMapAnnotation alloc] initWithCoordinate:inscord title:[st valueForKey:@"title"] subtitle:@"sub"];
        
        [map addAnnotation:annotation];

        
    }

}


- (double) StringToDouble:(NSString *)str {

    double out;
	if ([str doubleValue]) {
		out = [str doubleValue];
	} else {
		out = 0.0;
	}
	return out;
}


- (NSDictionary *) getData
{
	id response = [self objectWithUrl:[NSURL URLWithString:@"http://vmsparkhurdal.no/ios"]];
	NSDictionary *feed = (NSDictionary *)response;
	return feed;
}


- (id) objectWithUrl:(NSURL *)url
{
	SBJsonParser *jsonParser = [SBJsonParser new];
	NSString *jsonString = [self stringWithUrl:url];
    
	// Parse the JSON into an Object
	return [jsonParser objectWithString:jsonString error:NULL];
}

- (NSString *)stringWithUrl:(NSURL *)url
{
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    // Fetch the JSON response
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
    
	// Make synchronous request
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
 	// Construct a String around the Data from the response
	return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
}









-(void)observeValueForKeyPath:(NSString *)keyPath 
                     ofObject:(id)object 
                       change:(NSDictionary *)change 
                      context:(void *)context 
{
    if ([self.map isUserLocationVisible]) {
        [self.locationManager stopUpdatingLocation];
        //        self.ownBlueMarble.hidden = YES;
    }
    
    // The current location is in self.map.userLocation.coordinate
}



- (void)viewDidUnload
{
    [self setMap:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    NSLog(@"ViewDidUnload");

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"ViewWillAppear");

}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"ViewDidAppear");

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    NSLog(@"ViewWillDisappear");

}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    NSLog(@"ViewDidDisappear");

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    NSLog(@"shouldAutorotateToInterfaceOrientation");
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

         

         
@implementation SSMapAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

#pragma mark -
#pragma mark Class Methods

+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)aCoordinate {
	return [self mapAnnotationWithCoordinate:aCoordinate title:nil subtitle:nil];
}


+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle {
	return [self mapAnnotationWithCoordinate:aCoordinate title:aTitle subtitle:nil];
}


+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle subtitle:(NSString *)aSubtitle {
	SSMapAnnotation *annotation = [[self alloc] init];
	annotation.coordinate = aCoordinate;
	annotation.title = aTitle;
	annotation.subtitle = aSubtitle;
	return annotation;
}


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
}


#pragma mark -
#pragma mark Initializers

- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate {
	return [self initWithCoordinate:aCoordinate title:nil subtitle:nil];
}


- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle {
	return [self initWithCoordinate:aCoordinate title:aTitle subtitle:nil];
}


- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle subtitle:(NSString *)aSubtitle {
	if ((self = [super init])) {
		self.coordinate = aCoordinate;
		self.title = aTitle;
		self.subtitle = aSubtitle;

	}
	return self;
}

@end
