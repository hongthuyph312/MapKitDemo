//
//  MyLocationController.m
//  MapKitDemo
//
//  Created by ThuyPH on 9/13/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import "MyLocationController.h"

@interface MyLocationController (){
    ChangeMapType *changeMapTypeView;
}
@end

@implementation MyLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    _gMapView.showsUserLocation = YES;
    _gMapView.delegate = self;
    changeMapTypeView = [[[NSBundle mainBundle] loadNibNamed:@"ChangeMapType" owner:self options:nil] lastObject];
    changeMapTypeView = [changeMapTypeView initWithClickBlock:^(NSInteger row){
        [self changeTypeButtonClicked:nil];
        _gMapView.mapType = row;
    }];
    NSDictionary *views = @{@"changeMapType":changeMapTypeView};
    [self.view addSubview:changeMapTypeView];
    [changeMapTypeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSString *strVerticalConstraint = @"V:|-0-[changeMapType(==135)]";
    NSString *strHorizontalconstraint = @"H:[changeMapType(==150)]-(-150)-|";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:strVerticalConstraint options:0 metrics:nil views:views]];
    NSArray *arrConstraint = [NSLayoutConstraint constraintsWithVisualFormat:strHorizontalconstraint options:0 metrics:nil views:views];
    [self.view addConstraints:arrConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString * const identifier = @"MyCustomAnnotation";
    MKAnnotationView *annotationView = [_gMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView) {
        annotationView.annotation = annotation;
    }else{
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

- (IBAction)changeTypeButtonClicked:(id)sender {
    changeMapTypeView.isShow = !changeMapTypeView.isShow;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        if (changeMapTypeView.isShow) {
            changeMapTypeView.center = CGPointMake(self.view.frame.size.width - changeMapTypeView.frame.size.width/2, changeMapTypeView.center.y);
        }else{
            changeMapTypeView.center = CGPointMake(self.view.frame.size.width + changeMapTypeView.frame.size.width/2, changeMapTypeView.center.y);
        }

    }];
}
@end
