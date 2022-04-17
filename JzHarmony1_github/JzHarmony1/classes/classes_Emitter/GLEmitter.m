//
//  GLEmitter.m
//  JzHarmony1
//
//  Created by ZhuZhu on 2020/06/04.
//  Copyright © 2020 Zhu Zhu. All rights reserved.
//

//
//  GLEmitter.m
//  JzHarmony2
//
//  Created by ZhuZhu on 2020/05/16.
//  Copyright © 2020 Zhu Zhu. All rights reserved.
//

#import "GLEmitter.h"
#import <QuartzCore/CoreAnimation.h>
@interface GLEmitter()
@property (nonatomic,strong) CAEmitterLayer *ringEmitterC;
@end

@implementation GLEmitter

jazzLayer *rootJazzLayer;
rockLayer *rootRockLayer;
houseLayer *rootFSLayer;

@synthesize ringEmitterC;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self makeEmitter];
        
        
    }
    return self;
}


- (void)makeEmitter{
    
    rootJazzLayer =[[jazzLayer alloc]init];
    
    [self.layer addSublayer:rootJazzLayer];
    
    
    rootRockLayer =[[rockLayer alloc]init];
    
    [self.layer addSublayer:rootRockLayer];
    
    rootFSLayer =[[houseLayer alloc]init];
    
    [self.layer addSublayer:rootFSLayer];
    
    
     
    // Create the emitter layer
    self.ringEmitterC = [CAEmitterLayer layer];
    
    self.ringEmitterC.emitterPosition = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    
    self.ringEmitterC.emitterSize  = CGSizeMake(10, 0);
    self.ringEmitterC.emitterMode  = kCAEmitterLayerOutline;
    self.ringEmitterC.emitterShape  = kCAEmitterLayerCircle;
    self.ringEmitterC.renderMode    = kCAEmitterLayerBackToFront;
    
    // Create the fire emitter cell
    CAEmitterCell* ring = [CAEmitterCell emitterCell];
    [ring setName:@"ring"];
    
    ring.birthRate      = 0;
    ring.velocity      =250;
    ring.zAcceleration = -1.0;
    ring.scale        = 0.01;
    ring.scaleSpeed      =-0.1;
    ring.greenSpeed      =0.9;//-0.2;  // shifting to green
    ring.redSpeed      =-0.1;//-0.5;
    ring.blueSpeed      =-0.1;//-0.5;
    ring.lifetime      = 1.2;
    
    ring.color = [[UIColor whiteColor] CGColor];
    ring.contents = (id) [[UIImage imageNamed:@"triantgle"] CGImage];
    
    
    
    CAEmitterCell* star = [CAEmitterCell emitterCell];
    [star setName:@"star"];
    
    star.birthRate    = 2;  // every triangle creates 20
    star.velocity    = 40;
    star.zAcceleration  = -1;
    star.emissionLongitude = -M_PI;  // back from triangle vector
    star.scale      = 0.2;
    star.scaleSpeed    =-0.05;
    star.greenSpeed    =-0.2;
    star.redSpeed    =-0.2;  // shifting to red
    star.blueSpeed    =0.9;
    //star.alphaSpeed    =-0.1;
    star.lifetime    = 3;
    
    star.color = [[UIColor whiteColor] CGColor];
    star.contents = (id) [[UIImage imageNamed:@"star"] CGImage];
    
    // First traigles are emitted, which then spawn circles and star along their path
    self.ringEmitterC.emitterCells = [NSArray arrayWithObject:ring];
    ring.emitterCells = [NSArray arrayWithObjects:star, nil];
    
    [self.layer addSublayer:self.ringEmitterC];
    
}

- (void)animationJazzWith:(CGFloat)value withRepeatTime:(int)times{
    
    CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.containerLayer.birthRate"];
    burst.fromValue      = [NSNumber numberWithFloat: value];
    burst.toValue      = [NSNumber numberWithFloat: 0.0];
    burst.duration      = 1;
    burst.repeatCount = times;
    burst.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [rootJazzLayer.parentLayer addAnimation:burst forKey:@"burst"];
    
    CGPoint position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    rootJazzLayer.parentLayer.emitterPosition  = position;
    [CATransaction commit];
    
    
    
}
- (void)animationRockWith:(CGFloat)value withRepeatTime:(int)times{
    
    CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.containerLayer.birthRate"];
    burst.fromValue      = [NSNumber numberWithFloat: value];
    burst.toValue      = [NSNumber numberWithFloat: 0.0];
    burst.duration      = 1;
    burst.repeatCount = times;
    burst.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [rootRockLayer.parentLayer addAnimation:burst forKey:@"burst"];
    
    
    CGPoint position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    rootRockLayer.parentLayer.emitterPosition  = position;
    [CATransaction commit];
    
    
    
}

- (void)animationHouseWith:(CGFloat)value withRepeatTime:(int)times{
    
    CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.containerLayer.birthRate"];
    burst.fromValue      = [NSNumber numberWithFloat: value];
    burst.toValue      = [NSNumber numberWithFloat: 0.0];
    burst.duration      = 1;
    burst.repeatCount = times;
    burst.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [rootFSLayer.parentLayer addAnimation:burst forKey:@"burst"];
    

    CGPoint position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    rootFSLayer.parentLayer.emitterPosition  = position;
    [CATransaction commit];
    
    
    
}
- (void)animationWithStars:(CGFloat)value{
    
    
    
    CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.ring.birthRate"];
    burst.fromValue      = [NSNumber numberWithFloat: (value-10)*3];
    burst.toValue      = [NSNumber numberWithFloat: 0.0];
    burst.duration      = 0.5;
    burst.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.ringEmitterC addAnimation:burst forKey:@"burst"];

    CGPoint position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    self.ringEmitterC.emitterPosition  = position;
    [CATransaction commit];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

