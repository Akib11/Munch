//
//  FourSquareHTTPClient.h
//  Munch
//
//  Created by Akib Quraishi on 25/02/2016.
//  Copyright © 2016 AkibiOS. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <CoreLocation/CoreLocation.h>

@protocol FourSquareHTTPClientDelegate;


@interface FourSquareHTTPClient : AFHTTPSessionManager

@property (nonatomic, weak) id<FourSquareHTTPClientDelegate>delegate;

+(FourSquareHTTPClient *)sharedFourSquareHTTPClient;
-(instancetype)initWithBaseURL:(NSURL *)url;
-(void)updateFourSquareVenuesAtLocation:(CLLocation *)location forFoodName:(NSString *)food;
-(void)updateFourSquareVenuesAtPlaceName:(NSString *)location forFoodName:(NSString *)food;
@end

@protocol FourSquareHTTPClientDelegate <NSObject>

-(void)FourSquareHTTPClient:(FourSquareHTTPClient *)client didUpdateWithVenues:(id)venues;
-(void)FourSquareHTTPClient:(FourSquareHTTPClient *)client didFailWithError:(NSError *)error;

@end