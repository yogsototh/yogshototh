//
//  Enemy.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "Bullet.h"

@implementation Enemy 

@synthesize sprite;
@synthesize lastTime;

- (id)initWithTexture:(CCTexture2D *)texture father:(MainLayer *)parentScene {
    self = [super init];
    lastTime=0.0;
    if (self) {
        sprite = [[CCSprite alloc] initWithTexture:texture];
        speed = ccp(0,0);
        father = parentScene;
        // Position randomly
        sprite.position = ccp(
                             rand() % (int)father.winSize.width,
                             100 + (rand() % ((int)father.winSize.height - 100)));

        [self addChild:sprite];
    }
    return self;
}

- (void)shootTo:(CGPoint)position {
    Bullet *bullet = [[Bullet alloc] initWithStartPosition:sprite.position toPosition: position];
    [father addBullet:bullet];
}

- (void)update:(ccTime)dt {
    CGPoint vectFromSpriteToStarship = ccpSub(father.starship.position, sprite.position);
    
    speed = ccpMult(ccpNormalize(vectFromSpriteToStarship),1.0);
    
    if (dt - lastTime > 1000) {
        [self shootTo:father.starship.position];
    }
    
    sprite.position = ccpAdd(sprite.position, speed);
        
    if (ccpLength(vectFromSpriteToStarship) < 10.0) {
        NSLog(@"Collision!");
    }
}

@end
