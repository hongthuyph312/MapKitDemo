//
//  OtherLocationController.h
//  MapKitDemo
//
//  Created by ThuyPH on 9/13/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface OtherLocationController : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *gMapView;

@end
