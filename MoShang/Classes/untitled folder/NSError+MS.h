//
//  NSError+MS.h
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSError (MS)
+ (NSError*) ms_errorWithMessage:(NSString*)message code:(int)code;
@end
