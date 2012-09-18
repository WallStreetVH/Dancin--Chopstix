#import "GameLevel2.h"
#import "Main.h"
#import "Highscores.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Scene.h"
#import "GameCenterManager.h"
#import "Game.h"
#import "GameLevel4.h"
#import "GameLevel3.h"
#import "GameLevel5.h"
#import "AppDelegate.h"
//#import "AccelerometerSimulation.h"


@interface GameLevel5 (Private)
- (void)initPlatforms;
- (void)initPlatform;
- (void)startGame;
- (void)resetPlatforms;
- (void)resetPlatform;
- (void)resetBird;
- (void)resetBonus;
- (void)step:(ccTime)dt;
- (void)jump;
- (void)jumpBurst;
- (void)dropBomb;
- (void)dropBomb2;
- (void)dropBomb3;
- (void)dropBomb4;
- (void)dropBomb5;
- (void)dropMoney1;
- (void)dropMoney2;
- (void)explode; 
- (void) endOfLevel;
- (void)showHighscores;
- (void)showHighscores2;
- (void)resetMoney;
- (void)resetBombs;
- (void)cashMoney;
- (void)cashMoney2;
- (void)angelTimeGrabbed;
- (void)resetAngelTime;
- (void)resetBullets;
- (void) shot;
- (NSString *)getModel;
@end

extern int vert;
extern int tempx, tempy;
extern NSTimer *when;

int bomb_y;
int bomb2_y;
int bomb3_y;
int bomb4_y;
int bomb5_y;
int bomb_x;
int bomb2_x;
int bomb3_x;
int bomb4_x;
int bomb5_x;
int money1_x;
int money2_x;
int money_y;
int money2_y;
int angelTime_y;
int angelTime_x;
int bullet1_x;
int bullet1_y;
int bullet2_x;
int bullet2_y;
extern int touches;
extern int level;
extern NSString *sound;
extern NSString *music;
extern NSString *endOfLevel;
extern int lives;
int toc; 
int toc2;// time of cashGrab
int tob; // time of jumpBurst
int lastscore;
int diff;
//Scene *scene;
NSString *bombExp;
NSString *cashed;
NSString *flip;
BOOL gameSuspended;
NSString *bombExp;
NSString *cashed;
NSString *angel;
NSString *shot;
NSString *shot2;


@implementation GameLevel5

@synthesize TheAudio5, TheAudio2, TheAudio3, TheAudio4, playButton, pauseButton, powerButton, starburst, level2Button, bomb,bomb2,bomb3,bomb4,bomb5,Timer, gameCenterManager,dude3, explosion, money,money1, money2, money3, cashAudio, cashAudio2, bombAudio, gruntAudio2, hundred, burst, screamAudio, thrustAudio, beepAudio, beeps, splash, angelTime, bullet1, bullet2, blood;

