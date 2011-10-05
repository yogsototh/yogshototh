//
//  PauseLayer.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 06/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"

@implementation PauseLayer

- (id)init
{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        // Alloc pause message
        pauseMessage = [[CCSprite alloc] initWithFile:@"Pause.png"];
        pauseMessage.position = ccp(winSize.width/2, winSize.height/2);
        [pauseMessage runAction:[CCFadeOut actionWithDuration: 0]];
        [self addChild:pauseMessage];
    }    
    return self;
}

@end
