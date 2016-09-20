//
//  SearchRouteController.m
//  MapKitDemo
//
//  Created by NgocNK on 9/13/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import "SearchRouteController.h"
#import <MapKit/MapKit.h>


@interface SearchRouteController ()
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentLocation;
}
@property (strong, nonatomic) MKMapItem *destination;
@end

@implementation SearchRouteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _gMapView.showsUserLocation = YES;
    _gMapView.delegate = self;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [locationManager requestAlwaysAuthorization];
//    [locationManager startUpdatingLocation];

    currentLocation =  locationManager.location.coordinate;
//    CLLocationCoordinate2D location = {21.037340,105.835257};
//    [self drawLineRouteFrom:currentLocation To:location];
   
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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_gSearchBar resignFirstResponder];
    //Remove all annotation and overlays
    [_gMapView removeAnnotations:[_gMapView annotations]];
    [_gMapView removeOverlays:[_gMapView overlays]];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_gSearchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        if (!placemark) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No result" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        }
        MKCoordinateRegion region;
        region.center = placemark.location.coordinate;
//        [_gMapView setRegion:region animated:YES];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = region.center;
        annotation.title = _gSearchBar.text;
        [_gMapView addAnnotation:annotation];
        
        [self drawLineRouteFrom:currentLocation To:annotation.coordinate];
    }];
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
            [self.gMapView setVisibleMapRect:rect edgePadding:UIEdgeInsetsMake(40, 40, 40, 40) animated:YES];
        }else
        {
            UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertError show];
        }
    }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 2.5;
    return renderer;
}

#pragma mark MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    
    region.span = span;
    region.center = location;
    
    [mapView setRegion:region animated:YES];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString * const identifier = @"MyCustomAnnotation";
    MKAnnotationView *annotationView = [_gMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView) {
        annotationView.annotation = annotation;
    }else
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    annotationView.image = [UIImage imageNamed:@"ico_place"];
    annotationView.centerOffset = CGPointMake(0, -29/2);
    return annotationView;
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
