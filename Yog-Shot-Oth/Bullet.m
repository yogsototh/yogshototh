//
//  Bullet.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 14/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "geometry.h"
#import "Bullet.h"

@implementation Bullet

@synthesize father;

- (id)initWithStartPosition:(CGPoint)fromPosition toPosition:(CGPoint)toPosition {
    self = [super init];
    if (self) {
        speed = ccp(0,0);
        // Position randomly
        sprite.position = ccp(
                              rand() % (int)father.winSize.width,
                              100 + (rand() % ((int)father.winSize.height - 100)));
        
        [self addChild:sprite];
    }
    return self;
}

- (void)update:(ccTime)dt {
    sprite.position = ccpAdd(sprite.position, speed);
    if (outOfWindow(sprite.position, sprite.boundingBox.size, father.winSize)) {
        [self dealloc];
    }
}

@end
