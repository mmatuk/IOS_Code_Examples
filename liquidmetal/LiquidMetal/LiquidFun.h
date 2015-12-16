//
//  LiquidFun.h
//  LiquidMetal
//
//  Created by csit267-8 on 11/20/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef LiquidFun_Definitions
#define LiquidFun_Definitions

#endif

typedef struct Size2D
{
    float width;
    float height;
} Size2D;

typedef struct Vector2D
{
    float x;
    float y;
} Vector2D;

@interface LiquidFun : NSObject
+ (void)createWorldWithGravity:(Vector2D)gravity;

+ (void *)createParticleSystemWithRadius:(float)radius dampingStrength:(float)dampingStrength
                            gravityScale:(float)gravityScale density:(float)density;
+ (void)createParticleBoxForSystem:(void *)particleSystem
                          position:(Vector2D)position size:(Size2D)size;

+ (int)particleCountForSystem:(void *)particleSystem;
+ (void *)particlePositionsForSystem:(void *)particleSystem;

@end
