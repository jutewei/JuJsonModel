//
//  SHFMDBSql+Update.m
//  PFBDoctor
//
//  Created by Juvid on 16/7/9.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUSQLdb+Update.h"

@implementation JUSQLdb (Update)
+(BOOL)shUpdateTable:(JUBasicModels *)object setKeys:(id)setKeys{
    NSString *className=NSStringFromClass([object class]);
    NSDictionary *dicKeyVaule=[[object class] setModelForDictionary:object];
    return [self shUpdateTable:className withData:dicKeyVaule setKeys:setKeys];
}

+(BOOL)shUpdateTable:(NSString *)tableName withData:(NSDictionary *)dicObject setKeys:(id)setKeys{
    if ([setKeys isKindOfClass:[NSString class]]) {
        setKeys=@[setKeys];
    }
    NSMutableArray *setArr = [NSMutableArray array];
    NSMutableArray *whereArr = [NSMutableArray array];

    for (NSString *strKey in [dicObject allKeys]) {
        if ([setKeys containsObject:strKey]) {///< 设置要更新的条件
            [whereArr addObject:[NSString stringWithFormat:@" %@='%@' ",strKey,dicObject[strKey]]];
        }else{///< 设置要更新的值
            if (dicObject[strKey]&&![dicObject[strKey] isEqual:@""]) {
                [setArr addObject:[NSString stringWithFormat:@" %@='%@' ",strKey,dicObject[strKey]]];
            }
        }
    }
    return [self shUpdateTable:tableName set:[setArr componentsJoinedByString:@","] where:[whereArr componentsJoinedByString:@"AND"]];
    
}
//更新表数据
+(BOOL)shUpdateTable:(NSString *)table setKey:(NSString *)setkey setValue:(NSString *)setValue{
    return [self shUpdateTable:table set:[NSString stringWithFormat:@" %@='%@' ",setkey,setValue]];
}

+(BOOL)shUpdateTable:(NSString *)table setKey:(NSString *)setkey setValue:(NSString *)setvalue whereKey:(NSString*)wherekey whereValue:(NSString*)whereValue{
    return [self shUpdateTable:table set:[NSString stringWithFormat:@" %@='%@' ",setkey,setvalue] where:[NSString stringWithFormat:@" %@='%@' ",wherekey,whereValue]];
}

+(BOOL)shUpdateTable:(NSString *)tableName set:(NSString *)setSql{
    return [self shUpdateTable:tableName set:setSql where:nil];
}
+(BOOL)shUpdateTable:(NSString *)tableName set:(NSString *)setSql where:(NSString *)whereSql{
    NSMutableString * sqlStr= [NSMutableString string];
    if (setSql) {
        [sqlStr appendString:setSql];
    }
    if (whereSql) {
        [sqlStr appendString:@" WHERE "];
        [sqlStr appendString:whereSql];
    }
   return [self shUpdateTable:tableName withSql:sqlStr];
}
+(BOOL)shUpdateTable:(NSString *)tableName withSql:(NSString *)sqlStr{
    __block BOOL flag = NO;

    FMDatabase *db=[JUSQLdb shCreatDB];
    NSString * sql= [JUPublicSQL shUpdateSql:tableName withSql:sqlStr];
    if (![db open]) return NO;
    //返回数据库中第一条满足条件的结果
    //    FMResultSet *rs=[db executeQuery:sqlStr];
    if ([db executeUpdate:sql]) {
        NSLog(@"更新表数据成功成功%@",sql);
        flag = YES;
    }else{
        NSLog(@"更新表数据失败%@",sql);
        flag = NO;
    }
    [db close];
    return flag;
}

@end