- (id)initWithScore:(int)lastScore  {
    //	NSLog(@"Game::init");
    
    score = score + lastScore;
    
    currentScore = lastScore;
    
    if(![super init]) return nil;
    
    
    endOfLevel = @"OFF";
	
	gameSuspended = NO;
    
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
    AtlasSpriteManager *spriteManager2 = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager2];
    
	[self initPlatforms];
    
    AtlasSprite *stairs1 = [AtlasSprite spriteWithRect:CGRectMake(115,96,104,70) spriteManager:spriteManager2];
    
	stairs1.position = ccp(150,195);
    AtlasSprite *dude2 = [AtlasSprite spriteWithRect:CGRectMake(93,16,35,65) spriteManager:spriteManager2];

       
    switch(arc4random()%7) {
            
        case 0: dude3 = [AtlasSprite spriteWithRect:CGRectMake(577,3,55,65) spriteManager:spriteManager2];break;
        case 1: dude3 = [AtlasSprite spriteWithRect:CGRectMake(435,3,45,79) spriteManager:spriteManager2];break;
        case 2: dude3 = [AtlasSprite spriteWithRect:CGRectMake(480,4,55,55) spriteManager:spriteManager2];break;
        case 3: dude3 = [AtlasSprite spriteWithRect:CGRectMake(636,4,55,55) spriteManager:spriteManager2];break;
        case 4: dude3 = [AtlasSprite spriteWithRect:CGRectMake(56,1,57,55) spriteManager:spriteManager2];break;
        case 5: dude3 = [AtlasSprite spriteWithRect:CGRectMake(105,3,42,74) spriteManager:spriteManager2];break;
        case 6: dude3 = [AtlasSprite spriteWithRect:CGRectMake(160,4,58,70) spriteManager:spriteManager2];break;    
            
	}
    
    [spriteManager2 addChild:dude3 z:4 tag:kDude4];

    if ([flip isEqualToString:@"TL"]) {
        powerButton = [AtlasSprite spriteWithRect:CGRectMake(0,112,72,72) spriteManager:spriteManager2];
        powerButton.position = ccp(27,434);
        [spriteManager2 addChild:powerButton z:4 tag:kPower];
        
        pauseButton = [AtlasSprite spriteWithRect:CGRectMake(12,198,47,47) spriteManager:spriteManager2];
        pauseButton.position = ccp(288,442);
        [spriteManager2 addChild:pauseButton z:4 tag:kPause];
        
    }else if ([flip isEqualToString:@"TR"]){
        
        powerButton = [AtlasSprite spriteWithRect:CGRectMake(0,112,72,72) spriteManager:spriteManager2];
        powerButton.position = ccp(282,434);
        [spriteManager2 addChild:powerButton z:4 tag:kPower];
        
        pauseButton = [AtlasSprite spriteWithRect:CGRectMake(12,198,47,47) spriteManager:spriteManager2];
        pauseButton.position = ccp(27,442);
        [spriteManager2 addChild:pauseButton z:4 tag:kPause];
    }else if ([flip isEqualToString:@"BL"]){
        
        powerButton = [AtlasSprite spriteWithRect:CGRectMake(0,112,72,72) spriteManager:spriteManager2];
        powerButton.position = ccp(27,105);
        [spriteManager2 addChild:powerButton z:4 tag:kPower];
        
        pauseButton = [AtlasSprite spriteWithRect:CGRectMake(12,198,47,47) spriteManager:spriteManager2];
        pauseButton.position = ccp(288,100);
        [spriteManager2 addChild:pauseButton z:4 tag:kPause];
        
    }else if ([flip isEqualToString:@"BR"]){
        
        powerButton = [AtlasSprite spriteWithRect:CGRectMake(0,112,72,72) spriteManager:spriteManager2];
        powerButton.position = ccp(282,105);
        [spriteManager2 addChild:powerButton z:4 tag:kPower];
        
        pauseButton = [AtlasSprite spriteWithRect:CGRectMake(12,198,47,47) spriteManager:spriteManager2];
        pauseButton.position = ccp(27,100);
        [spriteManager2 addChild:pauseButton z:4 tag:kPause];
        
    }
    
    
    playButton = [AtlasSprite spriteWithRect:CGRectMake(394,0,45,50) spriteManager:spriteManager2];
    [spriteManager2 addChild:playButton z:4 tag:kPlay];
    [playButton setVisible:NO];

    burst = [AtlasSprite spriteWithRect:CGRectMake(141,174,68,40) spriteManager:spriteManager2];
    burst.position = ccp(155,60);
    burst.visible = NO;
    [spriteManager2 addChild:burst z:4 tag:kStarburst];

   
    hundred = [AtlasSprite spriteWithRect:CGRectMake(70,178,68,40) spriteManager:spriteManager2];
    hundred.position = ccp(155,60);
    hundred.visible = NO;
    [spriteManager2 addChild:hundred z:4 tag:kStarburst];

    
    level2Button = [AtlasSprite spriteWithRect:CGRectMake(306,221,210,40) spriteManager:spriteManager2];
    [spriteManager2 addChild:level2Button z:4 tag:kPlay];
    level2Button.position = ccp(175, 400);
   [level2Button setVisible:NO];

     hundred = [AtlasSprite spriteWithRect:CGRectMake(64,130,68,40) spriteManager:spriteManager2];
    hundred.position = ccp(155,60);
    hundred.visible = NO;
    [spriteManager2 addChild:hundred z:4 tag:kStarburst];
    
    
    burst = [AtlasSprite spriteWithRect:CGRectMake(141,174,68,40) spriteManager:spriteManager2];
    burst.position = ccp(165,60);
    burst.visible = NO;
    [spriteManager2 addChild:burst z:4 tag:kStarburst];
    
    starburst = [AtlasSprite spriteWithRect:CGRectMake(327,31,30,30) spriteManager:spriteManager2];
    starburst.position = ccp(-10,-50);
    [spriteManager2 addChild:starburst z:4 tag:kStarburst];
    
    // show the explosion 
    explosion = [AtlasSprite spriteWithRect:CGRectMake(3,3,40,40) spriteManager:spriteManager2];
    [explosion setPosition:ccp(-10,-10)];
    [spriteManager2 addChild:explosion z:4 tag:kExplosion];
    
    // show the splash 
    splash = [AtlasSprite spriteWithRect:CGRectMake(202,180,90,50) spriteManager:spriteManager2];
    [splash setPosition:ccp(-10,-50)];
    [spriteManager2 addChild:splash z:4 tag:kSplash];
    

    int lowerBound = 75;
    int upperBound = 285;
    
    timer = 30.00;
    touches = 0;
    bird_pos.x = 150;
    bird_pos.y = 440;
    bomb_y = 1100;
    bomb2_y = 1150;
    bomb3_y = 1200;
    bomb4_y = 1250;
    bomb5_y = 1300;
    vert = 400;
    bird_pos.y = 400;
    bombExp = @"OFF";
    
    bomb = [AtlasSprite spriteWithRect:CGRectMake(368,29,25,46) spriteManager:spriteManager2];
    bomb.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1100);
    bomb_x = bomb.position.x;
    [spriteManager2 addChild:bomb z:4 tag:kBomb];
    
    bomb2 = [AtlasSprite spriteWithRect:CGRectMake(368,29,25,46) spriteManager:spriteManager2];
    bomb2.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1150);
    bomb2_x = bomb2.position.x;
    [spriteManager2 addChild:bomb2 z:4 tag:kBomb2];
    
    bomb3 = [AtlasSprite spriteWithRect:CGRectMake(368,29,25,46) spriteManager:spriteManager2];
    bomb3.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1200);
    bomb3_x = bomb3.position.x;
    [spriteManager2 addChild:bomb3 z:4 tag:kBomb3];
    
    bomb4 = [AtlasSprite spriteWithRect:CGRectMake(368,29,25,46) spriteManager:spriteManager2];
    bomb4.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1250);
    bomb4_x = bomb4.position.x;
    [spriteManager2 addChild:bomb4 z:4 tag:kBomb4];
    
    bomb5 = [AtlasSprite spriteWithRect:CGRectMake(368,29,25,46) spriteManager:spriteManager2];
    bomb5.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1300);
    bomb5_x = bomb5.position.x;
    [spriteManager2 addChild:bomb5 z:4 tag:kBomb5];
    
    money1 = [AtlasSprite spriteWithRect:CGRectMake(0,60,40,45) spriteManager:spriteManager2];
    money1.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1150);
    money1_x = money1.position.x;
    [spriteManager2 addChild:money1 z:4 tag:kMoney1];
    
    money2 = [AtlasSprite spriteWithRect:CGRectMake(52,70,40,45) spriteManager:spriteManager2];
    money2.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1200);
    money2_x = money2.position.x;
    [spriteManager2 addChild:money2 z:4 tag:kMoney2];
    
    angelTime = [AtlasSprite spriteWithRect:CGRectMake(633,195,50,50) spriteManager:spriteManager2];
    angelTime.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),510);
    angelTime_x = angelTime.position.x;
    [spriteManager2 addChild:angelTime z:4 tag:kAngelTime];
    
    bullet1 = [AtlasSprite spriteWithRect:CGRectMake(634,244,55,30) spriteManager:spriteManager2]; 
    bullet1.position=ccp(-15,-15);
    [spriteManager2 addChild:bullet1 z:4 tag:kBullet1];
    
    bullet2 = [AtlasSprite spriteWithRect:CGRectMake(634,276,55,30) spriteManager:spriteManager2]; 
    bullet2.position=ccp(-15,-15);
    bullet2.scale = -1;
    [spriteManager2 addChild:bullet2 z:4 tag:kBullet2];
    
    blood = [AtlasSprite spriteWithRect:CGRectMake(547,238,59,55) spriteManager:spriteManager2]; 
    blood.position=ccp(-15,-15);
    [spriteManager2 addChild:blood z:4 tag:kBlood];

    
    AtlasSprite *lives = [AtlasSprite spriteWithRect:CGRectMake(112,88,46,20) spriteManager:spriteManager2];
    lives.position = ccp(33,60); 
    lives.scale = 2;
    [spriteManager2 addChild:lives z:4 tag:kStarburst];
    
    

    
    int t;
    
    // float delta = bird_pos.y -2;
    float delta = 25;
    t = kPlatformsStartTag;
    
    
    for(t; t < kPlatformsStartTag + kNumPlatforms2; t++) {
        AtlasSprite *platform = (AtlasSprite*)[spriteManager getChildByTag:t];
        //  platform.position = ccp(100,vert);
        CGPoint pos = platform.position;
        pos = ccp(pos.x,pos.y - delta);
        //  if(pos.y < -platform.contentSize.height/2) {
        //     currentPlatformTag = t;
        //      [self resetPlatform];
        //  } else {
        platform.position = pos;
        //   [self addChild:platform z:5 tag:t];
        bird_pos.y = pos.y;
        delta = delta + 25;
        // }
    }
    
    
	AtlasSprite *bonus;
    
	for(int i=0; i<kNumBonuses; i++) {
		bonus = [AtlasSprite spriteWithRect:CGRectMake(608+i*32,256,25,25) spriteManager:spriteManager];
		[spriteManager addChild:bonus z:4 tag:kBonusStartTag+i];
		bonus.visible = NO;
	}
    
    
    scoreLabel = [[LabelAtlas  labelAtlasWithString:@"TOTAL SCORE:0" charMapFile:@"casualLetters.png" itemWidth:16 itemHeight:24 startCharMap:'.'] retain];
    [self addChild:scoreLabel z:5];
    [scoreLabel setPosition:ccp(55, 5)];
    
    timeLabel = [[LabelAtlas labelAtlasWithString:@"" charMapFile:@"casualLetters.png" itemWidth:16 itemHeight:24 startCharMap:'.'] retain];
    [self addChild:timeLabel z:5];
    [timeLabel setPosition:ccp(105,430)];
    
    livesLabel = [[LabelAtlas labelAtlasWithString:@"" charMapFile:@"casualLetters.png" itemWidth:16 itemHeight:24 startCharMap:'.'] retain];
    [self addChild:livesLabel z:5];
    livesLabel.scale = 2;
    [livesLabel setPosition:ccp(69,34)];
    
    flashScoreLabel = [[LabelAtlas labelAtlasWithString:@"  CURRENT:0" charMapFile:@"casualLetters.png" itemWidth:16 itemHeight:24 startCharMap:'.'] retain];
    [self addChild:flashScoreLabel z:5];
    [flashScoreLabel setPosition:ccp(85,25)];
    
    touchLabel = [[LabelAtlas labelAtlasWithString:@"0" charMapFile:@"casualLetters.png" itemWidth:16 itemHeight:24 startCharMap:'.'] retain];
    [self addChild:touchLabel z:5];
    if ([flip isEqualToString:@"TL"]){
        touchLabel.position = ccp(20,385);
    }else if ([flip isEqualToString:@"TR"]){
        touchLabel.position = ccp(275,385);
    }else if ([flip isEqualToString:@"BL"]){
        touchLabel.position = ccp(21,124);
    }
    
    
    updateLabel = [[LabelAtlas labelAtlasWithString:@"" charMapFile:@"casualLetters.png" itemWidth:16 itemHeight:24 startCharMap:'.'] retain];
    [self addChild:updateLabel z:5];
    [updateLabel setPosition:ccp(25,80)];
    

	
	isTouchEnabled = YES;
	isAccelerometerEnabled = YES;
    
    [self schedule:@selector(step:)];
    
        
    [[TouchDispatcher sharedDispatcher] addEventHandler:self priority:0 swallowTouches:YES];
    
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kFPS)];
	
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb2) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb3) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb4) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb5) object:nil];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropMoney1) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropMoney2) object:nil];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropAngelTime) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBullet1) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBullet2) object:nil];

   
    [self startGame];
    
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [app.level2Audio play];
                                        
    toc = timer;
    updateLabel.visible = YES;
    [updateLabel setString:@"      LEVEL 2"];
    [updateLabel draw];  
    
    delay1 = arc4random() % 10;
    delay2 = arc4random() % 20;
    delay3 = arc4random() % 10;
    delay4 = arc4random() % 20;
    delay5 = arc4random() % 8;
    delay6 = arc4random() % 20;
    delay7 = arc4random() % 30;
	
	return self;
}

