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
    id  master; // The master object which handle sprite events
    int life;
    int damage;
    SpriteState state;
    ccTime   lastTime;
    NSArray *animations; // An Array of array of animation frame
}
@property (assign)   SpriteState state;
@property (assign)   int life;
@property (assign)   int damage;

- (void)initialize;
- (id)initWithMaster:(id) masterObject;
- (void)update:(ccTime)dt;
- (void)collisionWith:(YSprite *)collider;
- (int)animationForState:(SpriteState)state;
@end
