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
    CCLabelTTF *scoreLabel;
}
@property (readonly) CGSize winSize;
@property (readonly) Starship *starship;
@property (readonly) NSMutableSet *enemis;

-(void) addBullet:(Bullet *)bullet;
-(void) removeBullet:(Bullet *)bullet;

-(void) addEnemy:(Enemy *)enemy;
-(void) removeEnemy:(Enemy *)enemy;
-(void) populate:(int)n;
-(void) colisionOccured;

-(void) updateScoreLabel;
@end
