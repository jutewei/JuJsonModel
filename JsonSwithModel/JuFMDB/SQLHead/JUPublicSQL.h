//
//  PFBPublicSQL.h
//  PFBDoctor
//
//  Created by Juvid on 16/7/23.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JUPublicSQL : NSObject
/**建表语句*/
+(NSString *)shCreateTableSQL:(NSString *)className withKeys:(NSArray *)arrKey primaryKey:(NSString *)primaryKey;

/**添加表数据语句*/
+(NSString *)shInsertSql:(NSString *)tableName withSql:(NSString *)sqlStr;

/**删除表数据语句*/
+(NSString *)shDeleteSql:(NSString *)tableName withSql:(NSString *)sqlStr;

/**修改表数据语句*/
+(NSString *)shUpdateSql:(NSString *)tableName withSql:(NSString *)sqlStr;
@end
