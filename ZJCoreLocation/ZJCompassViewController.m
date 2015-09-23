//
//  ZJCompassViewController.m
//  ZJCompass
//
//  Created by YunTu on 15/7/22.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJCompassViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ZJCompassViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (strong, nonatomic) UIImageView *compassIV;

@end

@implementation ZJCompassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"罗盘";
    
    self.compassIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bnavi_icon_location_fixed"]];
    self.compassIV.center = self.view.center;
    [self.view addSubview:self.compassIV];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager requestWhenInUseAuthorization];
    if ([CLLocationManager headingAvailable]) {
        [_locationManager startUpdatingHeading];
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"atention" message:@"compass not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager error: %@", [error description]);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    NSLog(@"angle = %f", newHeading.magneticHeading);
    CGFloat heading = -1.0f * M_PI * newHeading.magneticHeading / 180.0f;
//    angel.text=[[NSString alloc]initWithFormat:@"angle:%f",newHeading.magneticHeading];
    self.compassIV.transform = CGAffineTransformMakeRotation(heading);
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
