//
//  DetailVenueViewController.h
//  Munch
//
//  Created by Akib Quraishi on 26/02/2016.
//  Copyright © 2016 AkibiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface DetailVenueViewController : UIViewController <MKMapViewDelegate> 

@property (nonatomic,strong) NSDictionary *venueDictionary;
@end
