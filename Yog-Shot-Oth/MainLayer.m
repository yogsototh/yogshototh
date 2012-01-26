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
#import "Panou.h"
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

        // Initialize set used to get the list of sprite to remove each frame
        yspriteToRemove = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_ENEMY_NUMBER];

        // initialize enemies
        enemis = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_ENEMY_NUMBER];
        
        // alloc bullets
        bullets = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_BULLET_NUMBER];
        
        // Alloc pause message
        pauseMessage = [[CCSprite alloc] initWithFile:@"Pause.png"];
        pauseMessage.position = ccp(winSize.width/2, winSize.height/2);
        [pauseMessage runAction:[CCFadeOut actionWithDuration: 0]];
        [self addChild:pauseMessage z:10];
        
        lastNumber = 2;
        [self populate:lastNumber];
        
        self.isTouchEnabled = YES;
        
        [self schedule:@selector(nextFrame:)];
    }
    
    return self;
}

-(void) populate:(int)n
{
    Enemy *enemy;
    for (int i=0; i<n; i++) {
        enemy = [[Panou alloc] initWithParent:self];
        [self addEnemy:enemy];
        [enemy autorelease];
    }
    
   
}

// Clean up the "ysprite" inside an NSMutableSet
-(void) cleanupSpriteSet:(NSMutableSet *)spriteSet
{
    if ([yspriteToRemove count] == 0) {
        return;
    }
    for (CCNode *ysprite in yspriteToRemove) {
        [spriteSet removeObject:ysprite];
        [self removeChild:ysprite cleanup:YES];
    }
    [yspriteToRemove removeAllObjects];
    if ([spriteSet count] == 0) {
        lastNumber *= 2;
        [self populate: lastNumber];
    }
}

// Add / Remove bullet
-(void) addBullet:(Bullet *)bullet
{
    [bullets addObject:bullet];
    [self addChild:bullet z:10];
}

-(void) removeBullet:(Bullet *)bullet
{
    [yspriteToRemove addObject:bullet];
}

-(void) cleanupBullets
{
    [self cleanupSpriteSet:bullets];
}


// Add / Remove Enemy
-(void) addEnemy:(Enemy *)enemy
{
    [enemis addObject:enemy];
    [self addChild:enemy z:0];
}

-(void) removeEnemy:(Enemy *)enemy
{
    [yspriteToRemove addObject:enemy];
}

-(void) cleanupEnemis
{
    [self cleanupSpriteSet:enemis];
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
    // update all objects
    // Starship
    [starship update:dt];
    
    // Enemies
    for (Enemy *enemy in enemis) {
        [enemy update:dt];
    }
    [self cleanupEnemis];
    
    // Bullets
    for (Bullet *bullet in bullets) {
        [bullet update:dt];
    }
    [self cleanupBullets];
}

- (void) dealloc 
{
    [starship release];
    [bullets release];
    [enemis release];
    [yspriteToRemove release];
    [super dealloc];
}

@end
