//
//  SearchRouteController.m
//  MapKitDemo
//
//  Created by NgocNK on 9/13/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import "SearchRouteController.h"
#import "AFNetworking.h"
#import <AddressBook/AddressBook.h>
#import <MapKit/MapKit.h>


@interface SearchRouteController ()
{
    NSMutableArray *arrRoutePoints;
    MKPolyline *routeLine;
    MKPolylineView *routeLineView;
    NSArray *routes;
    CLLocationManager *locationManager;
}
@property (strong, nonatomic) MKMapItem *destination;
@end

@implementation SearchRouteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CLLocationCoordinate2D loc1;
    loc1.latitude = 29.0167;
    loc1.longitude = 77.3833;
    MKPointAnnotation *origin = [[MKPointAnnotation alloc] init];
    origin.title = @"loc1";
    origin.subtitle = @"home1";
    origin.coordinate = loc1;
    // Destination Location.
    CLLocationCoordinate2D loc2;
    loc2.latitude = 19.076000;
    loc2.longitude = 72.877670;
    
    MKPointAnnotation *destination = [[MKPointAnnotation alloc] init];
    destination.title = @"loc2";
    destination.subtitle = @"home2";
    destination.coordinate = loc2;
    [_gMapView addAnnotation:destination];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [locationManager requestAlwaysAuthorization];
//    [locationManager startUpdatingLocation];
    _gMapView.showsUserLocation = YES;
    _gMapView.delegate = self;
    CLLocationCoordinate2D currentLocation =  locationManager.location.coordinate;
    CLLocationCoordinate2D location = {21.037340,105.835257};
    [self drawLineRouteFrom:currentLocation To:location];
   
//    if ([CLLocationManager locationServicesEnabled]){
//        NSLog(@"Location Services Enabled");
//        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
//                                               message:@"To re-enable, please go to Settings and turn on Location Service for this app."
//                                              delegate:nil
//                                     cancelButtonTitle:@"OK"
//                                     otherButtonTitles:nil];
//            [alert show];
//        }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized){
//                    NSLog(@"enabled location");
//        }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
//            NSLog(@"not determine");
//        }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
//            NSLog(@"when determine");
//        }
//    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

- (void) drawLineRouteFrom:(CLLocationCoordinate2D) sourceLocation To:(CLLocationCoordinate2D) destinationLocation
{
    MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:sourceLocation addressDictionary:nil];
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:destinationLocation addressDictionary:nil];
    MKMapItem *sourceMapItem = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    MKDirectionsRequest *fineRouteRequest = [[MKDirectionsRequest alloc] init];
    fineRouteRequest.source = sourceMapItem;
    fineRouteRequest.destination = destinationMapItem;
    fineRouteRequest.transportType = MKDirectionsTransportTypeAutomobile;
    MKDirections *dircection = [[MKDirections alloc] initWithRequest:fineRouteRequest];
    [dircection calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * response, NSError *error){
        if (error == nil) {
            MKRoute *route = response.routes.firstObject;
            [self.gMapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
            MKMapRect rect = route.polyline.boundingMapRect;
            [self.gMapView setVisibleMapRect:rect edgePadding:UIEdgeInsetsMake(40, 40, 20, 20) animated:YES];
        }else
        {
            NSLog(@"%@",error.description);
        }
    }];
}

#pragma mark MKPolyline delegate functions

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
