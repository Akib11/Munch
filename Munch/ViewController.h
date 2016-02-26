//
//  ViewController.h
//  Munch
//
//  Created by Akib Quraishi on 23/02/2016.
//  Copyright © 2016 AkibiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourSquareHTTPClient.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<FourSquareHTTPClientDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