- (void)dealloc {
    //	NSLog(@"Game::dealloc");
	[super dealloc];
    
    [cashAudio release];
    [cashAudio2 release];
    [bombAudio release];
    [gruntAudio release];
   // [jumpAudio release];
    [TheAudio5 release];
    [TheAudio2 release];
    [TheAudio3 release]; 
    [dude3 release];
    [bomb release];
    [bomb2 release];
    [bomb3 release];
    [bomb4 release];
    [bomb5 release];
    [pauseButton release];
    [playButton release];
    [powerButton release];
    [explosion release];
    [starburst release];
    [burst release];
    [splash release];
    [hundred release];
    [angelTime release];
    [screamAudio release];
    [thrustAudio release];
    //  [thrustAudio2 release];
    [beeps release];
    [beepAudio release];
    //  [jumpAudio release];
    //  [appPlayer release];
    [bullet1 release];
    [bullet2 release];
    [money release];
    [money2 release];
}

- (void)initPlatforms {
    //	NSLog(@"initPlatforms");
	
	currentPlatformTag = kPlatformsStartTag;
	while(currentPlatformTag < kPlatformsStartTag + kNumPlatforms2) {
		[self initPlatform];
		currentPlatformTag++;
	}
	
	[self resetPlatforms];
}

- (void)initPlatform {
    
	CGRect rect;
	switch(arc4random()%4) {
            
        case 0: rect = CGRectMake(257,77,92,100);break;
        case 1: rect = CGRectMake(352,77,92,100);break;
        case 2: rect = CGRectMake(451,77,92,100);break;
        case 3: rect = CGRectMake(545,77,92,100);break;
            
	}
    
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	AtlasSprite *platform = [AtlasSprite spriteWithRect:rect spriteManager:spriteManager];
	[spriteManager addChild:platform z:3 tag:currentPlatformTag];
}

- (void)startGame {
    //	NSLog(@"startGame");
    
	//score = 0;
	
//	[self resetClouds];
	[self resetPlatforms];
	[self resetBird];
//	[self resetBonus];
    [self resetMoney];
    [self resetBombs];
    [self resetAngelTime];
    [self resetBullets];
    
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([music isEqualToString:@"ON"]) {
        
        switch(arc4random()%3) {
                
            case 0: [app.gameLoop play]; break;
            case 1: [app.gameLoop2 play];break;
            case 2: [app.gameLoop3 play];break;
        }
        
    }else{
        
        [app.gameLoop stop];
        [app.gameLoop2 stop];
        [app.gameLoop3 stop];
    }

    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
	gameSuspended = NO;
    
    isTouchEnabled = YES;
    
    [[TouchDispatcher sharedDispatcher] addEventHandler:self priority:0 swallowTouches:YES];
    
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kFPS)];
}

- (void)resetPlatforms {
    //	NSLog(@"resetPlatforms");
	
	currentPlatformY = 420;
	currentPlatformTag = kPlatformsStartTag;
	currentMaxPlatformStep = 60.0f;
	currentBonusPlatformIndex = 0;
	currentBonusType = 0;
	platformCount = 0;
    
	while(currentPlatformTag < kPlatformsStartTag + kNumPlatforms2) {
		[self resetPlatform];
		currentPlatformTag++;
	}
    
}

