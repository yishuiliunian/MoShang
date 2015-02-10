//
//  MSFeed.h
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSModel.h"
#import "MSFeedLayoutItem.h"
#import <DZProgramDefines.h>
#import <JSONAPI.h>
@interface MSFeed : JSONModel
@property (nonatomic, strong) MSFeedLayoutItem<Optional>* layoutItem;

@property (nonatomic, strong) NSString<Optional>* author;
@property (nonatomic, strong) NSString* bg;
@property (nonatomic, strong) NSString* birth;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, assign) double gender;
@property (nonatomic, strong) NSString* head;
@property (nonatomic, assign) int likecount;
@property (nonatomic, assign) NSTimeInterval modifytime;
@property (nonatomic, strong) NSString* nick;
@property (nonatomic, strong) NSString* piclist;
@property (nonatomic, strong) NSString* pos;
@property (nonatomic, assign) int recordid;
@property (nonatomic, strong) NSString* sign;
@property (nonatomic, strong) NSString* taglist;

@end
