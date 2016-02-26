//
//  FourSquareHTTPClient.m
//  Munch
//
//  Created by Akib Quraishi on 25/02/2016.
//  Copyright © 2016 AkibiOS. All rights reserved.
//

#import "FourSquareHTTPClient.h"

static NSString * const Client_ID = @"ADD_YOUR_CLIENT_ID";
static NSString * const Client_Secret =@"ADD_YOUR_CLIENT_SECRET_ID";
static NSString * const FourSquareAPIUrl = @"https://api.foursquare.com/v2/";

static NSString * const Category_Id = @"4d4b7105d754a06374d81259";

@implementation FourSquareHTTPClient

+(FourSquareHTTPClient *)sharedFourSquareHTTPClient{
    
    static FourSquareHTTPClient *_SharedFourSquareHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _SharedFourSquareHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:FourSquareAPIUrl]];
    });
    
    return _SharedFourSquareHTTPClient;
}


-(instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

-(void)updateFourSquareVenuesAtLocation:(CLLocation *)location forFoodName:(NSString *)food{
    
//    https://api.foursquare.com/v2/venues/search?
//    client_id =
//    &client_secret =
//    &categoryId=4d4b7105d754a06374d81259
//    &v=20130815
//    &near=
//    &limit=
//    &query=
    
 NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = Client_ID;
    parameters[@"client_secret"] = Client_Secret;
    parameters[@"categoryId"] = Category_Id;
    parameters[@"v"] = @"20130815";
    parameters[@"ll"] = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
    parameters[@"limit"] = @"30";
    parameters[@"query"] = food;
    
    [self GET:@"venues/search" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(FourSquareHTTPClient:didUpdateWithVenues:)]) {
            [self.delegate FourSquareHTTPClient:self didUpdateWithVenues:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(FourSquareHTTPClient:didFailWithError:)]) {
            [self.delegate FourSquareHTTPClient:self didFailWithError:error];
        }
    }];

}


-(void)updateFourSquareVenuesAtPlaceName:(NSString *)location forFoodName:(NSString *)food{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = Client_ID;
    parameters[@"client_secret"] = Client_Secret;
    parameters[@"categoryId"] = Category_Id;
    parameters[@"v"] = @"20130815";
    parameters[@"near"] = location;
    parameters[@"limit"] = @"30";
    parameters[@"query"] = food;
    
    [self GET:@"venues/search" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(FourSquareHTTPClient:didUpdateWithVenues:)]) {
            [self.delegate FourSquareHTTPClient:self didUpdateWithVenues:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(FourSquareHTTPClient:didFailWithError:)]) {
            [self.delegate FourSquareHTTPClient:self didFailWithError:error];
        }
    }];


}
@end
