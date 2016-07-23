//
//  LEFMDBSql.h
//  XYLEUnit
//
//  Created by Juvid on 15/4/21.
//  Copyright (c) 2015年 XYGAME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "JUPublicSQL.h"
#import "JUBasicModels.h"
@interface JUSQLdb : FMDatabaseQueue

//+(FMDatabase *)shCreatDB;
+(FMDatabase *)shCreatDB;

/**创建表SQL*/
//+(NSString *)shCreateTableSQL:(NSString *)className withKeys:(NSArray *)arrKey primaryKey:(NSString *)primaryKey;
+(BOOL)shCreateTable:(NSString *)className withKeys:(NSArray *)arrKey primaryKey:(NSString *)primaryKey;
//+(BOOL)shCreateTable:(NSString *)className;
//删除表
+(BOOL)shDropTable:(NSString *)className;

@end
//ALTER TABLE `table1` ADD `AAAA` VARCHAR( 10 ) NOT NULL ;