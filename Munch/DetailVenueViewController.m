//
//  DetailVenueViewController.m
//  Munch
//
//  Created by Akib Quraishi on 26/02/2016.
//  Copyright © 2016 AkibiOS. All rights reserved.
//

#import "DetailVenueViewController.h"
#import "WebViewController.h"

@interface DetailVenueViewController ()

@property (strong, nonatomic) IBOutlet UILabel *NameLabel;

@property (strong, nonatomic) IBOutlet UILabel *contactLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;


@property (strong, nonatomic) IBOutlet MKMapView *mapView;


@property (strong, nonatomic) IBOutlet UIButton *menuButton;

@property (strong, nonatomic) IBOutlet UIButton *websiteButton;


@end

@implementation DetailVenueViewController {
    NSDictionary *locationDic;
    CLLocationCoordinate2D venueCoordinate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
    self.websiteButton.hidden = YES;
    self.menuButton.hidden = YES;
    
   // NSLog(@"%@",self.venueDictionary);
    
    self.NameLabel.text = self.venueDictionary[@"name"];
    
    NSDictionary *tempcontactDic = self.venueDictionary[@"contact"];
    self.contactLabel.text = tempcontactDic[@"phone"];
    
    locationDic = self.venueDictionary[@"location"];
    NSArray *stringArray = locationDic[@"formattedAddress"];
    NSString *stringFromArray = [[stringArray valueForKey:@"description"]componentsJoinedByString:@"\n"];
    self.addressLabel.text = stringFromArray;
    
    if ([self.venueDictionary valueForKey:@"url"] != nil) {
        self.websiteButton.hidden = NO;
    }
    
    if ([self.venueDictionary valueForKey:@"menu"] != nil) {
        NSDictionary *menu = self.venueDictionary[@"menu"];
        
        if ([menu valueForKey:@"mobileUrl"] != nil) {
            self.menuButton.hidden = NO;
        }
    
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    venueCoordinate.latitude = [locationDic[@"lat"] doubleValue];
    venueCoordinate.longitude = [locationDic[@"lng"] doubleValue];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = venueCoordinate;
    point.title = self.venueDictionary[@"name"];
    point.subtitle = locationDic[@"postalCode"];
    
    [self.mapView addAnnotation:point];
}


- (IBAction)menuButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"SegueToWebView" sender:sender];
}

- (IBAction)websiteButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"SegueToWebView" sender:sender];
    
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if ([segue.identifier isEqualToString:@"SegueToWebView"]) {
        
        WebViewController *controller = segue.destinationViewController;
       
        if (sender == self.websiteButton) {
        controller.url = [NSURL URLWithString:self.venueDictionary[@"url"]];
       }
        
        if (sender == self.menuButton) {
            NSDictionary *menu = self.venueDictionary[@"menu"];
            controller.url = [NSURL URLWithString:menu[@"mobileUrl"]];
        }
    }
    
}


@end
