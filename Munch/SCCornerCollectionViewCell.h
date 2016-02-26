//
//  DemoCollectionViewCell.h
//  StickCollectionView
//
//  Created by Bogdan Matveev on 21/09/15.
//  Copyright (c) 2015 Bogdan Matveev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCornerCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIColor *color;

@property (strong, nonatomic) IBOutlet UIView *backingView;
@property (strong, nonatomic) IBOutlet UILabel *venueNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;


@end
