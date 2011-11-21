//
//  Bullet.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 14/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "geometry.h"
#import "Bullet.h"
#import "Starship.h"

@implementation Bullet

@synthesize father;

- (id)initWithStartPosition:(CGPoint)fromPosition toPosition:(CGPoint)toPosition withSpeed:(CGFloat)initSpeed andMainLayer:(MainLayer *)mainLayer {
    self = [super init];
    if (self) {
        father = mainLayer;
        // Position randomly
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"Bullet.png"];
        sprite = [[CCSprite alloc] initWithTexture:texture];
        sprite.position = fromPosition;
        CGPoint direction = ccpNormalize(ccpSub(toPosition, fromPosition));
        speed = ccpMult(direction, initSpeed);
        [self addChild:sprite];
    }
    return self;
}

- (void)update:(ccTime)dt {
    // update position
    sprite.position = ccpAdd(sprite.position, ccpMult(speed,dt));
    
    // detect collision
    CGPoint vectFromSpriteToStarship = ccpSub(father.starship.position, sprite.position);
    if (ccpLength(vectFromSpriteToStarship) < 10.0) {
        NSLog(@"Collision!");
    }    
    
    // detect out of windows
    sprite.position = ccpAdd(sprite.position, speed);
    if (outOfWindow(sprite.position, sprite.boundingBox.size, father.winSize)) {
        NSLog(@"[Bullet] I am out of window (%1.1f,%1.1f), width: %1.1f, height: %1.1f, rect=(%1.1f,%1.1f)", sprite.position.x, sprite.position.y, sprite.boundingBox.size.width, sprite.boundingBox.size.height, father.winSize.width, father.winSize.height);
        [father removeBullet:self];
    }
}

- (void) dealloc
{
    [sprite release];
    [super dealloc];
}

@end
