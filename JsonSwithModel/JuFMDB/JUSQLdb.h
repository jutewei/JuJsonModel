//
//  LEFMDBSql.h
//  XYLEUnit
//
//  Created by Juvid on 15/4/21.
//  Copyright (c) 2015年 XYGAME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "JUBasicModels.h"
@interface JUSQLdb : NSObject
+(FMDatabase *)CreatDB;
+(FMDatabase *)CreatDB:(NSString *)table;

+(BOOL)createTable:(NSString *)className withKeys:(NSArray *)arrKey primaryKey:(NSString *)primaryKey;
//+(BOOL)createTable:(NSString *)className;
//删除表
+(BOOL)dropTable:(NSString *)className;

@end
//ALTER TABLE `table1` ADD `AAAA` VARCHAR( 10 ) NOT NULL ;