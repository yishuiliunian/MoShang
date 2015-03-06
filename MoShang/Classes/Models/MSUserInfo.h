//
//  MSUserInfo.h
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "JSONModel.h"

@interface MSUserInfo : JSONModel
@property (nonatomic, strong) NSString<Optional>* achievement;
@property (nonatomic, strong) NSString<Optional>* baseinfo;
@property (nonatomic, strong) NSString<Optional>* birth;
@property (nonatomic, strong) NSString<Optional>* gender;
@property (nonatomic, strong) NSString<Optional>* head;
@property (nonatomic, strong) NSString<Optional>* icare;
@property (nonatomic, strong) NSString<Optional>* lastpos;
@property (nonatomic, strong) NSString<Optional>* likelist;
@property (nonatomic, strong) NSString<Optional>* nick;
@property (nonatomic, strong) NSString<Optional>* sign;
@property (nonatomic, strong) NSString<Optional>* sns;
@property (nonatomic, strong) NSString<Optional>* style;
@property (nonatomic, strong) NSString<Optional>* taglist;
@property (nonatomic, strong) NSString<Optional>* trip;
@end
