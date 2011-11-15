//
//  mainLayer.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 24/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
@class Starship;
@class Bullet;

@interface MainLayer : CCLayer {
    CGSize winSize;

    Starship *starship;
    CCSprite *pauseMessage;

    CCTexture2D *enemyTexture;
    NSMutableSet *enemis;
 
    CCTexture2D *bulletTexture;
    NSMutableSet *bullets;
}
@property (readonly) CGSize winSize;
@property (readonly) Starship *starship;

-(void) addBullet:(Bullet *)bullet;
@end
