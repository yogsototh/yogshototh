//
//  panou.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Panou.h"
#import "Bullet.h"
#import "geometry.h"

@implementation Panou

- (id)initWithParent:(MainLayer *)parentScene {
    return [super initWithParent:parentScene];
}

- (void)initialize {
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"Panou.png"];    
    sprite = [[CCSprite alloc] initWithTexture:texture];
    speed = ccp(0,-1.0);
    // Position randomly
    sprite.position = ccp(
                      rand() % (int)father.winSize.width,
                      100 + (rand() % ((int)father.winSize.height - 100)));
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0], 
                     [CCCallFunc actionWithTarget:self selector:@selector(tirRafale:)],
                     nil]];
}

- (void)tirRafale:(ccTime)dt {
    for (int i=0; i<13; i++) {
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0+(i/10.0)], 
                         [CCCallFunc actionWithTarget:self selector:@selector(shoot:)],
                         nil]];
   }
}

- (void)update:(ccTime)dt {
    // detect out of windows
    sprite.position = ccpAdd(sprite.position, speed);
    
    if (outOfWindow(sprite.position, sprite.boundingBox.size, father.winSize)) {
        [father removeEnemy:self];
    }
}

- (void)shoot:(ccTime)dt {
    [self shootTo:father.starship.position];
}
@end
