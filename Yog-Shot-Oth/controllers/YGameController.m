/* This is the main game controller 
 * The role of this class which should be instancied by only
 * one object is to:
 *  - Control the main loop of the game
 *  - Compute the eventual collisions
 *  - Keep track of all sprites
 *  - Create/Delete sprites
 *  - Compute the score/highscore/save it
 *
 *  This object should NEVER display stuff on the screen
 * */
#import "YGameController.h"
@implementation YGameController

-(id)init
{
    self = [super init];
    if (self) {
        // some size...
        winSize = ccp(480,960);
        
        // allocate all sprites
        starship = [[Starship alloc] init]; 

        // Initialize set used to get the list of sprite to remove each frame
        // allo NSSet which keep trac of each type of sprite
        fires   = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_BULLET_NUMBER];
        enemis  = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_ENEMY_NUMBER];
        bullets = [[NSMutableSet alloc] initWithCapacity:INITIAL_ALLOC_BULLET_NUMBER];

        // just an helper to make the code easier to read and maintain.
        // Order is important
        spriteSets = [[NSArray alloc] initWithObjects:fires, enemis, bullets, nil];

        [self autoPopulate:0];
        [self setScore:0];
    }
    return self;
}

// Bullet handling
-(void)addBullet:(Bullet *)bullet {
    [bullets addObject:bullet];
    [displayer addBullet:bullet];
}
-(void)removeBullet:(Bullet *)bullet {
    [bullets removeObject: bullet];
    [self setScore: score + [bullet damage]];
}

-(void)dealloc {
    [starship release];
    for (NSMutableSet *spriteSet in spriteSets) {
        [spriteSet release];
    }
    [spriteSets release];
}

// Fire handling
-(void)addFire:(Fire *)fire{
    [fires addObject:fire];
    [displayer addFire:fire];
}
-(void)removeFire:(Fire *)fire{
    [fires removeObject:fire];
}

// Enemis handling
-(void)addEnemy:(Enemy *)enemy {
    [enemy addObject:enemy];
    [displayer addEnemy:enemy];
}
-(void)removeEnemy:(Enemy *)enemy {
    [enemis removeObject: enemy];
}

// -- Game engine

// add n enemis to the battlefield
-(void)populate:(int)n {
    Enemy *enemy;
    for (int i=0;i<n;i++) {
        enemy = [[Panou alloc] init];
        [self addEnemy:enemy];
        [enemy autorelease];
    }
}
// populate every 3 seconds
-(void)autoPopulate {
      [self populate: (1 + self.score / 10)];
      [self performSelector:@selector(autoPopulate)
            withObject:nil
            afterDelay:3.0];
}
// main loop logic (collision detection, score update...)
-(void)update:(yTime)dt  {
    [starship update:dt];
    for (spriteSet in spriteSets) {
        for (YSprite *sprite in spriteSet) {
            [sprite update:dt];
            if (sprite.state == DESTROYED) {
                [self removeFrom:spriteSet sprite:sprite];
            }
        }
    }
}
