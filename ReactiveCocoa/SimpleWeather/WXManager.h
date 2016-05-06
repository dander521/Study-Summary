//
//  WXManager.h
//  SimpleWeather
//
//  Created by 程荣刚 on 15/8/13.
//  Copyright (c) 2015年 rongkecloud. All rights reserved.
//

@import Foundation;
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa.h>
// 1
#import "WXCondition.h"

@interface WXManager : NSObject<CLLocationManagerDelegate>

// 2
+ (instancetype)sharedManager;

// 3
@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong, readonly) WXCondition *currentCondition;
@property (nonatomic, strong, readonly) NSArray *hourlyForecast;
@property (nonatomic, strong, readonly) NSArray *dailyForecast;

// 4
- (void)findCurrentLocation;

@end
