//
//  WXManager.m
//  SimpleWeather
//
//  Created by 程荣刚 on 15/8/13.
//  Copyright (c) 2015年 rongkecloud. All rights reserved.
//

#import "WXManager.h"
#import "WXClient.h"
#import <TSMessages/TSMessage.h>

@interface WXManager ()

// 1
@property (nonatomic, strong, readwrite) WXCondition *currentCondition;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@property (nonatomic, strong, readwrite) NSArray *hourlyForecast;
@property (nonatomic, strong, readwrite) NSArray *dailyForecast;

// 2
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;
@property (nonatomic, strong) WXClient *client;

@end

@implementation WXManager

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (id)init {
    if (self = [super init]) {
        // 1
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        // 2
        _client = [[WXClient alloc] init];
        
        // 3
        [[[[RACObserve(self, currentLocation)
            // 4
            ignore:nil]
           // 5
           // Flatten and subscribe to all 3 signals when currentLocation updates
           flattenMap:^(CLLocation *newLocation) {
               return [RACSignal merge:@[
                                         [self updateCurrentConditions],
                                         [self updateDailyForecast],
                                         [self updateHourlyForecast]
                                         ]];
               // 6
           }] deliverOn:RACScheduler.mainThreadScheduler]
         // 7
         subscribeError:^(NSError *error) {
             [TSMessage showNotificationWithTitle:@"Error"
                                         subtitle:@"There was a problem fetching the latest weather."
                                             type:TSMessageNotificationTypeError];
         }];
    }
    return self;
}

- (void)findCurrentLocation {
    self.isFirstUpdate = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >  8.0) {
        // 前台定位
        [self.locationManager requestWhenInUseAuthorization];
        // 前后台同时定位
        //        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // 1
    if (self.isFirstUpdate) {
        self.isFirstUpdate = NO;
        return;
    }
    
    CLLocation *location = [locations lastObject];
    
    // 2
    if (location.horizontalAccuracy > 0) {
        // 3
        self.currentLocation = location;
        [self.locationManager stopUpdatingLocation];
    }
}

- (RACSignal *)updateCurrentConditions {
    return [[self.client fetchCurrentConditionsForLocation:self.currentLocation.coordinate] doNext:^(WXCondition *condition) {
        self.currentCondition = condition;
    }];
}

- (RACSignal *)updateHourlyForecast {
    return [[self.client fetchHourlyForecastForLocation:self.currentLocation.coordinate] doNext:^(NSArray *conditions) {
        self.hourlyForecast = conditions;
    }];
}

- (RACSignal *)updateDailyForecast {
    return [[self.client fetchDailyForecastForLocation:self.currentLocation.coordinate] doNext:^(NSArray *conditions) {
        self.dailyForecast = conditions;
    }];
}

@end
