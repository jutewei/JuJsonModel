//
//  LEBasicEncode.h
//  JsonModel
//
//  Created by Juvid on 15/6/12.
//  Copyright (c) 2015年 Juvid's. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JuBasicEncode : NSObject<NSCopying,NSCoding>
-(void)destroyDealloc;//重置单例
-(void)mutableCopy:(id)baseClass;
@end

/**
 *  @property 各种类型
 *  Td,N,V_isdouble
 *  T@"NSDate",&,N,V_isNSDate
 *  T@"NSString",&,N,V_isNSString
 *  Tc,N,V_isNextPassedBOOL
 *  Tc,N,V_isPassedBOOL
 *  Tc,N,V_ischar
 *  Tf,N,V_isCGFloat
 *  Tf,N,V_isfloat
 *  TI,N,V_isNSUInteger
 *  Ti,N,V_isNSInteger
 *  Ti,N,V_isint
 */