- (void)resetPlatform {
	
	if(currentPlatformY < 0) {
		currentPlatformY = 420.0f;
	} else {
		currentPlatformY += arc4random() % (int)(currentMaxPlatformStep - kMinPlatformStep) + kMinPlatformStep;
		if(currentMaxPlatformStep < kMaxPlatformStep) {
			currentMaxPlatformStep += 0.5f;
		}
	}
	
    currentPlatformY = 230.f;
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	AtlasSprite *platform = (AtlasSprite*)[spriteManager getChildByTag:currentPlatformTag];
    
   	if(arc4random()%2==1) platform.scaleX = -1.0f;
	
	float x;
	CGSize size = platform.contentSize;
	if(currentPlatformY == 30.0f) {
		x = 160.0f;
        //  currentPlatformY = 420;
	} else {
		x = arc4random() % (320-(int)size.width) + size.width/2;
	}
	
	platform.position = ccp(x,currentPlatformY);
	platformCount++;
  }

- (void)resetBird {
    //	NSLog(@"resetBird");
    
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
    AtlasSpriteManager *spriteManager2 = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager2];
	AtlasSprite *bird = (AtlasSprite*)[spriteManager getChildByTag:kBird];
    AtlasSprite *dude3 = (AtlasSprite*)[spriteManager2 getChildByTag:kDude4];
	
	bird_pos.x = 160;
	bird_pos.y = 460;
	bird.position = bird_pos;
    dude3.position = bird_pos;
    	
	bird_vel.x = 0;
	bird_vel.y = 0;
	
	bird_acc.x = 0;
	bird_acc.y = -550.0f;
	
	birdLookingRight = YES;

}

- (void)resetBonus {
    //	NSLog(@"resetBonus");
	
}

- (void) resetMoney {
    
    money_y = 1050;
    money2_y = 1100;
}

- (void) resetAngelTime {
    
    angelTime_y = 1750;
    
}

- (void) resetBombs {
    bomb_y = 1100;
    bomb2_y = 1150;
    bomb3_y = 1200;
}
- (void) resetBullets {
    bullet1_x = 360;
    bullet2_x = -30;
    //  bullet1_y = arc4random() % 480;
}


