//
//  rockLayer.h
//  JzHarmony1
//
//  Created by ZhuZhu on 2020/06/04.
//  Copyright © 2020 Zhu Zhu. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface rockLayer : CAEmitterLayer
@property(nonatomic,strong)CAEmitterLayer *parentLayer;
@property(nonatomic,strong)CAEmitterCell* containerLayer;

- (id)initWithImageName:(NSString *)imageName;
- (id)initWithImageNameArray:(NSArray *)imageNameArray;

-(void)initializeValue;

-(CAEmitterCell*)createSubLayerContainer;
-(CAEmitterCell *)createSubLayer:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
