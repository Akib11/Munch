//
//  WebViewController.m
//  Munch
//
//  Created by Akib Quraishi on 26/02/2016.
//  Copyright © 2016 AkibiOS. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}


- (IBAction)backButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
