//
//  PFBSQLQueuedb.m
//  PFBDoctor
//
//  Created by Juvid on 16/7/22.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUSQLQueuedb.h"
//#import "PFBAutoTokenModel.h"
@implementation JUSQLQueuedb
+ (instancetype)sharedClient {


    static JUSQLQueuedb *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        _sharedClient = [JUSQLQueuedb databaseQueueWithPath:[NSString stringWithFormat:@"%@/juvid.db",path]];

    });
    return _sharedClient;
}
//判定是否存在表明
+(BOOL)isTableOK:(NSString *)tableName
{
    __block BOOL flag = NO;
    [[JUSQLQueuedb sharedClient] inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
        while ([rs next]){
            // just print out what we've got in a number of formats.
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count){
                NSLog(@"表不存在 %@",tableName);
                flag= NO;
            }
            else{
                NSLog(@"表存在 %@",tableName);
                flag= YES;
            }
        }
    }];
    return flag;
}

+(BOOL)shCreateTable:(NSString *)className withKeys:(NSArray *)arrKey primaryKey:(NSString *)primaryKey{
    if ([self isTableOK:className]) {
        return YES;
    }
    __block BOOL flag = NO;
    [[JUSQLQueuedb sharedClient] inDatabase:^(FMDatabase *db) {
        NSString * creatSql=[JUPublicSQL shCreateTableSQL:className withKeys:arrKey primaryKey:primaryKey];
        if ([db executeUpdate:creatSql]) {
            NSLog(@"创建表成功%@",creatSql);
            flag = YES;
        }else{
            NSLog(@"创建表失败%@",creatSql);
            flag = NO;
        }
    }];
    return flag;
}
//删除表
+(BOOL)shDropTable:(NSString *)className{
    __block BOOL flag = NO;
    [[JUSQLQueuedb sharedClient] inDatabase:^(FMDatabase *db) {
        NSString *stringSql=[NSString stringWithFormat:@"DROP TABLE %@",className];
        if ([db executeUpdate:stringSql]) {
            NSLog(@"删除表成功成功%@",className);
            flag = YES;
        }
        else{
            NSLog(@"删除表成功失败%@",className);
            flag = NO;
        }
    }];
    return flag;
}
/**插入数据*/
+(BOOL)shInsertTable:(NSString *)tableName withSql:(NSString *)sqlStr{
    __block BOOL flag = NO;
    [[JUSQLQueuedb sharedClient] inDatabase:^(FMDatabase *db) {
        NSString *sql=[JUPublicSQL shInsertSql:tableName withSql:sqlStr];
        if ([db executeUpdate:sql]) {
            NSLog(@"添加数据成功成功%@",sql);
            flag=YES;
        }else{
            NSLog(@"添加数据失败%@",sql);
            flag=NO;
        }
    }];
    return flag;
}
+(BOOL)shUpdateMulitSQL:(NSArray *)arrStr rollBack:(BOOL)isRoll{
   __block  BOOL flag = NO;
    if (isRoll) {
        [[JUSQLQueuedb sharedClient] inTransaction:^(FMDatabase *db, BOOL *rollback) {
            for (NSString *string in arrStr) {
                if ([db executeUpdate:string]) {
                    NSLog(@"添加数据成功成功%@",string);
                }else{
                    NSLog(@"添加数据失败%@",string);
                }
            }
            if (rollback)  [db rollback];
            if (!rollback) [db commit];
            flag=rollback;
        }];
    }else{
        [[JUSQLQueuedb sharedClient] inDatabase:^(FMDatabase *db) {
            for (NSString *string in arrStr) {
                if ([db executeUpdate:string]) {
                    NSLog(@"添加数据成功成功%@",string);
                }else{
                    NSLog(@"添加数据失败%@",string);
                }
            }
        }];
    }
    return YES;
}
/**清空表*/
+(BOOL)shCleanAllData:(NSString *)tableName{
    __block BOOL flag = NO;
    [[JUSQLQueuedb sharedClient] inDatabase:^(FMDatabase *db) {
        NSString *sql=[JUPublicSQL shDeleteSql:tableName withSql:nil];
        if ([db executeUpdate:sql]) {
            NSLog(@"清空数据成功 %@",sql);
            flag = YES;
        }else{
            flag = NO;
            NSLog(@"清空数据失败 %@",sql);
        }
    }];
    return flag;
}
/**删除表数据*/
+(BOOL)shDeleteTable:(NSString *)tableName withSql:(NSString *)sqlStr{
    __block BOOL flag = NO;
    [[JUSQLQueuedb sharedClient] inDatabase:^(FMDatabase *db) {
        NSString *sql=[JUPublicSQL shDeleteSql:tableName withSql:sqlStr];
        if ([db executeUpdate:sql]) {
            NSLog(@"删除表数据成功成功%@",sql);
            flag = YES;
        }else{
            NSLog(@"删除表数据失败%@",sql);
            flag = NO;
        }
    }];
    return flag;
}
/**更新表数据*/
+(BOOL)shUpdateTable:(NSString *)tableName withSql:(NSString *)sqlStr{
    __block BOOL flag = NO;
    [[JUSQLQueuedb sharedClient] inDatabase:^(FMDatabase *db) {
        NSString *sql=[JUPublicSQL shUpdateSql:tableName withSql:sqlStr];
        if ([db executeUpdate:sql]) {
            NSLog(@"更新表数据成功成功%@",sql);
            flag = YES;
        }else{
            NSLog(@"更新表数据失败%@",sql);
            flag = NO;
        }
    }];
    return flag;
}
/**查找表数据*/
+(NSMutableArray *)shSelectTable:(NSString *)tableName
                         withSql:(NSString *)strSql{
    __block NSMutableArray *arrResult=[NSMutableArray array];
    [[JUSQLQueuedb sharedClient] inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            FMResultSet *rs=[db executeQuery:strSql];
            while ([rs next]) {
                NSMutableDictionary *dicResult=[NSMutableDictionary dictionaryWithDictionary:[rs resultDictionary]];
                [arrResult addObject:dicResult];
            }
        }
    }];
    return arrResult;
}

@end
