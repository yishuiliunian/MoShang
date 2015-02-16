//
//  MSAccount.h
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModelLib.h>
#import <Realm.h>
@interface MSAccount : JSONModel
@property (nonatomic, strong) NSString* accountID;
@property (nonatomic, strong) NSString<Optional>* nickName;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString<Optional>* email;
@property (nonatomic, strong) NSString* phoneNumber;
@end
