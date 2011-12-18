//
//  panou.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "panou.h"

@implementation Panou

- (id)initWithParent:(MainLayer *)parentScene {
    return [super initWithParent:parentScene];
}

- (void)initialize {
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"Panou.png"];    
    sprite = [[CCSprite alloc] initWithTexture:texture];
    speed = ccp(0,-2.0);
    // Position randomly
    sprite.position = ccp(
                      rand() % (int)father.winSize.width,
                      100 + (rand() % ((int)father.winSize.height - 100)));
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0], 
                     [CCCallFunc actionWithTarget:self selector:@selector(shoot:)],
                     nil]];
}
@end