- (void)step:(ccTime)dt {
    //	NSLog(@"Game::step");
    
	[super step:dt];
    
    if (timer < 0)
        endOfLevel = @"ON";
	
	if(gameSuspended) return;
    
  /*  AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([music isEqualToString:@"ON"])
        [app.gameLoop play]; 
    else
        [app.gameLoop stop]; 
   */   
        
   /* [self performSelector:@selector(dropBomb) withObject:nil afterDelay:2];
    [self performSelector:@selector(dropBomb2) withObject:nil afterDelay:4];
    [self performSelector:@selector(dropBomb3) withObject:nil afterDelay:5];
    [self performSelector:@selector(dropBomb4) withObject:nil afterDelay:8];
    
    [self performSelector:@selector(dropMoney1) withObject:nil afterDelay:3];
    [self performSelector:@selector(dropMoney2) withObject:nil afterDelay:6];
    
    [self performSelector:@selector(dropAngelTime) withObject:nil afterDelay:5];*/
    
    // Set timers to fire events
    // Bombs
    [self performSelector:@selector(dropBomb) withObject:nil afterDelay:delay1];
    [self performSelector:@selector(dropBomb2) withObject:nil afterDelay:delay2];
    [self performSelector:@selector(dropBomb3) withObject:nil afterDelay:delay5];
    
    // Bullet
    [self performSelector:@selector(dropBullet2) withObject:nil afterDelay:10];
    
    // Money Bags
    [self performSelector:@selector(dropMoney1) withObject:nil afterDelay:delay3];
    [self performSelector:@selector(dropMoney2) withObject:nil afterDelay:delay4];
    
    // Angel Time
    [self performSelector:@selector(dropAngelTime) withObject:nil afterDelay:4];
    
    
    //   [self performSelector:@selector(dropBullet2) withObject:nil afterDelay:20];
    
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	AtlasSprite *bird = (AtlasSprite*)[spriteManager getChildByTag:kBird];
    
    AtlasSpriteManager *spriteManager2 = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager2];
    dude3 = (AtlasSprite*)[spriteManager2 getChildByTag:kDude4];
	
	bird_pos.x += bird_vel.x * dt;
    
	// Velocity determines which way sprite is facing
    if(bird_vel.x < 0.0f && birdLookingRight) {
		birdLookingRight = NO;
		bird.scaleX = -1.0f;
        dude3.scaleX = -1.0f;
	} else if (bird_vel.x > 0.0f && !birdLookingRight) {
		birdLookingRight = YES;
		bird.scaleX = 1.0f;
        dude3.scaleX = 1.0f;
	}
    
    CGPoint where = dude3.position;
    where.y = where.y - 2;
    dude3.position = ccp(where.x, where.y);
    tempx = where.x;
    tempy = where.y;
	
    CGSize bird_size = dude3.contentSize;
    CGSize bomb_size = bomb.contentSize;
    CGSize bomb2_size = bomb2.contentSize;
    CGSize bomb3_size = bomb3.contentSize;
    CGSize bomb4_size = bomb3.contentSize;
    CGSize money_size = money.contentSize;
    CGSize money2_size = money2.contentSize;
    CGSize angelTime_size = angelTime.contentSize;
    CGSize bullet1_size = bullet1.contentSize;
    CGSize bullet2_size = bullet2.contentSize;

	float max_x = 320-bird_size.width/2;
	float min_x = 0+bird_size.width/2;

    float bomb_max_x = 320-bomb_size.width/2;
	float bomb_min_x = 0+bomb_size.width/2;
    float bomb2_max_x = 320-bomb2_size.width/2;
	float bomb2_min_x = 0+bomb2_size.width/2;
    float bomb3_max_x = 320-bomb3_size.width/2;
	float bomb3_min_x = 0+bomb3_size.width/2;
    float bomb4_max_x = 320-bomb3_size.width/2;
	float bomb4_min_x = 0+bomb3_size.width/2;
    
    float money_max_x = 320-money_size.width/2;
	float money_min_x = 0+money_size.width/2;
    float money2_max_x = 320-money2_size.width/2;
	float money2_min_x = 0+money2_size.width/2;
    
    float angelTime_max_x = 320-angelTime_size.width/2;
	float angelTime_min_x = 0+angelTime_size.width/2;
    
    float bullet1_max_x = 320-bullet1_size.width/2;
	float bullet1_min_x = 0+bullet1_size.width/2;
    
    float bullet2_max_x = 320-bullet2_size.width/2;
	float bullet2_min_x = 0+bullet2_size.width/2;
	
	if(bird_pos.x>max_x) bird_pos.x = max_x;
	if(bird_pos.x<min_x) bird_pos.x = min_x;
	
	bird_vel.y += bird_acc.y * dt;
	bird_pos.y += bird_vel.y * dt;
 	
	int t;
    
    // float delta = bird_pos.y -2;
    float delta = 2;
    t = kPlatformsStartTag;
    
    
    /* for(t; t < kPlatformsStartTag + kNumPlatforms; t++) {
     AtlasSprite *platform = (AtlasSprite*)[spriteManager getChildByTag:t];
     //  platform.position = ccp(100,vert);
     CGPoint pos = platform.position;
     pos = ccp(pos.x,pos.y - delta);
     if(pos.y < -platform.contentSize.height/2) {
     currentPlatformTag = t;
     [self resetPlatform];
     } else {
     platform.position = pos;
     bird_pos.y = pos.y;
     }
     }*/
    
    vert = vert - 2;
	
	if(bird_vel.y < 0) {
		
		t = kPlatformsStartTag;
		for(t; t < kPlatformsStartTag + kNumPlatforms2; t++) {
			AtlasSprite *platform = (AtlasSprite*)[spriteManager getChildByTag:t];
            
			CGSize platform_size = platform.contentSize;
			CGPoint platform_pos = platform.position;
            
            CGSize bomb_size = bomb.contentSize;
			CGPoint bomb_pos = bomb.position;
            
            CGSize bomb2_size = bomb2.contentSize;
			CGPoint bomb2_pos = bomb2.position;
            
            CGSize bomb3_size = bomb3.contentSize;
			CGPoint bomb3_pos = bomb3.position;
            
            CGSize bomb4_size = bomb4.contentSize;
			CGPoint bomb4_pos = bomb4.position;
			
            CGSize money_size = money1.contentSize;
			CGPoint money_pos = money1.position;
            
            CGSize money2_size = money2.contentSize;
			CGPoint money2_pos = money2.position;
                        
            CGSize angelTime_size = angelTime.contentSize;
			CGPoint angelTime_pos = angelTime.position;
            
            CGSize bullet1_size = bullet1.contentSize;
			CGPoint bullet1_pos = bullet1.position;
            
            CGSize bullet2_size = bullet2.contentSize;
			CGPoint bullet2_pos = bullet2.position;

            
			max_x = platform_pos.x - platform_size.width/2 - 1;
			min_x = platform_pos.x + platform_size.width/2 + 1;
			float min_y = platform_pos.y + (platform_size.height+bird_size.height)/2 - kPlatformTopPadding;
            
			bomb_max_x = bomb_pos.x - bomb_size.width/2 - 1;
			bomb_min_x = bomb_pos.x + bomb_size.width/2 + 1;
			float bomb_min_y = bomb_pos.y + (bomb_size.height+bird_size.height)/2 - kPlatformTopPadding;
           
            bomb2_max_x = bomb2_pos.x - bomb2_size.width/2 - 1;
			bomb2_min_x = bomb2_pos.x + bomb2_size.width/2 + 1;
			float bomb2_min_y = bomb2_pos.y + (bomb2_size.height+bird_size.height)/2 - kPlatformTopPadding;
           
            bomb3_max_x = bomb3_pos.x - bomb3_size.width/2 - 1;
			bomb3_min_x = bomb3_pos.x + bomb3_size.width/2 + 1;
			float bomb3_min_y = bomb3_pos.y + (bomb3_size.height+bird_size.height)/2 - kPlatformTopPadding;
            
            bomb4_max_x = bomb4_pos.x - bomb4_size.width/2 - 1;
			bomb4_min_x = bomb4_pos.x + bomb4_size.width/2 + 1;
			float bomb4_min_y = bomb4_pos.y + (bomb4_size.height+bird_size.height)/2 - kPlatformTopPadding;
            
            money_max_x = money_pos.x - money_size.width/2 - 1;
			money_min_x = money_pos.x + money_size.width/2 + 1;
			float money_min_y = money_pos.y + (money_size.height+bird_size.height)/2 - kPlatformTopPadding;

            money2_max_x = money2_pos.x - money2_size.width/2 - 1;
			money2_min_x = money2_pos.x + money2_size.width/2 + 1;
			float money2_min_y = money2_pos.y + (money2_size.height+bird_size.height)/2 - kPlatformTopPadding;

            angelTime_max_x = angelTime_pos.x - angelTime_size.width/2 - 1;
			angelTime_min_x = angelTime_pos.x + angelTime_size.width/2 + 1;
			float angelTime_min_y = angelTime_pos.y + (angelTime_size.height+bird_size.height)/2 - kPlatformTopPadding;
            
            bullet1_max_x = bullet1_pos.x - bullet1_size.width/2 - 1;
			bullet1_min_x = bullet1_pos.x + bullet1_size.width/2 + 1;
			float bullet1_min_y = bullet1_pos.y + (bullet1_size.height+bird_size.height)/2 - kPlatformTopPadding;
            
            bullet2_max_x = bullet2_pos.x - bullet2_size.width/2 - 1;
			bullet2_min_x = bullet2_pos.x + bullet2_size.width/2 + 1;
			float bullet2_min_y = bullet2_pos.y + (bullet2_size.height+bird_size.height)/2 - kPlatformTopPadding;
            

            
			if(bird_pos.x > max_x &&
			   bird_pos.x < min_x &&
			   bird_pos.y > platform_pos.y &&
			   bird_pos.y < min_y) {
				
                [self jump];
            }
            
            // !!!: Bomb check
            // ********************************* Check if a bomb hit a dude ****************
            if(bird_pos.x >= bomb_max_x &&
               bird_pos.x <= bomb_min_x &&
               bird_pos.y >= bomb_y &&
               bird_pos.y <= bomb_min_y) {
               [self explode];
                           }
            if(bird_pos.x >= bomb2_max_x &&
               bird_pos.x <= bomb2_min_x &&
               bird_pos.y >= bomb2_y &&
               bird_pos.y <= bomb2_min_y) {
                [self explode];
                
            }
            if(bird_pos.x >= bomb3_max_x &&
               bird_pos.x <= bomb3_min_x &&
               bird_pos.y >= bomb3_y &&
               bird_pos.y <= bomb3_min_y) {
                [self explode];
                           }
            if(bird_pos.x >= bomb4_max_x &&
               bird_pos.x <= bomb4_min_x &&
               bird_pos.y >= bomb4_y &&
               bird_pos.y <= bomb4_min_y) {
               
                [self explode];
            }
            
            // !!!:Money check
            // *************************************Check if Money was grabbed***************** 
            if(bird_pos.x >= money_max_x &&
               bird_pos.x <= money_min_x &&
               bird_pos.y >= money_y &&
               bird_pos.y <= money_min_y) {
                [self cashMoney];
            // **************************************************************************** 
                
            }
            if(bird_pos.x >= money2_max_x &&
               bird_pos.x <= money2_min_x &&
               bird_pos.y >= money2_y &&
               bird_pos.y <= money2_min_y) {
               
                [self cashMoney2];
               
            // **************************************************************************** 
                
            }
            // *************************************Check if AngelTime was grabbed***************** 
            if(bird_pos.x >= angelTime_max_x &&
               bird_pos.x <= angelTime_min_x &&
               bird_pos.y >= angelTime_y &&
               bird_pos.y <= angelTime_min_y) {
                
                [self angelTimeGrabbed];
                
                // **************************************************************************** 
                
            }
            // *************************************Check if Bullet1 was grabbed***************** 
            if(bird_pos.x >= bullet1_max_x &&
               bird_pos.x <= bullet1_min_x &&
               bird_pos.y >= bullet1_y &&
               bird_pos.y <= bullet1_min_y) {
                
                [self shot];
                
                // **************************************************************************** 
                
            }
            
            // *************************************Check if Bullet2 was grabbed***************** 
            if(bird_pos.x >= bullet2_max_x &&
               bird_pos.x <= bullet2_min_x &&
               bird_pos.y >= bullet2_y &&
               bird_pos.y <= bullet2_min_y) {
                [self shot];
                
                // **************************************************************************** 
                
            }


        }
		
        // Remove 100 point sign after a bonus score
        int tInt = (int) timer;
     //   if ((toc - tInt) == 2 || (toc - tInt) == 5 || (toc - tInt) == 10) {
            if ((toc - tInt) >= 2) {
            hundred.visible = NO;
            updateLabel.visible = NO;
            [self removeChild:emitterMoney cleanup:YES];
            [self removeChild:emitterMoney2 cleanup:YES];
            [self removeChild:emitterTime cleanup:YES];  
            [self removeChild:emitterBurst cleanup:YES]; 
        }
       

        // Remove thrust indicator
        if ((tob - tInt) == 2 || (tob - tInt) == 5)
            burst.visible = NO;        
        
        // Game Over
        if(dude3.position.y < -bird_size.height/2) {
            
         
            AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [app.gameLoop stop];
            [app.screamAudio play];
            [app.splashAudio play];
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBullet1) object:nil];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBullet2) object:nil];
            
            diff=0;
         
            score = currentScore;
            if ([bombExp isEqualToString:@"OFF"])
                lives -= 1;
           
            [splash setPosition:ccp(150,90)];
            
            [app.gameLoop stop];
            [app.gameLoop2 stop];
            [app.gameLoop3 stop];
            
            [app.shotAudio stop];
            
            [self performSelector:@selector(showHighscores) withObject:nil afterDelay:0];
            

            if ([endOfLevel isEqualToString:@"OFF"])
                [TheAudio2 play];
           
           if ([endOfLevel isEqualToString:@"OFF"])
            [self showHighscores];
            
		}
		
	} else if(bird_pos.y > 240) {
		
        if (bird_pos.y > 440)
            bird_pos.y = 440;
        
               
        float delta = bird_pos.y - 0.001;
		t = kPlatformsStartTag;
		for(t; t < kPlatformsStartTag + kNumPlatforms2; t++) {
			AtlasSprite *platform = (AtlasSprite*)[spriteManager getChildByTag:t];
			CGPoint pos = platform.position;
			pos = ccp(pos.x,pos.y-delta);
			if(pos.y < -platform.contentSize.height/2) {
				currentPlatformTag = t;
				[self resetPlatform];
			} else {
				platform.position = pos;
			}
		}
		
		score += ((int)delta /300);
		
        NSString *scoreStr = [NSString stringWithFormat:@"TOTAL SCORE:%d",score - (touches * 25)];
		        
        [scoreLabel setString:scoreStr];
        [scoreLabel draw];   
        
        
        if ((score - (touches * 25) >= 5000) && (score - (touches * 25) <= 5100)) {
            
            toc = timer;
            updateLabel.visible = YES;
            [updateLabel setString:@"  LEVEL 3 STATUS - ADDED A LIFE"];
            [updateLabel draw];   
            if ((score - (touches * 25) >= 5000) && (score - (touches * 25) <= 5020)){
                
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [app.level3Audio play];
                
                
            }
        }
	} 
	
    // set most current dude position
    dude3.position = bird_pos; 

    // deplete the timer to act as a clock 
    timer = timer - .0200;
    NSString *timerStr = [NSString stringWithFormat:@"TIME:%.f",timer];
    
    [timeLabel setString:timerStr];
    [timeLabel draw];

    NSString *levelStr = [NSString stringWithFormat:@"Level 2"];
    
    // if the time expires - end
    if (timer < 0) {
        AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [app.gameLoop stop];
        [app.gameLoop2 stop];
        [app.gameLoop3 stop];
        gameSuspended = YES;
       endOfLevel = @"ON";
        [self endOfLevel];
        dude3.position = ccp(-50,-50);
    }
    
    if ((timer > 11) && (timer < 11.1))
    {
        AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [app.beepsAudio play];
        
        timeLabel.scale = 2;
        //  id action;
        //  action = [Blink actionWithDuration:1 blinks:3]; 
        timeLabel.position = ccp(timeLabel.position.x - 10, timeLabel.position.y-5);
        timeLabel.visible = YES;
        [updateLabel setString:@"TIME RUNNING OUT"];
        updateLabel.visible = YES;
        [updateLabel draw];   
    }

    NSString *touchesStr = [NSString stringWithFormat:@"%i",touches];
    
    NSString *livesStr = [NSString stringWithFormat:@"%i",lives];
    [livesLabel setString:livesStr];
    [livesLabel draw];
    
}

