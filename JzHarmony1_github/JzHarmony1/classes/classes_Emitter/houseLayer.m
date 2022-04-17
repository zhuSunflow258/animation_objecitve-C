//
//  houseLayer.m
//  JzHarmony1
//
//  Created by ZhuZhu on 2020/06/04.
//  Copyright © 2020 Zhu Zhu. All rights reserved.
//


#import "houseLayer.h"
@interface houseLayer()
@property(nonatomic,strong)NSArray *imageNameArray;

@end

@implementation houseLayer


@synthesize imageNameArray = _imageNameArray;
@synthesize parentLayer;
@synthesize containerLayer;

- (id)initWithImageName:(NSString *)imageName{
    return [self initWithImageNameArray:[NSArray arrayWithObject:imageName]];
}

- (id)initWithImageNameArray:(NSArray *)imageNameArray{
    self = [super init];
    if (self) {
        
        self.imageNameArray =imageNameArray;
        
        [self initializeValue];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        
        NSMutableArray *snowArray = [NSMutableArray array];
        for (int i = 1; i <= 2; i++) {
            [snowArray addObject:[NSString stringWithFormat:@"House%i.png",i]];
        }
        self = [self initWithImageNameArray:snowArray];
        
        
        [self initializeValue];
    }
    return self;
}

-(void)initializeValue{
    // Configure the particle emitter to the top edge of the screen
    parentLayer = self;
    
    
    parentLayer.emitterPosition = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    
    parentLayer.emitterSize  = CGSizeMake(10, 0);
    parentLayer.emitterMode  = kCAEmitterLayerOutline;
    parentLayer.emitterShape  = kCAEmitterLayerCircle;
    parentLayer.renderMode    = kCAEmitterLayerBackToFront;
    //  parentLayer.seed = (arc4random()%100)+1;
    
    
    containerLayer = [self createSubLayerContainer];
    containerLayer.name = @"containerLayer";
    NSMutableArray *subLayerArray = [NSMutableArray array];
    NSArray *contentArray = [self getContentsByArray:self.imageNameArray];
    for (UIImage *image in contentArray) {
        [subLayerArray addObject:[self createSubLayer:image]];
    }
    
    
    
    if (containerLayer) {
        containerLayer.emitterCells = subLayerArray;
        parentLayer.emitterCells = [NSArray arrayWithObject:containerLayer];
        
    }else{
        parentLayer.emitterCells = subLayerArray;
    }
}


-(CAEmitterCell*)createSubLayerContainer{
    CAEmitterCell* containerLaye = [CAEmitterCell emitterCell];
    containerLaye.birthRate      = 0.0;
    containerLaye.velocity      = 0;
    containerLaye.lifetime      = 0.35;
    return containerLaye;
}


-(CAEmitterCell *)createSubLayer:(UIImage *)image{
    CAEmitterCell *cellLayer = [CAEmitterCell emitterCell];
    
    cellLayer.birthRate    = 3;
    cellLayer.lifetime    = 2.5;
    
    cellLayer.velocity    = 100;        // falling down slowly
    //  cellLayer.velocityRange = 20;
    cellLayer.zAcceleration = 1.0;
    cellLayer.emissionRange = 0.5 * M_PI;
    // cellLayer.emissionLongitude =-180;
    
    cellLayer.spinRange    =  M_PI;    // slow spin
    
    cellLayer.scale = 0.005;//motomoto0.04
    cellLayer.scaleSpeed =-0.20;
    //cellLayer.scaleRange = 0.1;
    cellLayer.alphaSpeed =-0.2;
    cellLayer.alphaRange =-1;
    cellLayer.contents    = (id)[image CGImage];
    
    cellLayer.color      = [[UIColor whiteColor] CGColor];
    
    return cellLayer;
}

-(NSArray *)getContentsByArray:(NSArray *)imageNameArray{
    NSMutableArray *retArray = [NSMutableArray array];
    
    for (NSString *imageName in imageNameArray) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [retArray addObject:image];
        }
    }
    
    return retArray;
}


@end
