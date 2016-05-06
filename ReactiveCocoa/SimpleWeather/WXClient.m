//
//  WXClient.m
//  SimpleWeather
//
//  Created by 程荣刚 on 15/8/13.
//  Copyright (c) 2015年 rongkecloud. All rights reserved.
//

#import "WXClient.h"
#import "WXCondition.h"
#import "WXDailyForecast.h"

@interface WXClient ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation WXClient

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (RACSignal *)fetchJSONFromURL:(NSURL *)url {
    NSLog(@"Fetching: %@",url.absoluteString);
    
    // 1
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 2
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (! error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (! jsonError) {
                    // 1
                    [subscriber sendNext:json];
                }
                else {
                    // 2
                    [subscriber sendError:jsonError];
                } 
            } 
            else { 
                // 2 
                [subscriber sendError:error]; 
            } 
            
            // 3 
            [subscriber sendCompleted];
        }];
        
        // 3
        [dataTask resume];
        
        // 4
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] doError:^(NSError *error) {
        // 5
        NSLog(@"%@",error);
    }]; 
}

- (RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate {
    // 1
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&units=imperial",coordinate.latitude, coordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        // 3
        return [MTLJSONAdapter modelOfClass:[WXCondition class] fromJSONDictionary:json error:nil];
    }];
}

- (RACSignal *)fetchHourlyForecastForLocation:(CLLocationCoordinate2D)coordinate {
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?lat=%f&lon=%f&units=imperial&cnt=12",coordinate.latitude, coordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 1
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        // 2
        RACSequence *list = [json[@"list"] rac_sequence];
        
        // 3
        return [[list map:^(NSDictionary *item) {
            // 4
            return [MTLJSONAdapter modelOfClass:[WXCondition class] fromJSONDictionary:item error:nil];
            // 5
        }] array];
    }]; 
}

- (RACSignal *)fetchDailyForecastForLocation:(CLLocationCoordinate2D)coordinate {
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&units=imperial&cnt=7",coordinate.latitude, coordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Use the generic fetch method and map results to convert into an array of Mantle objects
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        // Build a sequence from the list of raw JSON
        RACSequence *list = [json[@"list"] rac_sequence];
        
        // Use a function to map results from JSON to Mantle objects
        return [[list map:^(NSDictionary *item) {
            return [MTLJSONAdapter modelOfClass:[WXDailyForecast class] fromJSONDictionary:item error:nil];
        }] array];
    }];
}

@end