- (void)jump {
 
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [app.jumpAudio play];
    
    diff = score - lastscore;
    lastscore = score;
    
    if (diff != 0) {
        [flashScoreLabel setString:[NSString stringWithFormat:@"  CURRENT:%i",diff]];
        [flashScoreLabel draw];
        flashScoreLabel.visible = YES;
    }
    
     blood.position = ccp(-10,-50);
    starburst.position = ccp(-10,-50);
     explosion.position = ccp(-10,-50);
    
	bird_vel.y = 300.0f - fabsf(bird_vel.x);
}
- (void)jumpBurst {
    
    if (bird_pos.y > 275) return;
    
    burst.visible = YES;
    
    flashScoreLabel.visible = NO;
    
    toc = timer;
    tob = timer;
    
    starburst.position = ccp(tempx,tempy);
    [starburst setVisible:YES];
    
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [app.gruntAudio play];
        
    touches = touches + 1;
    [touchLabel setString:[NSString stringWithFormat:@"%i",touches]];
    [touchLabel draw];
    
	bird_vel.y = 450.0f - fabsf(bird_vel.x);
}
- (void) dropBomb {
    //  NSLog(@"In Bomb");
    bomb.position = ccp(bomb_x,bomb_y);
    bomb_y = bomb_y - 2;
    if (bomb_y < -30){
        bomb_y= 1100;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb) object:nil];
    }  
}
- (void) dropBomb2 {
    //  NSLog(@"In Bomb");
    bomb2.position = ccp(bomb2_x,bomb2_y);
    bomb2_y = bomb2_y - 2;
    if (bomb2_y < -30){
        bomb2_y= 1150;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb2) object:nil];
    }  
}
- (void) dropBomb3 {
    //  NSLog(@"In Bomb");
    bomb3.position = ccp(bomb3_x,bomb3_y);
    bomb3_y = bomb3_y - 2;
    if (bomb3_y < -30){
        bomb3_y= 1200;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb3) object:nil];
    }  
}
- (void) dropBomb4 {
    //  NSLog(@"In Bomb");
    bomb4.position = ccp(bomb4_x,bomb4_y);
    bomb4_y = bomb4_y - 2;
    if (bomb4_y < -30){
        bomb4_y= 1250;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb4) object:nil];
    }  
}
- (void) dropBomb5 {
    //  NSLog(@"In Bomb");
    bomb5.position = ccp(bomb5_x,bomb5_y);
    bomb5_y = bomb5_y - 2;
    if (bomb5_y < -30){
        bomb5_y= 1350;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb5) object:nil];
    }  
}

