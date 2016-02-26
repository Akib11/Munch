//
//  DemoCollectionViewCell.m
//  StickCollectionView
//
//  Created by Bogdan Matveev on 21/09/15.
//  Copyright (c) 2015 Bogdan Matveev. All rights reserved.
//

#import "SCCornerCollectionViewCell.h"

@interface SCCornerCollectionViewCell ()


@end

@implementation SCCornerCollectionViewCell

- (void)awakeFromNib {
    self.backingView.layer.cornerRadius = 12.f;
    self.backingView.layer.masksToBounds = YES;
}



- (void)setColor:(UIColor *)color {
    self.backingView.backgroundColor = color;
}

@end
