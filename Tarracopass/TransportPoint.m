//
//  TransportPoint.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 19/10/13.
//  Copyright (c) 2013 Tarracopass. All rights reserved.
//

#import "TransportPoint.h"

@implementation TransportPoint
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;



- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate 
{
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]]) 
        return @"Unknown charge";
    else
        return _name;
}

- (NSString *)subtitle {
    return _address;
}

@end
