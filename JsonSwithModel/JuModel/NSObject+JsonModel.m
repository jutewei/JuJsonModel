//
//  NSObject+JsonModel.m
//  MTSkinPublic
//
//  Created by Juvid on 2018/11/28.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "NSObject+JsonModel.h"
#import <objc/runtime.h>
@implementation NSObject (JsonModel)


-(void)juSetModelExtension{}

+(id)mtInitM{
    id  baseModel = [[[self class] alloc]init] ;
    return baseModel;
}
//获取所以属性
+(NSArray *) juGetModelAllProperty{
    NSMutableArray *arrProperty=[NSMutableArray array];
    id  baseModel = [[[self class] alloc]init] ;
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([baseModel class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [arrProperty addObject:propertyName];
    }
    free(properties);
    return arrProperty;
}
//字典转换成对象
+(id) juSetDictionaryForModel :(NSDictionary *) dic {
    return [self juSetDictionaryForModel:dic withObject:nil];
}
-(id) juSetDictionaryForModel :(NSDictionary *) dic{
    return [NSObject juSetDictionaryForModel:dic withObject:self];
}
//字典转换成对象
+(id) juSetDictionaryForModel :(NSDictionary *) dic withObject:(id)baseModel{
    BOOL isNewObject = false;
    if (!baseModel) {
        isNewObject=YES;
        baseModel = [[[self class] alloc]init] ;
    }
    if (![dic isKindOfClass:[NSDictionary class]]) {
        if([dic isKindOfClass:[NSObject class]])return dic;
        return baseModel;
    }
    Class class = [baseModel class];
    while (class!=[NSObject class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char *propert_f=property_getAttributes(property);//获取属性类型;
            NSString *propertType=[NSString stringWithUTF8String:propert_f];
            if (![propertType hasPrefix:@"Tc,N"]) {///< 判断不是布尔型
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                NSString *dicKey=propertyName;
                if ([propertyName hasPrefix:JU_Model_Prefix]) {
                    dicKey=[propertyName substringFromIndex:JU_Model_Prefix.length];
                }
                if (!baseModel)break;

                if ([[dic allKeys]containsObject:dicKey]) {
                    id value=[[dic objectForKey:dicKey] isEqual:[NSNull null]]?@"":[dic objectForKey:dicKey];
                    if ([propertType hasPrefix:@"T@\"NSString"]) {///< 转str
                        [baseModel setValue:[NSString stringWithFormat:@"%@",value] forKey:propertyName];
                    }else{
                        [baseModel setValue:value forKey:propertyName];
                    }
                }
                else{
                    if (isNewObject&&[propertType hasPrefix:@"T@"]) {///< 新对象赋值并且是nsobject类型
                        [baseModel setValue:@"" forKey:propertyName];
                    }
                }
            }
        }
        free(properties);
        class = [class superclass];
    }
    [baseModel juSetModelExtension];
    return baseModel ;
}
//数组转换成数组对象
+(NSArray *) juSetArrayForModel :(NSArray *) arr {
    NSMutableArray *backArr = [[NSMutableArray alloc ]init];
    if(![arr isKindOfClass:[NSArray class]])return backArr;
    for (NSDictionary *dic in arr)
    {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSObject * baseModel = [self juSetDictionaryForModel:dic];
            [backArr addObject:baseModel];
        }
//        修复
        else if([dic isKindOfClass:[NSObject class]]){
            [backArr addObject:dic];
        }
    }
    return backArr ;
}

//对象转换成字典
+(NSMutableDictionary *) juSetModelForDictionary :(id) baseModel {
    if (![baseModel isKindOfClass:[NSObject class]]) {
        return [NSMutableDictionary dictionary];//防止死循环
    }
    NSMutableDictionary *dicModel = [NSMutableDictionary dictionary];
    Class class = [self class];
    while (class!=[NSObject class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList(class, &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            NSString *dicKey=propertyName;
            if ([propertyName hasPrefix:JU_Model_Prefix]) {
                dicKey=[propertyName substringFromIndex:JU_Model_Prefix.length];
            }
            if ([baseModel valueForKeyPath:propertyName]!=nil) {
                [dicModel setObject:[baseModel valueForKeyPath:propertyName] forKey:dicKey];
            }
            else {
                [dicModel setValue:@"" forKey:dicKey];
            }

        }
         free(properties);
        class = [class superclass];
    }

    return dicModel;

}


//把模型转换回数组
+(NSArray *) juSetModelForArray :(NSArray *) arr{
    if(![arr isKindOfClass:[NSArray class]])return nil;
    NSMutableArray *backArr = [[NSMutableArray alloc ]init];
    for (id  baseModel in arr)
    {
        NSDictionary * dic = [self juSetModelForDictionary:baseModel];
        [backArr addObject:dic];
    }
    return backArr ;
}


//对象转化成字符串
+(NSString *) juSetModelForString :(id ) baseModel{
    NSMutableString *strModel = [NSMutableString string];
    Class class = [baseModel class];
    while (class!=[NSObject class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            NSString *dicKey=propertyName;
            if ([propertyName hasPrefix:JU_Model_Prefix]) {
                dicKey=[propertyName substringFromIndex:JU_Model_Prefix.length];
            }
            id value=[baseModel valueForKeyPath:propertyName];
            if(!value) value=@"";
            if (i!=0) {
                [strModel appendFormat:@","];
            }
            [strModel appendFormat:@"%@=%@",dicKey,value];
        }
        free(properties);
        class = [class superclass];
    }
    return strModel;

}

-(void)juSetModelProValue:(NSString *)key value:(NSString *)value{
   [self setValue:value forKey:key];
}

-(NSString *)getVauleForkey:(NSString *)key{
    NSArray *sh_ArrProperty=[[self class] juGetModelAllProperty];
    NSString *Property=[NSString stringWithFormat:@"%@%@",JU_Model_Prefix,key];
    if ([sh_ArrProperty containsObject:Property]) {
        return  [self valueForKey:Property];
    }

    return @"";
}
@end
