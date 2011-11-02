//
//  Enemy.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy 

@synthesize sprite;

- (id)initWithTexture:(CCTexture2D *)texture father:(MainLayer *)parentScene {
    self = [super init];
    if (self) {
        sprite = [[CCSprite alloc] initWithTexture:texture];
        speed = ccp(0,0);
        father = parentScene;
        // Position randomly
        sprite.position = ccp(
                             rand() % (int)father.winSize.width,
                             100 + (rand() % ((int)father.winSize.height - 100)));

    }
    return self;
}

- (void)update:(ccTime)dt {
    CGPoint vectFromSpriteToStarship = ccpSub(father.starship.sprite.position, sprite.position);
    
    speed = ccpMult(ccpNormalize(vectFromSpriteToStarship),2.0);
    
    sprite.position = ccpAdd(sprite.position, speed);
        
    if (ccpLength(vectFromSpriteToStarship) < 10.0) {
        NSLog(@"Collision!");
    }
}

@end
