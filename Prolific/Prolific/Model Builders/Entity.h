//
//  EntityBuilder.h
//  Prolific
//
//  Created by meganyu on 7/14/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class EntityBuilder;

#pragma mark - Entity base class

@interface Entity : NSObject

@property (nonatomic, readonly) NSString *Id;

- (instancetype)initWithBuilder:(EntityBuilder *)builder;

@end

#pragma mark - EntityBuilder base class

@interface EntityBuilder : NSObject

@property (nonatomic) NSString *Id;

- (Entity *)build;

@end

NS_ASSUME_NONNULL_END
