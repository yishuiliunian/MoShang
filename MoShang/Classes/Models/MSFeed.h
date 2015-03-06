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
@property (nonatomic, strong) NSString<Optional>* bg;
@property (nonatomic, strong) NSString<Optional>* birth;
@property (nonatomic, strong) NSString<Optional>* content;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, assign) double gender;
@property (nonatomic, strong) NSString<Optional>* head;
@property (nonatomic, assign, readonly) int n_likecount;
@property (nonatomic, strong) NSString<Optional>* likecount;
@property (nonatomic, assign) NSTimeInterval modifytime;
@property (nonatomic, strong) NSString<Optional>* nick;
@property (nonatomic, strong) NSString<Optional>* piclist;
@property (nonatomic, strong) NSString<Optional>* pos;
@property (nonatomic, strong) NSString<Optional>*  recordid;
@property (nonatomic, strong) NSString<Optional>* sign;
@property (nonatomic, strong) NSString<Optional>* taglist;

@end
