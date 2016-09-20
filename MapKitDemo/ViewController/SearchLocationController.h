//
//  SearchLocationController.h
//  MapKitDemo
//
//  Created by NgocNK on 9/13/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SearchLocationController : UIViewController<UISearchBarDelegate,UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *gSearchBar;
@property (weak, nonatomic) IBOutlet MKMapView *gMapView;

@end
