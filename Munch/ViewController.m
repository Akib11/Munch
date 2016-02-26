//
//  ViewController.m
//  Munch
//
//  Created by Akib Quraishi on 23/02/2016.
//  Copyright © 2016 AkibiOS. All rights reserved.
//

#import "ViewController.h"
#import "VenuesViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *iconView;


@end

@implementation ViewController {
    UITextField *tf1;
    UITextField *tf;
UIButton *searchButton;
    NSDictionary *fetchVenue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
// self.searchButton.frame = CGRectMake(self.view.bounds.size.width/2 - 64/2,self.view.bounds.size.height + 280,64, 30);
    // Do any additional setup after loading the view, typically from a nib.
    
    // Blur effect
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [blurEffectView setFrame:self.view.bounds];
    [self.view addSubview:blurEffectView];
    
    // Vibrancy effect
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.view.bounds];
    
    // Label for vibrant text
    UILabel *vibrantLabel = [[UILabel alloc] init];
    [vibrantLabel setText:@"Munch"];
    [vibrantLabel setFont:[UIFont fontWithName:@"Zapfino" size:50]];
    [vibrantLabel sizeToFit];
    [vibrantLabel setCenter: self.view.center];
    
    // Add label to the vibrancy view
    [[vibrancyEffectView contentView] addSubview:vibrantLabel];
    
    // Add the vibrancy view to the blur view
    [[blurEffectView contentView] addSubview:vibrancyEffectView];
    
  
    
    
    
    tf = [[UITextField alloc] initWithFrame:CGRectMake(-300,200,200, 30)];
    tf.textColor = [UIColor whiteColor];
    tf.font = [UIFont fontWithName:@"Helvetica" size:18];
    tf.backgroundColor=[UIColor clearColor];
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    tf.placeholder = @"ex.coffee,sushi,indian";
    tf.delegate = self;
    //second one

    tf1 = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width + 300,240,200, 30)];
    tf1.textColor = [UIColor whiteColor];
    tf1.font = [UIFont fontWithName:@"Helvetica" size:18];
    tf1.backgroundColor=[UIColor clearColor];
    [tf1 setBorderStyle:UITextBorderStyleRoundedRect];
    tf1.text = @"nearby";
    tf1.delegate = self;
    
    
    searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchButton addTarget:self
               action:@selector(searchButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    searchButton.frame = CGRectMake(self.view.bounds.size.width/2 - 64/2,self.view.bounds.size.height + 280,64, 30);
  searchButton.enabled = NO;
    [self.view addSubview:tf];
    [self.view addSubview:tf1];
    [self.view addSubview:searchButton];


    [UIView animateWithDuration:1.2 delay:0.5 usingSpringWithDamping:0.4 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        vibrantLabel.transform = CGAffineTransformMakeScale(1.5, 1.5);
        [vibrantLabel setFrame:CGRectMake( vibrantLabel.frame.origin.x, 30,vibrantLabel.frame.size.width, vibrantLabel.frame.size.height)];
        
        tf.frame = CGRectMake(self.view.bounds.size.width/2 - 200/2,200,200, 30);
        tf1.frame = CGRectMake(self.view.bounds.size.width/2 - 200/2,240,200, 30);
        searchButton.frame = CGRectMake(self.view.bounds.size.width/2 - 64/2,280,64, 30);
        [self.view bringSubviewToFront:self.iconView];
    } completion:^(BOOL finished) {
      
     
    }];
    
 
    
}

- (IBAction)searchButtonPressed:(UIButton *)sender {
     NSLog(@"SearchButtonPressed***");
    
    if ([tf1.text isEqualToString:@"nearby"]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    } else {
        FourSquareHTTPClient *client = [FourSquareHTTPClient sharedFourSquareHTTPClient];
        client.delegate = self;
        [client updateFourSquareVenuesAtPlaceName:tf1.text forFoodName:tf.text];
    }
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Location Updating***");
    // Last object contains the most recent location
    CLLocation *newLocation = [locations lastObject];
    
    // If the location is more than 5 minutes old, ignore it
    if([newLocation.timestamp timeIntervalSinceNow] > 300)
        return;
    
    [self.locationManager stopUpdatingLocation];
    
    FourSquareHTTPClient *client = [FourSquareHTTPClient sharedFourSquareHTTPClient];
    client.delegate = self;
    [client updateFourSquareVenuesAtLocation:newLocation forFoodName:tf.text];
    
}

#pragma mark - FourSquareHTTPClientDelegate

-(void)FourSquareHTTPClient:(FourSquareHTTPClient *)client didUpdateWithVenues:(id)venues {

    fetchVenue = venues;
    
    //NSLog(@"****** %@",fetchVenue);
    
    NSDictionary *tempResponse = fetchVenue[@"response"];
    NSArray *array = tempResponse[@"venues"];
    
    if (array.count > 0) {
        [self performSegueWithIdentifier:@"SegueToVenues" sender:nil];
    } else {
    [self showAlert];
    }

}

-(void)FourSquareHTTPClient:(FourSquareHTTPClient *)client didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    [self showAlert];
    
}


#pragma mark - textFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range  replacementString:(NSString *)string {
    
    if ([tf.text length] > 2 && [tf.text length] > 2) {
        searchButton.enabled = YES;
    } else {
    searchButton.enabled = NO;
    }
    
    NSString *resultingString = [textField.text stringByReplacingCharactersInRange: range withString: string];
    NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
    if  ([resultingString rangeOfCharacterFromSet:whitespaceSet].location == NSNotFound)      {
        return YES;
    }  else  {
        return NO;
    }

}

#pragma mark -Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"SegueToVenues"]) {
        VenuesViewController *controller = segue.destinationViewController;
        controller.venues = fetchVenue;
        controller.foodName = tf.text;
        controller.placename = tf1.text;
    }
}


-(void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"oops!" message:@"Check internet connection and spelling, please try again." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];

}
@end
