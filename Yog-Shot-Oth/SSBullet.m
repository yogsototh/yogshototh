//
//  Bullet.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 14/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSBullet.h"
#import "Enemy.h"
#import "geometry.h"

@implementation SSBullet

@synthesize father;

- (id)initWithStartPosition:(CGPoint)fromPosition withSpeed:(CGPoint)initSpeed andMainLayer:(MainLayer *)mainLayer {
    self = [super init];
    if (self) {
        father = mainLayer;
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"pentacleOneBullet.png"];
        sprite = [[CCSprite alloc] initWithTexture:texture];
        sprite.position = fromPosition;
        collisionDistance=sprite.boundingBoxInPixels.size.width;
        speed = initSpeed;
        [self addChild:sprite];
    }
    return self;
}

- (void)collisionOccured {
    // Make bullet destruction animation
}

- (void)cancelled {
    // Make bullet cancellation animation
}


- (void)update:(ccTime)dt {
    // update position
    sprite.position = ccpAdd(sprite.position, ccpMult(speed,dt));
    
    // detect collision
    for (Enemy *enemy in father.enemis) {
        CGPoint vectFromSpriteToEnemy = ccpSub(enemy.position, sprite.position);
        if (ccpLength(vectFromSpriteToEnemy) < collisionDistance) {
            [enemy collisionOccured];
            [self collisionOccured];
        }    
    }
    
    // detect out of windows
    sprite.position = ccpAdd(sprite.position, speed);
    if (outOfWindow(sprite.position, sprite.boundingBox.size, father.winSize)) {
        [father removeBullet:self];
    }
}

- (void) dealloc
{
    [sprite release];
    [super dealloc];
}

@end
