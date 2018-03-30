//
//  NSArray+Safe.h
//  PFBPublic
//
//  Created by Juvid on 2018/3/22.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray<__covariant ObjectType>  (Safe)

- (ObjectType (^)(NSInteger index))juIndex;
+(NSArray *) setArray :(NSArray *) arr ;
@end