- (void) dropMoney1 {
    //  NSLog(@"In Bomb");
    cashed = @"OFF";
    money1.scale = 1.0f;
    money1.position = ccp(money1_x,money_y);
    money_y = money_y - 3;
    if (money_y < -30){
        money_y= 1150;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropMoney1) object:nil];
    }  
}
- (void) dropMoney2 {
    //  NSLog(@"In Bomb");
    cashed = @"OFF";
    money2.scale = 1.0f;
    money2.position = ccp(money2_x,money2_y);
    money2_y = money2_y - 3;
    if (money2_y < -30){
        money2_y= 1200;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropMoney2) object:nil];
    }  
    
}
- (void) dropAngelTime {
    //  NSLog(@"In Bomb");
    angel = @"OFF";
    angelTime.scale = 1.0f;
    angelTime.position = ccp(angelTime_x,angelTime_y);
    angelTime_y = angelTime_y - 5;
    if (angelTime_y < -30){
        angelTime_y= 1750;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropAngelTime) object:nil];
        int lowerBound = 75;
        int upperBound = 285;
        angelTime.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),510);
        angelTime_x = angelTime.position.x;
    }  
    
}

- (void) dropBullet1 {
    //  NSLog(@"In Bomb");
    if ([shot isEqualToString:@"OFF"]) {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app.shotAudio play];
    }
    shot = @"ON";
    
    //   bullet1.scale = 1.0f;
    bullet1.position = ccp(bullet1_x,bullet1_y);
    
    bullet1_x = bullet1_x - 4;
    
    if (bullet1_x < 0){
        //  bullet1_x = 340;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBullet1) object:nil];
        int lowerBound = 225;
        int upperBound = 385;
        bullet1.position = ccp(380,lowerBound + arc4random() % (upperBound - lowerBound));
        
        bullet1_x = bullet1.position.x;
        bullet1_y = bullet1.position.y;
        shot = @"OFF";
    }  
    
}

- (void) dropBullet2 {
    //  NSLog(@"In Bomb");
    if ([shot2 isEqualToString:@"OFF"]) {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app.shotAudio play];
    }
    shot2 = @"ON";
    // bullet2.scale = 1.0f;
    bullet2.position = ccp(bullet2_x,bullet2_y);
    
    bullet2_x = bullet2_x + 4;
    if (bullet2_x > 360){
        bullet2_x = -40;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBullet2) object:nil];
        int lowerBound = 225;
        int upperBound = 385;
        
        bullet2.position = ccp(-80,lowerBound + arc4random() % (upperBound - lowerBound));
        
        bullet2_x = bullet2.position.x;
        bullet2_y = bullet2.position.y;
        shot2 = @"OFF";
    }  
    
}



- (void) cashMoney {
    
    if ([cashed isEqualToString:@"ON"]) return;
    
    hundred.visible = YES;
    flashScoreLabel.visible = NO;

    
    toc = timer;
    
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [app.cashAudio play];

    updateLabel.visible = YES;
    [updateLabel setString:@"MONEY BAG 50 PTS"];
    [updateLabel draw];   
    
    money1.scale = 3.0f;
    
    emitterMoney2 = [[ParticleFlower alloc] init];
    emitterMoney2.texture = [[TextureMgr sharedTextureMgr] addImage: @"money2.png"];
    emitterMoney2.position = ccp(tempx, tempy);
    [self addChild:emitterMoney2];     
    
    score = score + 100;
    
    cashed = @"ON";
    money_y = 1050;
    bird_vel.y = 250.0f - fabsf(bird_vel.x);
    
    int lowerBound = 75;
    int upperBound = 285;
    money1.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),750);
    money1_x = money1.position.x;
}

- (void) cashMoney2 {
    
    if ([cashed isEqualToString:@"ON"]) return;
    
    hundred.visible = YES;    
    flashScoreLabel.visible = NO;

    toc = timer;    
    
    emitterMoney = [[ParticleFlower alloc] init];
    emitterMoney.texture = [[TextureMgr sharedTextureMgr] addImage: @"money.png"];
    emitterMoney.position = ccp(tempx, tempy);
    [self addChild:emitterMoney]; 

   
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [app.cashAudio2 play];
    
    updateLabel.visible = YES;
    [updateLabel setString:@"MONEY BAG 50 PTS"];
    [updateLabel draw]; 
    
    money2.scale = 3.0f;
    
    score = score + 100;
    
    cashed = @"ON";
    money2_y = 1100;
    bird_vel.y = 250.0f - fabsf(bird_vel.x);
    
    int lowerBound = 75;
    int upperBound = 285;
    money2.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),750);
    money2_x = money2.position.x;
    
}

