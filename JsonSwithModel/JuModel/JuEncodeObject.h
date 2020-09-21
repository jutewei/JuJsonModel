//
//  JuEncodeObject.h
//  MTSkinPublic
//
//  Created by Juvid on 2020/9/21.
//  Copyright © 2020 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+JsonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JuEncodeObject : NSObject
-(void)juDestroyDealloc;//重置单例
/**复制对象内容不重新初始化*/
-(void)juMutableCopy:(id)baseClass;
@end

NS_ASSUME_NONNULL_END
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
