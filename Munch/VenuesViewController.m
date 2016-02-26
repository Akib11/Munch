//
//  VenuesViewController.m
//  Munch
//
//  Created by Akib Quraishi on 25/02/2016.
//  Copyright © 2016 AkibiOS. All rights reserved.
//

#import "VenuesViewController.h"
#import "SCCornerCollectionViewCell.h"
#import "UIColor+Hex.h"
#import "DetailVenueViewController.h"

@interface VenuesViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *colorsArray;

@property (strong, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *placeNameLabel;


@end

static NSString *const kDemoCell = @"demoCell";
static const float kCellHeight = 120.f;
static const float kItemSpace = -20.f;

@implementation VenuesViewController {
    NSArray *venuesArray;
    NSIndexPath *SelectedindexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     if (indexPath.row % 5 == 0) {
     } else if (indexPath.row % 5 == 1) {
     } else if (indexPath.row % 5 == 2) {
     } else if (indexPath.row % 5 == 3) {
     } else if (indexPath.row % 5 == 4) { }
     */
    self.foodNameLabel.text = [NSString stringWithFormat:@"Food: %@", self.foodName];
    self.placeNameLabel.text = [NSString stringWithFormat:@"Location: %@",self.placename];

    self.colorsArray = @[@"EE5464", @"DC4352", @"FD6D50", @"EA583F", @"F6BC43", @"8DC253", @"4FC2E9", @"3CAFDB", @"5D9CEE", @"4B89DD", @"AD93EE", @"977BDD", @"EE87C0", @"D971AE", @"903FB1", @"9D56B9", @"227FBD", @"2E97DE"];
    
    NSDictionary *response = self.venues[@"response"];
    venuesArray = response[@"venues"];
    
    
    
}


- (IBAction)backButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -=CollectionView datasource=-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return venuesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCCornerCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kDemoCell forIndexPath:indexPath];
    
    
    if (indexPath.row % 18 == 0) {
        NSString *hexString = self.colorsArray[0];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 1) {
        NSString *hexString = self.colorsArray[1];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 2) {
        NSString *hexString = self.colorsArray[2];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 3) {
        NSString *hexString = self.colorsArray[3];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 4) {
        NSString *hexString = self.colorsArray[4];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 5) {
        NSString *hexString = self.colorsArray[5];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 6) {
        NSString *hexString = self.colorsArray[6];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 7) {
        NSString *hexString = self.colorsArray[7];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 8) {
        NSString *hexString = self.colorsArray[8];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 9) {
        NSString *hexString = self.colorsArray[9];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 10) {
        NSString *hexString = self.colorsArray[10];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 11) {
        NSString *hexString = self.colorsArray[11];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 12) {
        NSString *hexString = self.colorsArray[12];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 13) {
        NSString *hexString = self.colorsArray[13];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 14) {
        NSString *hexString = self.colorsArray[14];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 15) {
        NSString *hexString = self.colorsArray[15];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 16) {
        NSString *hexString = self.colorsArray[16];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    } else if (indexPath.row % 18 == 17) {
        NSString *hexString = self.colorsArray[17];
        UIColor *color = [UIColor colorFromHexString:hexString];
        cell.color = color;
    }
    
    NSDictionary *tempDic = venuesArray[indexPath.row];
    cell.venueNameLabel.text = tempDic[@"name"];
    
    NSDictionary *location = tempDic[@"location"];
    if ([location valueForKey:@"distance"] != nil) {
        cell.distanceLabel.text = [NSString stringWithFormat:@"%@m", location[@"distance"]];
    }
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    SelectedindexPath = indexPath;
    [self performSegueWithIdentifier:@"SegueToVenueDetail" sender:nil];

}

#pragma mark -=CollectionView layout=-
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.bounds), kCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kItemSpace;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"SegueToVenueDetail"]) {
        DetailVenueViewController *controller = segue.destinationViewController;
        controller.venueDictionary = venuesArray[SelectedindexPath.row];
        
    }
}






@end
