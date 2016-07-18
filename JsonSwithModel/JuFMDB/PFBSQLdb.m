//
//  LEFMDBSql.m
//  XYLEUnit
//
//  Created by Juvid on 15/4/21.
//  Copyright (c) 2015年 XYGAME. All rights reserved.
//

#import "PFBSQLdb.h"
#import <objc/message.h>
#import <objc/runtime.h>
//#import "LEFilePath.h"
//#import "PFBAutoTokenModel.h"
//#define FriendsList @"Friend_List"
//#define ChatRecord  @"Chat_Record"
@implementation PFBSQLdb
+(FMDatabase *)CreatDB:(NSString *)table{
     NSString *dbPath;
//    if ([table isEqualToString:@"SHUserTable"]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        dbPath =[documentDirectory stringByAppendingPathComponent:@"PIFUBAOData.db"];
//    }else{
//        dbPath =[LEFilePath shGetFilePath:[NSString stringWithFormat:@"%@/usrdb",UserToken.sh_moblie]fileName:@"pifubao.db"];
//    }
    NSLog(@"沙盒路径%@",dbPath);
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    if (![db open]) {
        [db close];
        NSLog(@"Could not open db.");
    }
    return db;
}
+(FMDatabase *)CreatDB{
    return [self CreatDB:nil];
}
//判定是否存在表明
+(BOOL)isTableOK:(NSString *)tableName
{
    BOOL flag = NO;
    FMDatabase *db=[self CreatDB:tableName];
    if ([db open]) {
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
//         [db close];
    }
    return flag;
}

+(BOOL)createTable:(NSString *)className withKeys:(NSArray *)arrKey primaryKey:(NSString *)primaryKey{
    if ([self isTableOK:className]) {
        return YES;
    }
    BOOL flag = NO;
    FMDatabase *db=[self CreatDB:className];
    if ([db open]) {
        NSMutableArray *creatArr=[NSMutableArray array];
        for (NSString *strKey in arrKey) {
            if (primaryKey&&[strKey isEqualToString:primaryKey]) {
                 [creatArr addObject:[NSString stringWithFormat:@"%@ text PRIMARY KEY",strKey]];
            }
            else{
                [creatArr addObject:[NSString stringWithFormat:@"%@ text",strKey]];
            }
        }
        NSMutableString * creatSql =[NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ",className];
        [creatSql appendFormat:@"(%@)",[creatArr componentsJoinedByString:@","]];
        if ([db executeUpdate:creatSql]) {
            NSLog(@"创建表成功%@",creatSql);
            flag = YES;
        }else{
            NSLog(@"创建表失败%@",creatSql);
            flag = NO;
        }
//         [db close];
    }

    return flag;
}

//删除表
+(BOOL)dropTable:(NSString *)className{
    BOOL flag = YES;
    FMDatabase *db=[self CreatDB:className];
    if ([db open]) {
        NSString *stringSql=[NSString stringWithFormat:@"DROP TABLE %@",className];

        if ([db executeUpdate:stringSql]) {
            NSLog(@"删除表成功成功%@",className);
            flag = YES;
        }
        else{
            NSLog(@"删除表成功失败%@",className);
            flag = NO;
        }
        [db close];
    }
    return flag;
}


@end
