//
//  SearchRouteController.h
//  MapKitDemo
//
//  Created by ThuyPH on 9/13/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SearchRouteController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *gSearchBar;
@property (weak, nonatomic) IBOutlet MKMapView *gMapView;

@end
