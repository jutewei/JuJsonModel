//
//  JuEncodeObject.m
//  MTSkinPublic
//
//  Created by Juvid on 2020/9/21.
//  Copyright © 2020 Juvid. All rights reserved.
//

#import "JuEncodeObject.h"
#import <objc/runtime.h>
@implementation JuEncodeObject
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[[[self class] alloc]init];
    if (self) {
        Class class = [self class];
        while (class!=[JuEncodeObject class]) {
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
    while (class!=[JuEncodeObject class]) {
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
        while (class!=[JuEncodeObject class]) {
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

/**复制对象内容不重新初始化*/
-(void)juMutableCopy:(id)baseClass{
    if (baseClass) {
        Class class = [baseClass class];
        while (class!=[JuEncodeObject class]) {
            unsigned int outCount, i;
            objc_property_t *properties =class_copyPropertyList([class class], &outCount);
            for (i = 0; i<outCount; i++)
            {
                objc_property_t property = properties[i];
                const char* char_f =property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                id value = [baseClass valueForKeyPath:propertyName];
                if(value!=nil&&![value isEqual:@""]){
                    [self setValue:[baseClass valueForKey:propertyName]  forKey:propertyName];
                }
            }
            free(properties);
            class = [class superclass];
        }
    }
}
-(void)juDestroyDealloc{
    Class class = [self class];
    while (class!=[JuEncodeObject class]) {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([class class], &outCount);
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
//             const char *propert_f=property_getAttributes(property);//获取属性类型;
//             NSString *propertType=[NSString stringWithUTF8String:propert_f];
            id value = [self valueForKey:propertyName];
            if (value&&![value isKindOfClass:[NSNumber class]]) {
                 [self setValue:nil forKey:propertyName];
            }else if ([value isKindOfClass:[NSNumber class]]){
                [self setValue:@(0) forKey:propertyName];
            }
            propertyName=nil;
        }
        class = [class superclass];
        free(properties);
    }

}
@end
