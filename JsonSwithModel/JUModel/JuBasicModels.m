//
//  BaseModel.m
//  JsonModel
//
//  Created by Juvid on 14-6-30.
//  Copyright (c) 2015年 Juvid's. All rights reserved.
//

#import "JuBasicModels.h"

@interface JuBasicModels (){
    NSArray *sh_ArrProperty;//所以属性
}

@end

@implementation JuBasicModels
+(id)juInitModel{
    id  baseModel = [[[self class] alloc]init] ;
    return baseModel;
}
//获取所以属性
+(NSArray *) getModelAllProperty{
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
+(id) setDictionaryForModel :(NSDictionary *) dic {
    return [self setDictionaryForModel:dic withObject:nil] ;
}
-(id) setDictionaryForModel :(NSDictionary *) dic{
    return [JuBasicModels setDictionaryForModel:dic withObject:self];
}
//字典转换成对象
+(id) setDictionaryForModel :(NSDictionary *) dic withObject:(id)baseModel{
    BOOL isNewObject = false;
    if (!baseModel) {
        isNewObject=YES;
        baseModel = [[[self class] alloc]init] ;
    }
    if (![dic isKindOfClass:[NSDictionary class]]) {
        if([dic isKindOfClass:[JuBasicModels class]])return dic;
        return baseModel;
    }
    Class class = [baseModel class];
    while (class!=[JuBasicModels class]) {
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
                if ([propertyName hasPrefix:Pro_Prefix]) {
                    dicKey=[propertyName substringFromIndex:Pro_Prefix.length];
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

    return baseModel ;
}
//数组转换成数组对象
+(NSArray *) setArrayForModel :(NSArray *) arr {
    if(![arr isKindOfClass:[NSArray class]])return @[];
    NSMutableArray *backArr = [[NSMutableArray alloc ]init];
    for (NSDictionary *dic in arr)
    {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSObject * baseModel = [self setDictionaryForModel:dic];
            [backArr addObject:baseModel];
        }
//        修复
        else if([dic isKindOfClass:[JuBasicModels class]]){
            [backArr addObject:dic];
        }
    }
    return backArr ;
}

/**
 *  网络获取数据数组转换
 */
+(NSArray *) setArray :(NSArray *) arr{
    if ([arr isKindOfClass:[NSArray class]]) {
        return arr;
    }else{
        return [NSArray new];
    }
}

//对象转换成字典
+(NSMutableDictionary *) setModelForDictionary :(id) baseModel {
    if (![baseModel isKindOfClass:[JuBasicModels class]]) {
        return [NSMutableDictionary dictionary];//防止死循环
    }
    NSMutableDictionary *dicModel = [NSMutableDictionary dictionary];
    Class class = [baseModel class];
    while (class!=[JuBasicModels class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList(class, &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            NSString *dicKey=[propertyName substringFromIndex:Pro_Prefix.length];
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
+(NSArray *) setModelForArray :(NSArray *) arr{
    if(![arr isKindOfClass:[NSArray class]])return nil;
    NSMutableArray *backArr = [[NSMutableArray alloc ]init];
    for (id  baseModel in arr)
    {
        NSDictionary * dic = [self setModelForDictionary:baseModel];
        [backArr addObject:dic];
    }
    return backArr ;
}
//对象转化成字符串
+(NSString *) setModelForString :(id ) baseModel{
    NSMutableString *strModel = [NSMutableString string];
    Class class = [baseModel class];
    while (class!=[JuBasicModels class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
              NSString *dicKey=[propertyName substringFromIndex:Pro_Prefix.length];
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

-(void)setModelProValue:(NSString *)key value:(NSString *)value{
   [self setValue:value forKey:key];
}
-(NSString *)getVauleForkey:(NSString *)key{
    if (!sh_ArrProperty) {
        sh_ArrProperty=[[self class] getModelAllProperty];
    }
    NSString *Property=[NSString stringWithFormat:@"%@%@",Pro_Prefix,key];
    if ([sh_ArrProperty containsObject:Property]) {
        return  [self valueForKey:Property];
    }
    
  return @"";
}


@end
