//
//  DDSpaceObject.m
//  Out of this World
//
//  Created by DDD on 2013-10-27.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import "DDSpaceObject.h"
#import "AstronomicalData.h"

@implementation DDSpaceObject

-(id)init {
    return [self initWithData:nil image:nil];
}

-(id) initWithData:(NSDictionary *)aData image:(UIImage *)aImage {
    self = [super init];
    if (self) {
        self.name = aData[PLANET_NAME];
        self.gravity = [aData[PLANET_GRAVITY] floatValue];
        self.diameter = [aData[PLANET_DIAMETER] floatValue];
        self.yearLength = [aData[PLANET_YEAR_LENGTH] floatValue];
        self.dayLength = [aData[PLANET_DAY_LENGTH] floatValue];
        self.temperature = [aData[PLANET_TEMPERATURE] intValue];
        self.numberOfMoons = [aData[PLANET_NUMBER_OF_MOONS] intValue];
        self.nickname = aData[PLANET_NICKNAME];
        self.interestingFact = aData[PLANET_INTERESTING_FACT];
        
        self.image = aImage;
    }
    return self;
}
@end
