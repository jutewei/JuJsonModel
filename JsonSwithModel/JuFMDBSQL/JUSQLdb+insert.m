//
//  SHFMDBSql+insert.m
//  PFBDoctor
//
//  Created by Juvid on 16/7/9.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUSQLdb+insert.h"

@implementation JUSQLdb (insert)
//插入表数据
/**批量插入数据使用事物*/

//插入表数据
+(BOOL)shInsertTable:(JUBasicModels *)object primary:(NSString *)priKey{
    NSString *tableName=NSStringFromClass([object class]);
    id dicKeyVaule=[[object class] setModelForDictionary:object];
    return [self shInsertTable:tableName withData:dicKeyVaule primary:priKey];
}
+(NSDictionary *)shSwitchDic:(id)object{
    if ([object isKindOfClass:[NSDictionary class]]) {
        return object;
    }else if([object isKindOfClass:[NSArray class]]&&[object count]>0){
        return [self shSwitchDic:object[0]];
    }else if([object isKindOfClass:[JUBasicModels class]]){
        return [[object class] setModelForDictionary:object];
    }
    return @{};
}
/**拼接插入语句*/
+(NSString *)shSwitchObject:(id)object{
    NSDictionary *dicObject=[self shSwitchDic:object];
    //    if ([object isKindOfClass:[NSDictionary class]]) {
    //        dicObject=object;
    //    }else if([object isKindOfClass:[JUBasicModels class]]){
    //        dicObject=[[object class] setModelForDictionary:object];
    //    }
    NSMutableArray * keyArr = [NSMutableArray array];
    NSMutableArray * valueArr = [NSMutableArray array];
    for (NSString *strKey in [dicObject allKeys]) {
        [keyArr addObject:strKey];
        [valueArr addObject:[NSString stringWithFormat:@"'%@'",dicObject[strKey]]];
    }
    return  [NSString stringWithFormat:@" (%@) VALUES (%@)",[keyArr componentsJoinedByString:@","] ,[valueArr componentsJoinedByString:@","]];
}
/**插入多条或者单条数据*/
+(BOOL)shInsertTable:(NSString *)tableName withData:(id)object primary:(NSString *)priKey{
    NSDictionary *dicObject=[self shSwitchDic:object];
    if ([self shCreateTable:tableName withKeys:[dicObject allKeys]  primaryKey:priKey]) {///< 建表成功后写数据
        if ([object isKindOfClass:[NSDictionary class]]) {
            return [self shInsertTable:tableName withSql:[self shSwitchObject:object]];
        }else if([object isKindOfClass:[NSArray class]]){
            NSMutableArray *arrSql=[NSMutableArray array];
            for (id dicData in object) {
                [arrSql addObject:[JUPublicSQL shInsertSql:tableName withSql:[self shSwitchObject:dicData]]];
            }
            return [self shUpdateMulitSQL:arrSql rollBack:NO];
        }
    }
    return NO;
}

+(BOOL)shInsertTable:(NSString *)tableName setKey:(NSString *)setKey setValue:(NSString *)setValue{
    return [self shInsertTable:tableName withSql:[NSString stringWithFormat:@" (%@) VALUES (%@)",setKey,setValue]];
}
/**多条数据**/
+(BOOL)shUpdateMulitSQL:(NSArray *)arrStr rollBack:(BOOL)isRoll{
    FMDatabase *db=[JUSQLdb shCreatDB];
    [db open];
    BOOL isRollBack = NO;
    if (isRoll) {
        [db beginTransaction];
        @try {
            for (NSString *string in arrStr) {
                if ([db executeUpdate:string]) {
                    NSLog(@"添加数据成功成功%@",string);
                }else{
                    NSLog(@"添加数据失败%@",string);
                }
            }
        } @catch (NSException *exception) {
            isRollBack = YES;
            [db rollback];
        } @finally {
            if (!isRollBack) {
                [db commit];
            }
        }
    }
    else{
        for (NSString *string in arrStr) {
            if ([db executeUpdate:string]) {
                NSLog(@"添加数据成功成功%@",string);
            }else{
                NSLog(@"添加数据失败%@",string);
            }
        }
    }
    
    [db close];
    return !isRollBack;
}
/**单条数据*/
+(BOOL)shInsertTable:(NSString *)tableName withSql:(NSString *)sqlStr{
    BOOL flag = NO;
    FMDatabase *db=[JUSQLdb shCreatDB];
    NSString * sql=[JUPublicSQL shInsertSql:tableName withSql:sqlStr];
    if (![db open]) return NO;
    if ([db executeUpdate:sql]) {
        NSLog(@"添加数据成功成功%@",sql);
        flag = YES;
    }else{
        NSLog(@"添加数据失败%@",sql);
        flag = NO;
    }
    [db close];
    return flag;
}

/*
+(BOOL)shInsertMultTable:(id)objects primary:(NSString *)priKey{
    FMDatabase *db=[PFBSQLdb shCreatDB];
    [db open];
    BOOL isRollBack = NO;
    [db beginTransaction];
    @try {
        for (id dbTable in objects) {
            NSString *tableName=NSStringFromClass([dbTable class]);
            NSDictionary *dicKeyVaule=[[dbTable class] setModelForDictionary:dbTable];
            if ([self shCreateTable:tableName withKeys:[dicKeyVaule allKeys]  primaryKey:priKey]) {
                NSMutableArray * keyArr = [NSMutableArray array];
                NSMutableArray * valueArr = [NSMutableArray array];
                for (NSString *strKey in [dicKeyVaule allKeys]) {
                    [keyArr addObject:strKey];
                    [valueArr addObject:[NSString stringWithFormat:@"'%@'",dicKeyVaule[strKey]]];
                }
                NSMutableString * sql= [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"INSERT INTO %@",tableName]];
                [sql appendString:[NSString stringWithFormat:@" (%@) VALUES (%@)",[keyArr componentsJoinedByString:@","],[valueArr componentsJoinedByString:@","]]];
                BOOL a = [db executeUpdate:sql];
                if (!a) {
                    NSLog(@"插入失败1");
                }
            }
        }
    } @catch (NSException *exception) {
        isRollBack = YES;
        [db rollback];
    } @finally {
        if (!isRollBack) {
            [db commit];
        }
    }
    [db close];
    return !isRollBack;
}*/
@end
