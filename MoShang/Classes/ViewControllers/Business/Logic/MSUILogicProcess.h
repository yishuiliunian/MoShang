//
//  MSUILogicProcess.h
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSUILogicProcess;
@protocol MSUILogicDelegate
- (void) logicProcess:(MSUILogicProcess*)process finishedScucceed:(BOOL)scuceed error:(NSError*)error;
@end
@interface MSUILogicProcess : NSObject
@property (nonatomic, weak) id<MSUILogicDelegate> delegate;
@end
