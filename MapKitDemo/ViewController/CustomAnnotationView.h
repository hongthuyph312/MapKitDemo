//
//  CustomAnnotationView.h
//  MapKitDemo
//
//  Created by ThuyPH on 9/21/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CallOutView.h"

@interface CustomAnnotationView : MKAnnotationView

@property (strong, nonatomic) CallOutView *gCallOutView;

- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier andPinImage:(UIImage*) image;
- (void) updateAnnotation:(id<MKAnnotation>) annotation;
- (void) showCallOutView;
- (void) hideCallOutView;
@end
