//
//  NSArray+Safe.m
//  PFBPublic
//
//  Created by Juvid on 2018/3/22.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)
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

-(id (^)(NSInteger index))juIndex{
    return ^id (NSInteger  index){
        if (index<self.count) {
            return    [self objectAtIndex:index];
        }
        return nil;
    };
}
@end
