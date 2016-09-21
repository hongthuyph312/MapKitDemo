//
//  CustomAnnotationView.m
//  MapKitDemo
//
//  Created by ThuyPH on 9/21/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import "CustomAnnotationView.h"
#define MAX_SIZE_TITLE CGSizeMake(80, 50)
@implementation CustomAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier andPinImage:(UIImage *)image
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image = image;
        _gCallOutView = [[[NSBundle mainBundle] loadNibNamed:@"CallOutView" owner:self options:nil] firstObject];
        _gCallOutView.clipsToBounds = YES;
        _gCallOutView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _gCallOutView.layer.borderWidth = 2;
        _gCallOutView.layer.cornerRadius = 5;
        _gCallOutView.gLbTitle.text = self.annotation.title;
        CGSize sizeOfTitle = [Common sizeForString:_gCallOutView.gLbTitle.text andFont:_gCallOutView.gLbTitle.font maxSize:MAX_SIZE_TITLE];
        _gCallOutView.frame = CGRectMake(_gCallOutView.frame.origin.x, _gCallOutView.frame.origin.y, sizeOfTitle.width + 30 + 20, sizeOfTitle.height + 16);
        [self addSubview:_gCallOutView];
        _gCallOutView.hidden = YES;
        [self positionSubviews];
    }
    return self;
}

- (void) updateAnnotation:(id<MKAnnotation>)annotation
{
    self.annotation = annotation;
    _gCallOutView.hidden = YES;
    _gCallOutView.gLbTitle.text = self.annotation.title;
    CGSize sizeOfTitle = [Common sizeForString:_gCallOutView.gLbTitle.text andFont:_gCallOutView.gLbTitle.font maxSize:MAX_SIZE_TITLE];
    _gCallOutView.frame = CGRectMake(_gCallOutView.frame.origin.x, _gCallOutView.frame.origin.y, sizeOfTitle.width + 30 + 20, sizeOfTitle.height + 16);
    [self positionSubviews];

}

- (void)positionSubviews {
    CGRect frame = _gCallOutView.frame;
    frame.origin.y = -frame.size.height;
    frame.origin.x = (self.frame.size.width - frame.size.width) / 2.0;
    _gCallOutView.frame = frame;
}

- (void)showCallOutView
{
    _gCallOutView.hidden = NO;
}

- (void)hideCallOutView
{
    _gCallOutView.hidden = YES;
}


@end
