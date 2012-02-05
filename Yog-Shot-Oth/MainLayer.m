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
#import "SSBullet.h"

@implementation MainLayer

@synthesize winSize;
@synthesize starship;
@synthesize enemis;

// -- specific getter and setter for score
- (int)getScore {
    return score;
}

- (void)setScore:(int)newScore {
    score = newScore;
    [self updateScoreLabel];
}



- (id)init
{
    self = [super init];
    if (self) {
        
        winSize = [[CCDirector sharedDirector] winSize];
        // winSize.height -= 80;

        // Initialize starship
        starship = [[Starship alloc] initWithWinSize:winSize];
        starship.father = self;
        [self addChild:starship z:5];

        // Initialize set used to get the list of sprite to remove each frame
        yspriteToRemove = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_ENEMY_NUMBER];

        // initialize enemies
        enemis = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_ENEMY_NUMBER];
        
        // alloc bullets
        bullets = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_BULLET_NUMBER];
        
        // alloc StarshipBullets
        ssbullets = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_BULLET_NUMBER];
        
        // Alloc pause message
        pauseMessage = [[CCSprite alloc] initWithFile:@"Pause.png"];
        pauseMessage.position = ccp(winSize.width/2, winSize.height/2);
        [pauseMessage runAction:[CCFadeOut actionWithDuration: 0]];
        [self addChild:pauseMessage z:20];
        
        scoreLabel = [CCLabelTTF labelWithString: [NSString stringWithFormat:@"%d", score]
                                 dimensions: CGSizeMake(180, 20)
                                  alignment: UITextAlignmentRight
                                   fontName: @"Helvetica"
                                   fontSize: 20];
        scoreLabel.position = ccp(winSize.width - 92,winSize.height - 12);
        [self addChild:scoreLabel z:19];
        
        lastNumber = 0;
        [self autoPopulate:0];
        
        
        [self setScore:0];
        
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
    [self setScore:score + n * 5];
}

- (int) lastNumberIteration:(int)n {
    return n + n/4 + 1;
}

- (void) autoPopulate:(ccTime)dt {
    NSLog(@"autoPopulate");
    lastNumber = (lastNumber<1)?1:[self lastNumberIteration: lastNumber ];
    [self populate:lastNumber];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:3.0], 
                 [CCCallFunc actionWithTarget:self selector:@selector(autoPopulate:)],
                 nil]];
}


-(void) updateScoreLabel
{
    [scoreLabel setString: [NSString stringWithFormat:@"%d", score]];
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
    [self setScore: score+1];
}

-(void) addSSBullet:(SSBullet *)ssbullet
{
    [ssbullets addObject:ssbullet];
    [self addChild:ssbullet z:8];
}
-(void) removeSSBullet:(SSBullet *)ssbullet
{
    [yspriteToRemove addObject:ssbullet];
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
    else {
        UITouch *touch=[touches anyObject];
        [starship touchBegan:touch];
    }
    // Uncomment to enable pause on untouch
    // [pauseMessage stopAllActions];
    // [pauseMessage runAction:[CCFadeOut actionWithDuration: 0]];
    // [self resumeSchedulerAndActions];
}


- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [starship touchesEnded:touches];
    
    // Uncomment to enable pause on untouch
    // [pauseMessage stopAllActions];
    // [pauseMessage runAction:[CCFadeIn actionWithDuration: 0.5]];
    // [self pauseSchedulerAndActions];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [starship touchesMoved:touches];
}

- (void) nextFrame:(ccTime)dt
{
    // update all objects
    // Starship
    [starship update:dt];

    // Starship bullets
    for (SSBullet *ssbullet in ssbullets) {
        [ssbullet update:dt];
    }
    [self cleanupSpriteSet:ssbullets];
    
    // Enemies
    for (Enemy *enemy in enemis) {
        [enemy update:dt];
    }
    [self cleanupSpriteSet:enemis];
    
    // Bullets
    for (Bullet *bullet in bullets) {
        [bullet update:dt];
    }
    [self cleanupSpriteSet:bullets];
    
}

- (void) dealloc 
{
    [starship release];
    [bullets release];
    [enemis release];
    [yspriteToRemove release];
    [super dealloc];
}

- (void) colisionOccured
{
    lastNumber=1;
    self.score = 0;
}

@end