- (void) angelTimeGrabbed {
    
    if ([angel isEqualToString:@"ON"]) return;
    
    flashScoreLabel.visible = NO;

    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [app.angelAudio play];
    
    emitterTime = [[ParticleGalaxy alloc] init];
    emitterTime.texture = [[TextureMgr sharedTextureMgr] addImage: @"time.png"];
    emitterTime.position = ccp(tempx, tempy);
    [self addChild:emitterTime];     
    
    updateLabel.visible = YES;
    [updateLabel setString:@"BONUS TIME EARNED"];
    [updateLabel draw];   
    
    [app.beepsAudio stop];
    
    timer = timer + 15;
    toc = timer;
    timeLabel.scale = 1;
    [timeLabel setPosition:ccp(105,430)];
    
    angel = @"ON";
    angelTime_y = 1750;
    bird_vel.y = 350.0f - fabsf(bird_vel.x);
    
    int lowerBound = 75;
    int upperBound = 285;
    angelTime.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),510);
    angelTime_x = angelTime.position.x;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropAngelTime) object:nil];

    
}
- (void) shot {
    
    flashScoreLabel.visible = NO;
    
    blood.position = ccp(dude3.position.x,dude3.position.y);
    for (int i = 1;i < 150;i++) {
        
    }
    
    emitterSmoke = [[ParticleSmoke alloc] init];
    emitterSmoke.texture = [[TextureMgr sharedTextureMgr] addImage: @"smoke.png"];
    emitterSmoke.position = ccp(tempx, tempy);
    [self addChild:emitterSmoke];    
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    updateLabel.visible = YES;
    [updateLabel setString:@" YOU'VE BEEN SHOT"];
    [updateLabel draw];   
    
    [app.beepsAudio stop];
    [app.shotAudio stop];
    
    [app.bloodAudio play];
    [app.screamAudio play];
    dude3.scale = -1.0;
    lives -= 1;
    
    shot = @"ON";
    bullet1_x = 360;
    bullet2_x = -60;
    
    int lowerBound = 125;
    int upperBound = 385;
    
    bullet1.position = ccp(360,lowerBound + arc4random() % (upperBound - lowerBound));
    bullet1_x = bullet1.position.x;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBullet1) object:nil];
    
    bullet2.position = ccp(-30,lowerBound + arc4random() % (upperBound - lowerBound));
    bullet2_x = bullet2.position.x;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBullet2) object:nil];
    
    
    for (int i=1;i<145;i++) {
        //  NSLog(@"%i",i);
    }
    
    
    Highscores *highscores = [[Highscores alloc] initWithScore:score];
    
    [self removeChild:highscores cleanup:YES];
	
    Scene *scene = [[Scene node] addChild:highscores z:0];
    
    [self performSelector:@selector(showHighscores) withObject:nil afterDelay:1];
    
}

- (void) explode {
    
    endOfLevel = @"OFF";
    
 //   [explosion setPosition:ccp(tempx, tempy)];
    
    emitter = [[ParticleExplosion alloc] init];
    emitter.texture = [[TextureMgr sharedTextureMgr] addImage: @"fire2.png"];
    emitter.position = ccp(tempx, tempy);
    [self addChild:emitter];

    
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [app.gameLoop stop];
    [app.gameLoop2 stop];
    [app.gameLoop3 stop];
    [app.beepsAudio stop];
    [app.shotAudio stop];
    [app.bombAudio play];
    
    lives -= 1;
     bombExp = @"ON";
    
    updateLabel.visible = YES;
    [updateLabel setString:@"    EXPLOSION!!"];
    [updateLabel draw];
    
    dude3.scaleY = -2.0f;
    explosion.scale = 2.0f;
    bird_vel.y = 450.0f - fabsf(bird_vel.x);
   
    score = currentScore + (touches * 25);
    currentScore = 0;
    int lowerBound = 75;
    int upperBound = 285;
    bomb.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1100);
    bomb2.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1150);
    bomb3.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1200);
    bomb4.position = ccp(lowerBound + arc4random() % (upperBound - lowerBound),1250);
    
    
    [app.shotAudio stop];
    
    Highscores *highscores = [[Highscores alloc] initWithScore:score];
    [self removeChild:highscores cleanup:YES];
    Scene *scene = [[Scene node] addChild:highscores z:0];
    
    [self performSelector:@selector(showHighscores) withObject:nil afterDelay:1];
    
    
}
- (void) endOfLevel {
    
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [app.winAudio play];
   
    gameSuspended = YES;
    
    updateLabel.visible = YES;
    [updateLabel setString:@"END OF LEVEL"];
    [updateLabel draw];   
    
    [self showHighscores];
    
     [TheAudio5 release];
}
- (void)showHighscores {
    //	NSLog(@"showHighscores");
	
   self.isAccelerometerEnabled = NO;
    gameSuspended = YES;
	[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
 
    Highscores *highscores = [[Highscores alloc] initWithScore:score];
    
	Scene *scene = [[Scene node] addChild:highscores z:0];

    [[Director sharedDirector] pushScene:scene];
    
    [highscores release];
    
    vert = 400;
}

- (void)showHighscores2 {

}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint location = [touch locationInView:[touch view]];
	location =  [[Director sharedDirector] convertCoordinate:location];
    CGRect rect;
    
    if ([flip isEqualToString:@"TL"]) {
        rect = CGRectMake(280,424,30,45);
	}else if ([flip isEqualToString:@"TR"]){
        rect = CGRectMake(0,424,30,45);       
    }else if ([flip isEqualToString:@"BL"]){
        rect = CGRectMake(280,70,30,45);      
    }else if ([flip isEqualToString:@"BR"]){
        rect = CGRectMake(0,70,30,45);      
    }

	if(CGRectContainsPoint(rect, location)) {
        
        if (gameSuspended) {
            [pauseButton setVisible:YES];
            [playButton setVisible:NO];
            gameSuspended = NO;
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            switch(arc4random()%3) {
                    
                case 0: [app.gameLoop play]; break;
                case 1: [app.gameLoop2 play];break;
                case 2: [app.gameLoop3 play];break;
            }

           
            return YES;
        }
        gameSuspended = YES;
        AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [app.gameLoop stop];
        [app.gameLoop2 stop];                        
        [app.gameLoop3 stop];
        
        if ([flip isEqualToString:@"TL"]) {
            playButton.position = ccp(300,435);
        }else if ([flip isEqualToString:@"TR"]){
            playButton.position = ccp(30,435);       
        }else if ([flip isEqualToString:@"BL"]){
            playButton.position = ccp(300,90);      
        }else if ([flip isEqualToString:@"BR"]){
            playButton.position = ccp(30,90);    
        }

        [pauseButton setVisible:NO];
        
        [playButton setVisible:YES];
        
	}
    CGRect rect2;
        
    if ([flip isEqualToString:@"TL"]){
        rect2 = CGRectMake(0,355,97,110);
    }else if ([flip isEqualToString:@"TR"]){
        rect2 = CGRectMake(250,355,97,110);       
    }else if ([flip isEqualToString:@"BL"]){
        rect2 = CGRectMake(0,50,97,110);      
    }else if ([flip isEqualToString:@"BR"]){
        rect2 = CGRectMake(250,50,97,110);      
    }

    if(CGRectContainsPoint(rect2, location)) {
              
        AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [app.thrustAudio play];
        
        [self jumpBurst];
        //  [starburst setVisible:NO];
    }
	return YES;
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration {
	if(gameSuspended) return;
	float accel_filter = 0.1f;
	bird_vel.x = bird_vel.x * accel_filter + acceleration.x * (1.0f - accel_filter) * 500.0f;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //	NSLog(@"alertView:clickedButtonAtIndex: %i",buttonIndex);
    
	if(buttonIndex == 0) {
		[self startGame];
	} else {
		[self startGame];
	}
}

@end
