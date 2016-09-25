//
//  ChangeMapType.h
//  MapKitDemo
//
//  Created by Thuy Phan on 9/23/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChangeMapTypeBlock) (NSInteger);


@interface ChangeMapType : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *gTableView;
@property (strong,nonatomic) ChangeMapTypeBlock blockChangeType;
@property (nonatomic) BOOL isShow;

- (id) initWithClickBlock:(ChangeMapTypeBlock)block; 

@end
