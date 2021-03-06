//
//  SearchLocationController.m
//  MapKitDemo
//
//  Created by ThuyPH on 9/13/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import "SearchLocationController.h"

@interface SearchLocationController ()

@end

@implementation SearchLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_gSearchBar resignFirstResponder];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_gSearchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        if (!placemarks || placemarks.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No result" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        }
        
        for (int i = 0; i < placemarks.count; i++) {
            CLPlacemark *placemark = [placemarks objectAtIndex:i];
            MKCoordinateRegion region;
            region.center = placemark.location.coordinate;
            MKCoordinateSpan span = {0.01,0.01};
            region.span = span;
            [_gMapView setRegion:region animated:YES];
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = region.center;
            annotation.title = _gSearchBar.text;
            [_gMapView addAnnotation:annotation];
        }
    }];
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
