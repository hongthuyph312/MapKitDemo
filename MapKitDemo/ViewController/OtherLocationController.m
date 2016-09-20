//
//  OtherLocationController.m
//  MapKitDemo
//
//  Created by NgocNK on 9/13/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import "OtherLocationController.h"

@interface OtherLocationController ()

@end

@implementation OtherLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //21.007486,105.840736
    _gMapView.showsUserLocation = YES;
    
    MKCoordinateSpan span = {0.05,0.05};
    CLLocationCoordinate2D location = {21.007486,105.840736};
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = location;
    
    [_gMapView setRegion:region animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    point.title = @"Test";
    [_gMapView addAnnotation:point];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return annotationView;
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
