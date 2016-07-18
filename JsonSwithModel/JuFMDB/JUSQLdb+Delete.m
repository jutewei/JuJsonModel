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
+(BOOL)shDeteleTabData:(id)object{
    NSDictionary *dicKeyVaule=[[object class] setModelForDictionary:object];
    return [self shDeteleTabData:NSStringFromClass([object class]) whereDic:dicKeyVaule];
}
+(BOOL)shDeleteTable:(NSString *)tableName withSql:(NSString *)sqlStr{
    FMDatabase *db=[self CreatDB:tableName];
    BOOL flag = NO;
    if ([db open]) {
        NSMutableString *sql=[NSMutableString stringWithString:[NSString stringWithFormat:@"DELETE FROM %@ WHERE ",tableName]];
        [sql appendString:sqlStr];
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
    FMDatabase *db=[self CreatDB:tableName];
    BOOL flag = NO;
    if ([db open]) {
        NSMutableString *sql=[NSMutableString stringWithString:[NSString stringWithFormat:@"DELETE * FROM %@ ",tableName]];
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
