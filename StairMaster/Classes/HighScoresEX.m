//
//  HighScoresEX.m
//  DancinChopstix
//
//  Created by John DiGiorgio on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "Highscores.h"
#import "GameInstructions.h"
#import "Main.h"
#import "Game.h"
#import "cocos2d.h"
#import "GameCenterManager.h"
#import <GameKit/GameKit.h>
#import "AppSpecificValues.h"
#import "GameSettings.h"
#import "GameLevel5.h"
#import "GameLevel4.h"
#import "HighScoresEX.h"
#import <OpenGLES/ES2/glext.h>

@implementation HighScoresEX

- (id) init {
  
    if(![super init]) return nil;
    
  //  [self draw];
    
//    AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
    
  //  AtlasSprite *titleMain = [AtlasSprite spriteWithRect:CGRectMake(3,264,272,42) spriteManager:spriteManager];
	//[spriteManager addChild:titleMain z:5];
//	titleMain.position = ccp(145,442);
    
    return self;
}

- (void)draw {
    //	NSLog(@"draw");
    
    //	if(currentScorePosition < 0) return;
	
//	self.position = ccp(150,200);
    glColor4ub(100,80,140,50);
    
	float w = 320.0f;
	float h = 27.0f;
	float x = (320.0f - w)/2;
	float y = 359.0f - currentScorePosition * h;
    
	GLfloat vertices[4][2];	
	GLubyte indices[4] = { 0, 1, 3, 2 };
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	
	vertices[0][0] = x;		vertices[0][1] = y;
	vertices[1][0] = x+w;	vertices[1][1] = y;
	vertices[2][0] = x+w;	vertices[2][1] = y+h;
	vertices[3][0] = x;		vertices[3][1] = y+h;
	
	//glDrawArrays(GL_TRIANGLE_STRIP, 4, GL_UNSIGNED_BYTE);
    
    glDrawElements(GL_TRIANGLE_STRIP, 4, GL_UNSIGNED_BYTE, indices);
	
	glDisableClientState(GL_VERTEX_ARRAY);	
}



@end
