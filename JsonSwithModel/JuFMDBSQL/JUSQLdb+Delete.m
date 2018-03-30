//
//  PFBSQLdb+Delete.m
//  PFBDoctor
//
//  Created by Juvid on 16/7/11.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JUSQLdb+Delete.h"

@implementation JUSQLdb (Delete)
//删除表数据
+(BOOL)shDeteleTabData:(NSString *)className delKey:(NSString *)dKey delValue:(NSString *)dValue{
    return [self shDeleteTable:className withSql:[NSString stringWithFormat:@" %@='%@' ",dKey,dValue]];
}
+(BOOL)shDeteleTabData:(NSString *)className whereStr:(NSString *)strWhere {
    return [self shDeleteTable:className withSql:strWhere];
}
+(BOOL)shDeteleTabData:(NSString *)tableName whereDic:(NSDictionary *)whereDic{
    NSMutableArray *arrWhere=[NSMutableArray array];
    for (NSString *strKey in [whereDic allKeys]) {
        id value = [whereDic valueForKey:strKey];
        if (value&&![value isEqual:@""]) {
            [arrWhere addObject:[NSString stringWithFormat:@" %@='%@' ",strKey,value]];
        }
    }
    return [self shDeleteTable:tableName withSql:[arrWhere componentsJoinedByString:@" AND "]];
}
//删除表数据
+(BOOL)shDeteleTabData:(JuBasicModels *)object{
    NSDictionary *dicKeyVaule=[[object class] setModelForDictionary:object];
    return [self shDeteleTabData:dicKeyVaule table:NSStringFromClass([object class])];
}
+(BOOL)shDeteleTabData:(NSDictionary *)dicObject table:(NSString *)tableName{
    return [self shDeteleTabData:tableName whereDic:dicObject];
}

//+(NSString *)shDeleteSql:(NSString *)tableName withSql:(NSString *)sqlStr{
//
//    NSMutableString * sql= [NSMutableString stringWithString:[NSString stringWithFormat:@"DELETE %@ FROM %@ WHERE ",sqlStr?@"":@"*",tableName]];
//    if (sqlStr) {
//        [sql appendString:sqlStr];
//    }
//    return sql;
//}
+(BOOL)shDeleteTable:(NSString *)tableName withSql:(NSString *)sqlStr{
    __block BOOL flag = NO;
    FMDatabase *db=[self shCreatDB];
    if ([db open]) {
        NSString *sql=[JUPublicSQL shDeleteSql:tableName withSql:sqlStr];
        if ([db executeUpdate:sql]) {
            NSLog(@"删除表数据成功成功%@",sql);
            flag = YES;
        }else{
            NSLog(@"删除表数据失败%@",sql);
            flag = NO;
        }
        [db close];
    }
    return flag;
}
+(BOOL)shCleanAllData:(NSString *)tableName{
    __block BOOL flag = NO;

    FMDatabase *db=[self shCreatDB];
    if ([db open]) {
        NSString *sql=[JUPublicSQL shDeleteSql:tableName withSql:nil];
        if ([db executeUpdate:sql]) {
            NSLog(@"清空数据成功 %@",sql);
            flag = YES;
        }else{
            NSLog(@"清空数据失败 %@",sql);
            flag = NO;
        }
        [db close];
    }

    return flag;
}
@end
