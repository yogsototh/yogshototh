/* This is the main displayer
 * Given a controller it should display the game on the screen
 * Mainly, it access the lists of sprite of the controller
 * It should load the list of textures at startup
 * Also it should associate to each couple Sprite/state an animation
 * */
#import "cocos2d.h"
#import "CCLabelTTF.h"
#import "YGameController.h"

@interface YDisplayer : NSCCLayer {
   YDisplayer displayer; // the object which display sprites on screen
   NSMutableSet *sprites;
   YGameController *controller;
}
