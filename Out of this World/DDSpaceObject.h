//
//  DDSpaceObject.h
//  Out of this World
//
//  Created by DDD on 2013-10-27.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDSpaceObject : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) float gravity;
@property (nonatomic) float diameter;
@property (nonatomic) float yearLength;
@property (nonatomic) float dayLength;
@property (nonatomic) int temperature;
@property (nonatomic) int numberOfMoons;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *interestingFact;
@property (nonatomic, strong) UIImage *image;

-(id)initWithData:(NSDictionary *)aData image:(UIImage *)aImage;

@end
