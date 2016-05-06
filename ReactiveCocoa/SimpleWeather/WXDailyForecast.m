//
//  WXDailyForecast.m
//  SimpleWeather
//
//  Created by 程荣刚 on 15/8/13.
//  Copyright (c) 2015年 rongkecloud. All rights reserved.
//

#import "WXDailyForecast.h"

@implementation WXDailyForecast

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // 1
    NSMutableDictionary *paths = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    // 2
    paths[@"tempHigh"] = @"temp.max";
    paths[@"tempLow"] = @"temp.min";
    // 3
    return paths;
}

@end
