//
//  MSToken.h
//  MoShang
//
//  Created by stonedong on 15/2/1.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSToken : NSObject
@property (nonatomic, strong) NSString* account;
@property (nonatomic, strong) NSString* token;
@property (nonatomic, strong) NSDate* experiedDate;

- (instancetype) initWithToken:(NSString*)token account:(NSString*)account;
@end
