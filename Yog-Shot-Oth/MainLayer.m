//
//  mainLayer.m
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 24/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainLayer.h"
#import "Constants.h"
#import "CCTouchDispatcher.h"
#import "Starship.h"
#import "Enemy.h"
#import "Bullet.h"

@implementation MainLayer

@synthesize winSize;
@synthesize starship;

- (id)init
{
    self = [super init];
    if (self) {
        
        winSize = [[CCDirector sharedDirector] winSize];

        // Initialize starship
        starship = [[Starship alloc] initWithWinSize:winSize];
        [self addChild:starship z:5];

        // initialize enemies
        // Load textures in cache
        enemyTexture = [[CCTextureCache sharedTextureCache] addImage:@"Panou.png"];
        enemis = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_ENEMY_NUMBER];
        Enemy *enemy;
        for (int i=0; i<INITIAL_ALLOC_ENEMY_NUMBER; i++) {
            enemy = [[Enemy alloc] initWithTexture:enemyTexture father:self];
            [enemis addObject:enemy];
            [self addChild:enemy z:0];
        }

        // alloc bullets
        // Load textures in cache
        bulletTexture = [[CCTextureCache sharedTextureCache] addImage:@"Bullet.png"];
        bullets = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_BULLET_NUMBER];

        // Alloc pause message
        pauseMessage = [[CCSprite alloc] initWithFile:@"Pause.png"];
        pauseMessage.position = ccp(winSize.width/2, winSize.height/2);
        [pauseMessage runAction:[CCFadeOut actionWithDuration: 0]];
        [self addChild:pauseMessage z:10];

        
        self.isTouchEnabled = YES;
        
        [self schedule:@selector(nextFrame:)];
    }
    
    return self;
}

-(void) addBullet:(Bullet *)bullet
{
    [bullets addObject:bullet];
}

-(void) removeBullet:(Bullet *)bullet
{
    [bullets removeObject:bullet];
    [bullet release];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if ([touches count]>1) {
        [starship touchesOccured:touches];
    }
    UITouch *touch=[touches anyObject];
    [starship touchBegan:touch];
    [pauseMessage stopAllActions];
    [pauseMessage runAction:[CCFadeOut actionWithDuration: 0]];
    [self resumeSchedulerAndActions];
}


- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    [starship touchEnded:touch];
    [pauseMessage stopAllActions];
    [pauseMessage runAction:[CCFadeIn actionWithDuration: 0.5]];
    [self pauseSchedulerAndActions];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [starship touchMoved:touch];
}

- (void) nextFrame:(ccTime)dt
{
    [starship update:dt];
    for (Enemy *enemy in enemis) {
        [enemy update:dt];
    }
    for (Bullet *bullet in bullets) {
        [bullet update:dt];
    }
}

- (void) dealloc 
{
    [starship release];
    [bullets release];
    [enemis release];
    [super dealloc];
}

@end
