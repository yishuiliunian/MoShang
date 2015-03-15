//
//  MSCreateFeedProcess.h
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSUILogicProcess.h"
#import "MSPhotoManager.h"
@interface MSCreateFeedProcess : MSUILogicProcess
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* backgroundColor;
@property (nonatomic, strong) MSPhotoManager* photoManager;
@property (nonatomic, assign) BOOL contentReady;
@property (nonatomic, assign) BOOL photoReady;
- (void)  forcePost;
- (void) post;
- (BOOL) setContent:(NSString *)content error:(NSError*__autoreleasing*)error;
@end
