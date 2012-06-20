/* This is the main game controller 
 * The role of this class which should be instancied by only
 * one object is to:
 *  - Control the main loop of the game
 *  - Create/Delete sprites
 *  - Compute the eventual collisions
 *  - Keep track of all sprites
 *  - Compute the score/highscore/save it
 *
 *  This object should NEVER display stuff on the screen
 * */
#import "allSpritesImport.h"
@class YDisplayer;
@interface YGameController : NSObject {
   CGSize winSize; 
   YDisplayer displayer; // the object which display sprites on screen

   Starship *starship;
   NSMutableSet *enemis;
   NSMutableSet *bullets;
   NSMutableSet *fires;

   NSArray *spriteSets; // the order IS important

   int score;
   int highscore;
}

// Bullet handling
-(void)addBullet:(Bullet *)bullet;
-(void)removeBullet:(Bullet *)bullet; 

// Fire handling
-(void)addFire:(Fire *)fire;
-(void)removeFire:(Fire *)fire;

// Enemis handling
-(void)addEnemy:(Enemy *)enemy;
-(void)removeEnemy:(Enemy *)enemy;

// -- Game engine
-(void)populate:(int)n; // add n enemis to the battlefield
-(void)autoPopulate; // populate every 3 seconds
-(void)update:(yTime)dt; // main loop logic (collision detection, score update...)
