//
//  mainLayer.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 24/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "CCLabelTTF.h"
@class Starship;
@class Bullet;
@class Enemy;
@class SSBullet;

@interface MainLayer : CCLayer {
    CGSize winSize;

    Starship *starship;
    CCSprite *pauseMessage;

    NSMutableSet *enemis;
    NSMutableSet *bullets;
    NSMutableSet *yspriteToRemove;
    NSMutableSet *ssbullets;
    
    NSArray *cachedTextures;
    int lastNumber;
    
    int score;
    int highscore;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *highscoreLabel;
}
@property (readonly) CGSize winSize;
@property (readonly) Starship *starship;
@property (readonly) NSMutableSet *enemis;
@property (readwrite,assign) int score;
@property (readwrite,assign) int highscore;

-(void) addBullet:(Bullet *)bullet;
-(void) removeBullet:(Bullet *)bullet;
-(void) addSSBullet:(SSBullet *)ssbullet;
-(void) removeSSBullet:(SSBullet *)bullet;

-(void) addEnemy:(Enemy *)enemy;
-(void) removeEnemy:(Enemy *)enemy;
-(void) populate:(int)n;
-(void) autoPopulate:(ccTime)dt;
-(void) colisionOccured;

-(void) updateScoreLabel;
-(void) updateHighscoreLabel;
@end
