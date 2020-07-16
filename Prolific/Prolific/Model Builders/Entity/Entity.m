//
//  EntityBuilder.m
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "Entity.h"

@implementation Entity

- (instancetype)initWithBuilder:(EntityBuilder *)builder {
    //add asserts that validate the builder here
    if (self = [super init]) {
        _Id = builder.Id;
    }
    return self;
}

@end

@implementation EntityBuilder

- (Entity *)build {
    return [[Entity alloc] initWithBuilder:self];
}

@end
