//
//  MSUserInfo.h
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "JSONModel.h"

@interface MSUserInfo : JSONModel
@property (nonatomic, strong) NSString* achievement;
@property (nonatomic, strong) NSString* baseinfo;
@property (nonatomic, strong) NSString* birth;
@property (nonatomic, assign) int gender;
@property (nonatomic, strong) NSString* head;
@property (nonatomic, strong) NSString* icare;
@property (nonatomic, strong) NSString* lastpos;
@property (nonatomic, strong) NSString* likelist;
@property (nonatomic, strong) NSString* nick;
@property (nonatomic, strong) NSString* sign;
@property (nonatomic, strong) NSString* sns;
@property (nonatomic, strong) NSString* style;
@property (nonatomic, strong) NSString* taglist;
@property (nonatomic, strong) NSString* trip;
@end
