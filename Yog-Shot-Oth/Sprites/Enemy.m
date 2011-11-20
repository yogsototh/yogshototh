//
//  Enemy.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "Bullet.h"
#import "geometry.h"

@implementation Enemy 

@synthesize sprite;
@synthesize lastTime;

- (id)initWithParent:(MainLayer *)parentScene {
    self = [super init];
    lastTime=0.0;
    if (self) {
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"Panou.png"];
        sprite = [[CCSprite alloc] initWithTexture:texture];
        speed = ccp(0,-2.0);
        father = parentScene;
        // Position randomly
        sprite.position = ccp(
                             rand() % (int)father.winSize.width,
                             100 + (rand() % ((int)father.winSize.height - 100)));

        [self addChild:sprite];
        [self schedule:@selector(shoot:) interval:3.0];
    }
    return self;
}

- (void)shootTo:(CGPoint)position {
    Bullet *bullet = [[Bullet alloc] initWithStartPosition:sprite.position toPosition: position withSpeed:3.0 andMainLayer:father];
    [father addBullet:bullet];
}

- (void)update:(ccTime)dt {
    // detect out of windows
    sprite.position = ccpAdd(sprite.position, speed);
    
    if (outOfWindow(sprite.position, sprite.boundingBox.size, father.winSize)) {
        NSLog(@"I am out of window");
        [self dealloc];
    }
}

- (void)shoot:(ccTime)dt {
    [self shootTo:father.starship.position];
}


@end
