//
//  GLEmitter.h
//  JzHarmony1
//
//  Created by ZhuZhu on 2020/06/04.
//  Copyright © 2020 Zhu Zhu. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "jazzLayer.h"
#import "rockLayer.h"
#import "houseLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface GLEmitter : UIView

@property (nonatomic,strong) UIColor * showColor;

- (void)makeEmitter;

- (void)animationJazzWith:(CGFloat)value withRepeatTime:(int)times;
- (void)animationRockWith:(CGFloat)value withRepeatTime:(int)times;
- (void)animationHouseWith:(CGFloat)value withRepeatTime:(int)times;

- (void)animationWithStars:(CGFloat)value;

@end

NS_ASSUME_NONNULL_END

