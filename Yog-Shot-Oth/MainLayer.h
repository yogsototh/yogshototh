//
//  mainLayer.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 24/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Starship.h"

@interface MainLayer : CCLayer {
    CGSize winSize;

    Starship *starship;
    CCSprite *pauseMessage;

    CCTexture2D *enemyTexture;
    NSMutableArray *enemis;
 
    CCTexture2D *bulletTexture;
    NSMutableArray *bullets;
    
    // touch related
    CGPoint initialTouch;
    CGPoint starshipPositionAtTouchBegan;
    CGPoint lastTouch;

}
-(CGFloat) restrictValue:(CGFloat)value Between:(CGFloat)minValue And:(CGFloat)maxValue;
- (void)updateEnemy:(CCSprite *)enemy by:(ccTime)dt;
@end
