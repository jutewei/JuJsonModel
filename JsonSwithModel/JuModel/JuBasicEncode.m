//
//  LEBasicEncode.m
//  JsonModel
//
//  Created by Juvid on 15/6/12.
//  Copyright (c) 2015年 Juvid's. All rights reserved.
//

#import "JuBasicEncode.h"
#import "JuBasicModels.h"
@implementation JuBasicEncode
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[[[self class] alloc]init];
    if (self) {
        Class class = [self class];
        while (class!=[JuBasicModels class]) {
            unsigned int outCount, i;
            objc_property_t *properties =class_copyPropertyList([class class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                id value = [aDecoder decodeObjectForKey: propertyName];
                if (value) {
                    [self setValue:value forKey:propertyName] ;
                }
                
            }
            free(properties);
            class = [class superclass];
        }
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    Class class = [self class];
    while (class!=[JuBasicModels class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
             id value = [self valueForKey:propertyName];
            if (value) {
                [aCoder encodeObject:value forKey:propertyName];
            }
           
        }
        free(properties);
        class = [class superclass];
    }
    
}
//拷贝对象
- (id)copyWithZone:(NSZone *)zone
{
    NSObject *copy = [[[self class] alloc] init];
    if (copy) {
        Class class = [copy class];
        while (class!=[JuBasicModels class]) {
            unsigned int outCount, i;
            objc_property_t *properties =class_copyPropertyList([class class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                id value = [self valueForKey:propertyName];
                if (value) {
                    [copy setValue:[value copyWithZone:zone] forKey:propertyName];
                }
            }
            free(properties);
            class = [class superclass];
        }
    }
    return copy;
}
-(void)mutableCopy:(id)baseClass{
    if (baseClass) {
        Class class = [baseClass class];
        while (class!=[JuBasicModels class]) {
            unsigned int outCount, i;
            objc_property_t *properties =class_copyPropertyList([class class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                if([baseClass valueForKeyPath:propertyName]!=nil&&![[baseClass valueForKeyPath:propertyName]isEqual:@""]){
                    [self setValue:[baseClass valueForKey:propertyName]  forKey:propertyName];
                }
            }
            free(properties);
            class = [class superclass];
        }
    }
    
}
-(void)destroyDealloc{
    Class class = [self class];
    while (class!=[JuBasicModels class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            id value = [self valueForKey:propertyName];
            if (value&&![value isKindOfClass:[NSNumber class]]) {
                 [self setValue:nil forKey:propertyName];
            }
    
            propertyName=nil;
        }
        class = [class superclass];
        free(properties);
    }
    
}
@end
