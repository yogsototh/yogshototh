//
//  Enemy.h
//  Yog-Shot-Oth
//
//  Created by Yann Esposito on 27/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Constants.h"

@interface YSprite : NSObject
{
    id  controller; // The controller object which handle sprite events
    int life;
    int damage;
    SpriteState state;
    yTime   lastTime;
    NSArray *animations; // An Array of array of animation frame
}
@property (retain)   id controller;
@property (assign)   SpriteState state;
@property (assign)   yTime lastTime;
@property (assign)   int life;
@property (assign)   int damage;

- (void)initialize;
- (id)initWithController:(id) controllerObject;
- (void)update:(yTime)dt;
- (void)collisionWith:(YSprite *)collider;
- (int)animationForState:(SpriteState)state;
@end
