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
    speed = ccp(0,-(0.3 + (rand() % 100)/70.0));
    // Position randomly
    sprite.position = ccp(
                      rand() % (int)father.winSize.width,
                      (int)father.winSize.height);
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0], 
                     [CCCallFunc actionWithTarget:self selector:@selector(tirRafale:)],
                     nil]];
}

- (void)tirRafale:(ccTime)dt {
    for (int i=0; i<10; i++) {
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0+(i/3.0)], 
                         [CCCallFunc actionWithTarget:self selector:@selector(shoot:)],
                         nil]];
   }
}

- (void)update:(ccTime)dt {
    
    if (!sprite) return;
    // detect out of windows
    sprite.position = ccpAdd(sprite.position, speed);
    
    if (outOfWindow(sprite.position, sprite.boundingBox.size, father.winSize)) {
        [father removeEnemy:self];
    }
}

- (CGPoint)jitter:(CGPoint)position withNoise:(int)noise {
    CGPoint result;
    result.x = position.x + rand()%noise;
    result.y = position.y + rand()%noise;
    return result;
}

- (void)shoot:(ccTime)dt {
    [self shootTo:[self jitter:father.starship.position withNoise:30] withSpeed:1.5];
}

- (void)collisionOccured {
    // Show collision animation
    // For now it disapear immediately
    [father  removeEnemy:self]; 
}

@end

