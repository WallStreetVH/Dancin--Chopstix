#import "GameLevel2.h"
#import "Main.h"
#import "Highscores.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Scene.h"
#import "GameCenterManager.h"
#import "Game.h"
#import "GameLevel3.h"


@interface GameLevel3 (Private)
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
- (void)explode; 
- (void) endOfLevel;
- (void)showHighscores;
- (void)showHighscores2;
@end

extern int vert;
extern int tempx, tempy;
extern NSTimer *when;
int bomb6_y;
int bomb7_y;
int bomb8_y;
int bomb9_y;
int bomb10_y;
int bomb6_x;
int bomb7_x;
int bomb8_x;
int bomb9_x;
int bomb10_x;
extern int touches;
extern NSString *sound;
extern NSString *music;
extern NSString *endOfLevel;
//Scene *scene;

@implementation GameLevel3

@synthesize TheAudio, TheAudio2, TheAudio3, TheAudio4, playButton, pauseButton, powerButton, starburst, level2Button, level3Button, bomb6,bomb7,bomb8,bomb9,bomb10,Timer, gameCenterManager;

- (id)initWithScore:(int)lastScore  {
    //	NSLog(@"Game::init");
    
    //  Timer = [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(dropBomb) userInfo:nil repeats:YES];
	
    score = score + lastScore;
   
    
    if(![super init]) return nil;
    
    self.isAccelerometerEnabled = YES;
    
    
    if ([GameCenterManager isGameCenterAvailable]) {
		
		self.gameCenterManager = [[[GameCenterManager alloc] init] autorelease];
        //		[self.gameCenterManager setDelegate:self];
		[self.gameCenterManager authenticateLocalUser];
		
		
	} else {
		
		// The current device does not support Game Center.
        
	}
    
    
    endOfLevel = @"OFF";
	
	gameSuspended = NO;
    
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
    AtlasSpriteManager *spriteManager2 = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager2];
    
	[self initPlatforms];
    
    AtlasSprite *stairs1 = [AtlasSprite spriteWithRect:CGRectMake(115,96,104,70) spriteManager:spriteManager2];
    
	stairs1.position = ccp(150,195);
    //    [spriteManager2 addChild:stairs1 z:4 tag:kStairs1];
    
    AtlasSprite *dude4 = [AtlasSprite spriteWithRect:CGRectMake(531,6,57,65) spriteManager:spriteManager2];
  //  AtlasSprite *dude4 = [AtlasSprite spriteWithRect:CGRectMake(93,16,35,65) spriteManager:spriteManager2];
    // dude4.position = ccp(150,220);
    //  dude4.scale = 2.0f;
    [spriteManager2 addChild:dude4 z:4 tag:kDude4];
    
    
    // AtlasSprite *dude2 = [AtlasSprite spriteWithRect:CGRectMake(424,1,65,79) spriteManager:spriteManager2];
    AtlasSprite *dude2 = [AtlasSprite spriteWithRect:CGRectMake(93,16,35,65) spriteManager:spriteManager2];
    
    //  dude4.scale = 2.0f;
    // dude4.position = ccp(150,220);
  //  [spriteManager2 addChild:dude2 z:4 tag:kDude4];
    
    
    
    pauseButton = [AtlasSprite spriteWithRect:CGRectMake(186,16,45,50) spriteManager:spriteManager2];
  //  pauseButton.position = ccp(295,442);
    
       pauseButton.position = ccp(295,92);
    [spriteManager2 addChild:pauseButton z:4 tag:kPause];
    
    playButton = [AtlasSprite spriteWithRect:CGRectMake(232,24,45,50) spriteManager:spriteManager2];
    [spriteManager2 addChild:playButton z:4 tag:kPlay];
    [playButton setVisible:NO];
    
    
    level3Button = [AtlasSprite spriteWithRect:CGRectMake(336,505,210,40) spriteManager:spriteManager2];
    [spriteManager2 addChild:level3Button z:4 tag:kPlay];
    level3Button.position = ccp(175, 400);
    [level3Button setVisible:NO];
    
    
    
    powerButton = [AtlasSprite spriteWithRect:CGRectMake(274,13,45,55) spriteManager:spriteManager2];
    // powerButton.position = ccp(165,90);
    powerButton.position = ccp(37,444);
    [spriteManager2 addChild:powerButton z:4 tag:kPower];
    // [powerButton setVisible:NO];
    
    starburst = [AtlasSprite spriteWithRect:CGRectMake(324,31,28,30) spriteManager:spriteManager2];
    // starburst.position = ccp(26,444);
    [spriteManager2 addChild:starburst z:4 tag:kStarburst];
    
    
    int lowerBound = 75;
    int upperBound = 285;
    
    timer = 5.00;
    touches = 0;
    bird_pos.x = 150;
    bird_pos.y = 440;
    bomb6_y = 480;
    bomb7_y = 480;
    bomb8_y = 480;
    bomb9_y = 480;
    bomb10_y = 480;
   // vert = 400;
  //  bird_pos.y = 400;
  //  bird_vel.y = 0;
   // bird_acc.y = 550;
    
    bomb6 = [AtlasSprite spriteWithRect:CGRectMake(360,21,25,46) spriteManager:spriteManager2];
    bomb6.position = ccp(lowerBound + random() % (upperBound - lowerBound),510);
    bomb6_x = bomb6.position.x;
    [spriteManager2 addChild:bomb6 z:4 tag:kStarburst];
    
    bomb7 = [AtlasSprite spriteWithRect:CGRectMake(360,21,25,46) spriteManager:spriteManager2];
    bomb7.position = ccp(lowerBound + random() % (upperBound - lowerBound),510);
    bomb7_x = bomb7.position.x;
    [spriteManager2 addChild:bomb7 z:4 tag:kStarburst];
    
    bomb8 = [AtlasSprite spriteWithRect:CGRectMake(360,21,25,46) spriteManager:spriteManager2];
    bomb8.position = ccp(lowerBound + random() % (upperBound - lowerBound),510);
    bomb8_x = bomb8.position.x;
    [spriteManager2 addChild:bomb8 z:4 tag:kStarburst];
    
    bomb9 = [AtlasSprite spriteWithRect:CGRectMake(360,21,25,46) spriteManager:spriteManager2];
    bomb9.position = ccp(lowerBound + random() % (upperBound - lowerBound),510);
    bomb9_x = bomb9.position.x;
    [spriteManager2 addChild:bomb9 z:4 tag:kStarburst];
    
    bomb10 = [AtlasSprite spriteWithRect:CGRectMake(360,21,25,46) spriteManager:spriteManager2];
    bomb10.position = ccp(lowerBound + random() % (upperBound - lowerBound),510);
    bomb10_x = bomb10.position.x;
    [spriteManager2 addChild:bomb10 z:4 tag:kStarburst];
    
    
    int t;
    
    // float delta = bird_pos.y -2;
    float delta = 25;
    t = kPlatformsStartTag;
    
    
    for(t; t < kPlatformsStartTag + kNumPlatforms3; t++) {
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
    
    //	LabelAtlas *scoreLabel = [LabelAtlas labelAtlasWithString:@"0" charMapFile:@"charmap.png" itemWidth:24 itemHeight:32 startCharMap:' '];
    //	[self addChild:scoreLabel z:5 tag:kScoreLabel];
	
	BitmapFontAtlas *scoreLabel = [BitmapFontAtlas bitmapFontAtlasWithString:@"0" fntFile:@"bitmapFont.fnt"];
	[self addChild:scoreLabel z:5 tag:kScoreLabel];
	scoreLabel.position = ccp(160,10);
    
    BitmapFontAtlas *timerLabel = [BitmapFontAtlas bitmapFontAtlasWithString:@"0.0" fntFile:@"bitmapFont.fnt"];
	[self addChild:timerLabel z:5 tag:kTimeLabel];
	timerLabel.position = ccp(160,430);
    
    BitmapFontAtlas *touchLabel = [BitmapFontAtlas bitmapFontAtlasWithString:@"0.0" fntFile:@"bitmapFont.fnt"];
	[self addChild:touchLabel z:5 tag:kTouchLabel];
	touchLabel.position = ccp(37,390);
    
    isTouchEnabled = YES;
	self.isAccelerometerEnabled = YES;
	
    [self schedule:@selector(step:)];
	
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
	
    self.isAccelerometerEnabled = YES;
    
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0f / 60.0f)];
    
 /*   UIAccelerometer *accelerometer = [[UIAccelerometer alloc] init];
    accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.updateInterval = 0.025;
    accelerometer.delegate = self;
*/
   
    
    [[TouchDispatcher sharedDispatcher] addEventHandler:self priority:0 swallowTouches:YES];
    
//	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kFPS)];
    
    
	
        
 /*   [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb2) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb3) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb4) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb5) object:nil];
    */
    //	bird_pos.x = 200;
    //    bird_pos.y = 400;
    
 //   [[TouchDispatcher sharedDispatcher] addEventHandler:self priority:0 swallowTouches:YES];
    
//	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kFPS)];
    
    
    
    [self startGame];
	
	return self;
}

- (void)dealloc {
    //	NSLog(@"Game::dealloc");
	[super dealloc];
}

- (void)initPlatforms {
    //	NSLog(@"initPlatforms");
	
	currentPlatformTag = kPlatformsStartTag;
	while(currentPlatformTag < kPlatformsStartTag + kNumPlatforms3) {
		[self initPlatform];
		currentPlatformTag++;
	}
	
	[self resetPlatforms];
}

- (void)initPlatform {
    
	CGRect rect;
	switch(random()%4) {
            //	case 0: rect = CGRectMake(608,64,102,36); break;
            //	case 1: rect = CGRectMake(608,128,90,32); break;
            
            //   case 0: rect = CGRectMake(115,96,104,70); break;
            //     case 1: rect = CGRectMake(0,97,104,70); break;    
            
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
	
	[self resetClouds];
	[self resetPlatforms];
	[self resetBird];
	[self resetBonus];
    
    //   [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"firestorm2.mp3"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dark" ofType:@"aif"];   
    TheAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    TheAudio.delegate = self; 
    TheAudio.volume = 0.25;
    if ([music isEqualToString:@"ON"])
        [TheAudio play]; 
    
	
	//[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
	gameSuspended = NO;
    
  //  isTouchEnabled = YES;
    
	
    
 //   [[TouchDispatcher sharedDispatcher] addEventHandler:self priority:0 swallowTouches:YES];
    
	self->accelerometer = [UIAccelerometer sharedAccelerometer];
    self->accelerometer.updateInterval =(1.0 / kFPS);
    self->accelerometer.delegate = self;
    isAccelerometerEnabled = YES;
    
}

- (void)resetPlatforms {
    //	NSLog(@"resetPlatforms");
	
	currentPlatformY = 420;
	currentPlatformTag = kPlatformsStartTag;
	currentMaxPlatformStep = 60.0f;
	currentBonusPlatformIndex = 0;
	currentBonusType = 0;
	platformCount = 0;
    
	while(currentPlatformTag < kPlatformsStartTag + kNumPlatforms3) {
		[self resetPlatform];
		currentPlatformTag++;
	}
    
}

/*- (void)resetPlatform {
 
 if(currentPlatformY < 0) {
 currentPlatformY = 30.0f;
 } else {
 currentPlatformY += random() % (int)(currentMaxPlatformStep - kMinPlatformStep) + kMinPlatformStep;
 if(currentMaxPlatformStep < kMaxPlatformStep) {
 currentMaxPlatformStep += 0.5f;
 }
 }
 
 AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
 AtlasSprite *platform = (AtlasSprite*)[spriteManager getChildByTag:currentPlatformTag];
 
 //if(random()%2==1) platform.scaleX = -1.0f;
 
 float x;
 CGSize size = platform.contentSize;
 if(currentPlatformY == 30.0f) {
 x = 160.0f;
 } else {
 x = random() % (320-(int)size.width) + size.width/2;
 }
 
 platform.position = ccp(x,currentPlatformY);
 platformCount++;
 //	NSLog(@"platformCount = %d",platformCount);
 
 if(platformCount == currentBonusPlatformIndex) {
 //		NSLog(@"platformCount == currentBonusPlatformIndex");
 AtlasSprite *bonus = (AtlasSprite*)[spriteManager getChildByTag:kBonusStartTag+currentBonusType];
 bonus.position = ccp(x,currentPlatformY+30);
 bonus.visible = YES;
 }
 }*/
- (void)resetPlatform {
	
	if(currentPlatformY < 0) {
		currentPlatformY = 420.0f;
	} else {
		currentPlatformY += random() % (int)(currentMaxPlatformStep - kMinPlatformStep) + kMinPlatformStep;
		if(currentMaxPlatformStep < kMaxPlatformStep) {
			currentMaxPlatformStep += 0.5f;
		}
	}
	
    currentPlatformY = 230.f;
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	AtlasSprite *platform = (AtlasSprite*)[spriteManager getChildByTag:currentPlatformTag];
    
    //   platform.position = ccp(50,200);
	
	if(random()%2==1) platform.scaleX = -1.0f;
	
	float x;
	CGSize size = platform.contentSize;
	if(currentPlatformY == 30.0f) {
		x = 160.0f;
        //  currentPlatformY = 420;
	} else {
		x = random() % (320-(int)size.width) + size.width/2;
	}
	
	platform.position = ccp(x,currentPlatformY);
	platformCount++;
    //	NSLog(@"platformCount = %d",platformCount);
    /*	
     if(platformCount == currentBonusPlatformIndex) {
     //		NSLog(@"platformCount == currentBonusPlatformIndex");
     AtlasSprite *bonus = (AtlasSprite*)[spriteManager getChildByTag:kBonusStartTag+currentBonusType];
     bonus.position = ccp(x,currentPlatformY+30);
     bonus.visible = YES;
     }*/
}


- (void)resetBird {
    //	NSLog(@"resetBird");
    
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
    AtlasSpriteManager *spriteManager2 = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager2];
	AtlasSprite *bird = (AtlasSprite*)[spriteManager getChildByTag:kBird];
    AtlasSprite *dude4 = (AtlasSprite*)[spriteManager2 getChildByTag:kDude4];
	
//	bird_pos.x = 160;
//	bird_pos.y = 460;
//	bird.position = bird_pos;
//    dude4.position = bird_pos;
    
	
//	bird_vel.x = 0;
	bird_vel.y = 0;
	
	bird_acc.x = 0;
	bird_acc.y = -550.0f;
    
    bird_pos.x = 160;
	bird_pos.y = 1280;
    
	bird.position = bird_pos;
    dude4.position = bird_pos;
    
	birdLookingRight = YES;
    //	bird.scaleX = 1.0f;
    //    dude4.scaleX = 1.0f;
    
}

- (void)resetBonus {
    //	NSLog(@"resetBonus");
	
/*	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	AtlasSprite *bonus = (AtlasSprite*)[spriteManager getChildByTag:kBonusStartTag+currentBonusType];
	bonus.visible = NO;
	currentBonusPlatformIndex += random() % (kMaxBonusStep - kMinBonusStep) + kMinBonusStep;
	if(score < 10000) {
		currentBonusType = 0;
	} else if(score < 50000) {
		currentBonusType = random() % 2;
	} else if(score < 100000) {
		currentBonusType = random() % 3;
	} else {
		currentBonusType = random() % 2 + 2;
	}*/
}

- (void)step:(ccTime)dt {
    //	NSLog(@"Game::step");
    
	[super step:dt];
    
    if (timer < 0)
        endOfLevel = @"ON";
	
	if(gameSuspended) return;
    
    //    if ([music isEqualToString:@"ON"]){
    //        if (TheAudio.playing == FALSE)
    //            [TheAudio play];
    //    }
    
    //    when = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(dropBomb) userInfo:nil repeats:YES];
    
    if ((timer >= 17) && (timer <= 20)){
        [level3Button setVisible:YES];
    }else{
        [level3Button setVisible:NO];
    }
    
    
    [self performSelector:@selector(dropBomb) withObject:nil afterDelay:8];
    [self performSelector:@selector(dropBomb2) withObject:nil afterDelay:13];
    [self performSelector:@selector(dropBomb3) withObject:nil afterDelay:16];
    [self performSelector:@selector(dropBomb4) withObject:nil afterDelay:18];
    [self performSelector:@selector(dropBomb5) withObject:nil afterDelay:19];
    
    
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	AtlasSprite *bird = (AtlasSprite*)[spriteManager getChildByTag:kBird];
    
    AtlasSpriteManager *spriteManager2 = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager2];
	AtlasSprite *dude4 = (AtlasSprite*)[spriteManager2 getChildByTag:kDude4];
	
	bird_pos.x += bird_vel.x * dt;
    
	
	// Velocity determines which way sprite is facing
    if(bird_vel.x < -30.0f && birdLookingRight) {
		birdLookingRight = NO;
		bird.scaleX = -1.0f;
        dude4.scaleX = -1.0f;
	} else if (bird_vel.x > 30.0f && !birdLookingRight) {
		birdLookingRight = YES;
		bird.scaleX = 1.0f;
        dude4.scaleX = 1.0f;
	}
    
    
    CGPoint where = dude4.position;
    where.y = where.y - 2;
 //   dude4.position = ccp(where.x, where.y);
    bird_pos = ccp(dude4.position.x, dude4.position.y);
    NSLog(@"dude4: %f %f",dude4.position.x, dude4.position.y);
    tempx = where.x;
    tempy = where.y;
    
	
    CGSize bird_size = dude4.contentSize;
    CGSize bomb6_size = bomb6.contentSize;
	float max_x = 320-bird_size.width/2;
	float min_x = 0+bird_size.width/2;
    float bomb_max_x = 320-bomb6_size.width/2;
	float bomb_min_x = 0+bomb6_size.width/2;
	
	if(bird_pos.x>max_x) bird_pos.x = max_x;
	if(bird_pos.x<min_x) bird_pos.x = min_x;
	
	bird_vel.y += bird_acc.y * dt;
	bird_pos.y += bird_vel.y * dt;
    NSLog(@"bird_pos: %f %f", bird_pos.x,bird_pos.y);
    NSLog(@"dude4: %f %f",dude4.position.x, dude4.position.y);
	/*AtlasSprite *bonus = (AtlasSprite*)[spriteManager getChildByTag:kBonusStartTag+currentBonusType];
     if(bonus.visible) {
     CGPoint bonus_pos = bonus.position;
     float range = 20.0f;
     if(bird_pos.x > bonus_pos.x - range &&
     bird_pos.x < bonus_pos.x + range &&
     bird_pos.y > bonus_pos.y - range &&
     bird_pos.y < bonus_pos.y + range ) {
     switch(currentBonusType) {
     case kBonus5:   score += 5000;   break;
     case kBonus10:  score += 10000;  break;
     case kBonus50:  score += 50000;  break;
     case kBonus100: score += 100000; break;
     }
     NSString *scoreStr = [NSString stringWithFormat:@"%d",score];
     BitmapFontAtlas *scoreLabel = (BitmapFontAtlas*)[self getChildByTag:kScoreLabel];
     [scoreLabel setString:scoreStr];
     id a1 = [ScaleTo actionWithDuration:0.2f scaleX:1.5f scaleY:0.8f];
     id a2 = [ScaleTo actionWithDuration:0.2f scaleX:1.0f scaleY:1.0f];
     id a3 = [Sequence actions:a1,a2,a1,a2,a1,a2,nil];
     [scoreLabel runAction:a3];
     [self resetBonus];
     }
     } 
     */
	
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
		for(t; t < kPlatformsStartTag + kNumPlatforms3; t++) {
			AtlasSprite *platform = (AtlasSprite*)[spriteManager getChildByTag:t];
            
			CGSize platform_size = platform.contentSize;
			CGPoint platform_pos = platform.position;
            
            CGSize bomb_size = bomb6.contentSize;
			CGPoint bomb_pos = bomb6.position;
			
			max_x = platform_pos.x - platform_size.width/2 - 1;
			min_x = platform_pos.x + platform_size.width/2 + 1;
			float min_y = platform_pos.y + (platform_size.height+bird_size.height)/2 - kPlatformTopPadding;
            
			bomb_max_x = bomb_pos.x - bomb_size.width/2 - 1;
			bomb_min_x = bomb_pos.x + bomb_size.width/2 + 1;
			float bomb_min_y = bomb_pos.y + (bomb_size.height+bird_size.height)/2 - kPlatformTopPadding;
            
            
            
			if(bird_pos.x > max_x &&
			   bird_pos.x < min_x &&
			   bird_pos.y > platform_pos.y &&
			   bird_pos.y < min_y) {
				[self jump];
            }
            
            // ********************************* Check if a bomb hit a dude ****************
            if(bird_pos.x >= bomb_max_x &&
               bird_pos.x <= bomb_min_x &&
               bird_pos.y >= bomb6_y &&
               bird_pos.y <= bomb_min_y) {
                [self explode];
                dude4.position = ccp(-50,-50);
                // **************************************************************************** 
                
            }
		}
		
		
        // Double the sprite size as he's about to die
        if(dude4.position.y < 50){
            dude4.scale = 2.0f;
        }else{
            dude4.scale = 1.0f;
        }
        
        //   dude4.position = ccp(200,300);
        
        // Game Over
        if(dude4.position.y < -bird_size.height/2) {
            
            /*           [TheAudio stop];
              [TheAudio release];*/
            NSString *path = [[NSBundle mainBundle] pathForResource:@"scream" ofType:@"wav"];   
            TheAudio2 =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
            
            if ([endOfLevel isEqualToString:@"OFF"])
                [TheAudio2 play];
            // sleep(1);
            //   for (int i=1;i<1000;i++) {
            //   if (TheAudio2.playing == FALSE)
          //  if ([endOfLevel isEqualToString:@"OFF"])
                [self showHighscores];
            //   }
		}
		
	} else if(bird_pos.y > 240) {
		
        if (bird_pos.y > 440)
            bird_pos.y = 440;
        
        /*	float delta = bird_pos.y - 240;
         bird_pos.y = 440;
         
         currentPlatformY -= delta;
         
         t = kCloudsStartTag;
         for(t; t < kCloudsStartTag + kNumClouds; t++) {
         AtlasSprite *cloud = (AtlasSprite*)[spriteManager getChildByTag:t];
         CGPoint pos = cloud.position;
         pos.y -= delta * cloud.scaleY * 0.8f;
         if(pos.y < -cloud.contentSize.height/2) {
         currentCloudTag = t;
         [self resetCloud];
         } else {
         cloud.position = pos;
         }
         }*/
        
        float delta = bird_pos.y - 0.001;
		t = kPlatformsStartTag;
		for(t; t < kPlatformsStartTag + kNumPlatforms3; t++) {
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
		
        /*
         if(bonus.visible) {
         ccVertex2F pos = bonus.position;
         pos.y -= delta;
         if(pos.y < -bonus.contentSize.height/2) {
         [self resetBonus];
         } else {
         bonus.position = pos;
         }
         }
         */
		score += (int)delta;
		NSString *scoreStr = [NSString stringWithFormat:@"%d",score];
        
		BitmapFontAtlas *scoreLabel = (BitmapFontAtlas*)[self getChildByTag:kScoreLabel];
		[scoreLabel setString:scoreStr];
        
        
        
	} 
	
    
    // set most current dude position
    dude4.position = bird_pos; 
    NSLog(@"dude: %f %f", dude4.position.x, dude4.position.y);
    
    // deplete the timer to act as a clock 
    timer = timer - .0250;
    NSString *timerStr = [NSString stringWithFormat:@"%0.#f",timer];
    
    NSString *levelStr = [NSString stringWithFormat:@"Level 2"];
    
    
    BitmapFontAtlas *timeLabel = (BitmapFontAtlas*)[self getChildByTag:kTimeLabel];
    [timeLabel setString:timerStr];
    
    
    // if the time expires - end
    if (timer < 0) {
        gameSuspended = YES;
        endOfLevel = @"ON";
        NSLog(@"endOfLevel: %@",endOfLevel);
       // [self showHighscores];
       [self endOfLevel];
      // dude4.position = ccp(-50,-50);
        
    }
    
    NSString *touchesStr = [NSString stringWithFormat:@"%i",touches];
    
    BitmapFontAtlas *touchLabel = (BitmapFontAtlas*)[self getChildByTag:kTouchLabel];
    [touchLabel setString:touchesStr];
    
}

- (void)jump {
    [TheAudio2 release];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ScannerBeep" ofType:@"wav"];   
    TheAudio2 =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    //  TheAudio2.delegate = self;   
    [TheAudio2 play];
    
    starburst.position = ccp(-5,-5);
    
	bird_vel.y = 250.0f - fabsf(bird_vel.x);
}
- (void)jumpBurst {
    
    if (bird_pos.y > 250) return;
    
    starburst.position = ccp(tempx,tempy);
    [starburst setVisible:YES];
    
    [TheAudio2 release];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ScannerBeep" ofType:@"wav"];   
    TheAudio2 =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    //  TheAudio2.delegate = self;   
    [TheAudio2 play];
    
    touches = touches + 1;
    
    //   [starburst setVisible:NO];
    
	bird_vel.y = 450.0f - fabsf(bird_vel.x);
}
- (void) dropBomb {
    //  NSLog(@"In Bomb");
    bomb6.position = ccp(bomb6_x,bomb6_y);
    bomb6_y = bomb6_y - 2;
    if (bomb6_y < -30){
        bomb6_y= 480;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb) object:nil];
    }  
}
- (void) dropBomb2 {
    //  NSLog(@"In Bomb");
    bomb7.position = ccp(bomb7_x,bomb7_y);
    bomb7_y = bomb7_y - 2;
    if (bomb7_y < -30){
        bomb7_y= 480;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb2) object:nil];
    }  
}
- (void) dropBomb3 {
    //  NSLog(@"In Bomb");
    bomb8.position = ccp(bomb8_x,bomb8_y);
    bomb8_y = bomb8_y - 2;
    if (bomb8_y < -30){
        bomb8_y= 480;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb3) object:nil];
    }  
}
- (void) dropBomb4 {
    //  NSLog(@"In Bomb");
    bomb9.position = ccp(bomb9_x,bomb9_y);
    bomb9_y = bomb9_y - 2;
    if (bomb9_y < -30){
        bomb9_y= 480;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb4) object:nil];
    }  
}
- (void) dropBomb5 {
    //  NSLog(@"In Bomb");
    bomb10.position = ccp(bomb10_x,bomb10_y);
    bomb10_y = bomb10_y - 2;
    if (bomb10_y < -30){
        bomb10_y= 480;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dropBomb5) object:nil];
    }  
}




- (void) explode {
    
    [TheAudio4 release];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"wav"];   
    TheAudio4 =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    [TheAudio4 play];
    sleep(1);
    
    //  [TheAudio4 release];
    //  [Scene removeChild:highscores cleanup:YES];
    //  [self removeChild:scene cleanup:YES];
    
    //   [self showHighscores];
}
- (void) endOfLevel {
    
    [TheAudio4 release];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"win" ofType:@"wav"];   
    TheAudio4 =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    [TheAudio4 play];
    sleep(1);
    
    gameSuspended = YES;
    
  //  [self showHighscores];
    
    /*timer = 20;
    
    //  bird_pos.y = 440;
    
    bird_pos = ccp(150,440);*/
    self.isAccelerometerEnabled = NO;
    
    GameLevel2 *gameInstructions = [[GameLevel2 alloc] initWithScore:score];
    
    Scene *scene = [[Scene node] addChild:gameInstructions z:4];
	TransitionScene *ts = [FadeTransition transitionWithDuration:0.5f scene:scene withColorRGB:0xffffff];
   // [[Director sharedDirector] replaceScene:ts]; 
      [[Director sharedDirector] pushScene:ts];
    
    
    
    
}
- (void)showHighscores {
    //	NSLog(@"showHighscores");
	
  //  if ([endOfLevel isEqualToString:@"ON"])
    //    return;
    
    [TheAudio4 release];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"win" ofType:@"wav"];   
    TheAudio4 =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    [TheAudio4 play];
    sleep(1);

    
    gameSuspended = YES;
	[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [[TouchDispatcher sharedDispatcher] removeEventHandler:self];
    
    Highscores *highscores = [[Highscores alloc] initWithScore:score];
    
	Scene *scene = [[Scene node] addChild:highscores z:0];
	
    //  [[Director sharedDirector] replaceScene:[FadeTransition transitionWithDuration:1 scene:scene withColorRGB:0xffffff]];
    //    [scene release];
    [[Director sharedDirector] pushScene:scene];
    
  //  vert = 400;
}

- (void)showHighscores2 {
    /*    //	NSLog(@"showHighscores");
     gameSuspended = YES;
     [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
     
     [[TouchDispatcher sharedDispatcher] removeEventHandler:self];
     
     Highscores *highscores2 = [[Highscores alloc] initWithScore:score];
     
     Scene *scene2 = [[Scene node] addChild:highscores2 z:0];
     
     [[Director sharedDirector] replaceScene:[FadeTransition transitionWithDuration:1 scene:scene2 withColorRGB:0xffffff]];
     //    [scene release];
     
     
     vert = 400;*/
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint location = [touch locationInView:[touch view]];
	location =  [[Director sharedDirector] convertCoordinate:location];
    CGRect rect;
    rect = CGRectMake(295,424,30,45);
	if(CGRectContainsPoint(rect, location)) {
        
        if (gameSuspended) {
            [pauseButton setVisible:YES];
            [playButton setVisible:NO];
            gameSuspended = NO;
            //   [TheAudio play];
            return YES;
        }
        gameSuspended = YES;
        [TheAudio stop];
        playButton.position = ccp(300,435);
        [pauseButton setVisible:NO];
        
        [playButton setVisible:YES];
        
        [TheAudio2 release];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"carskid" ofType:@"wav"];   
        TheAudio2 =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
        [TheAudio2 play];
	}
    CGRect rect2;
    //  powerButton.position = ccp(37,444);
    // powerButton.position = ccp(165,90);
    rect2 = CGRectMake(0,395,47,76);
    // rect2 = CGRectMake(140,65,47,76);
    if(CGRectContainsPoint(rect2, location)) {
        [TheAudio3 release];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shield" ofType:@"wav"];   
        TheAudio3 =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
        [TheAudio3 play];
        [self jumpBurst];
        //  [starburst setVisible:NO];
    }
	return YES;
}


//- (BOOL)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
//	NSLog(@"ccTouchesEnded");
//
////	[self showHighscores];
//
////	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
////	AtlasSprite *bonus = (AtlasSprite*)[spriteManager getChildByTag:kBonus];
////	bonus.position = ccp(160,30);
////	bonus.visible = !bonus.visible;
//
////	BitmapFontAtlas *scoreLabel = (BitmapFontAtlas*)[self getChildByTag:kScoreLabel];
////	id a1 = [ScaleTo actionWithDuration:0.2f scaleX:1.5f scaleY:0.8f];
////	id a2 = [ScaleTo actionWithDuration:0.2f scaleX:1.0f scaleY:1.0f];
////	id a3 = [Sequence actions:a1,a2,a1,a2,a1,a2,nil];
////	[scoreLabel runAction:a3];
//
//	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
//	AtlasSprite *platform = (AtlasSprite*)[spriteManager getChildByTag:kPlatformsStartTag+5];
//	id a1 = [MoveBy actionWithDuration:2 position:ccp(100,0)];
//	id a2 = [MoveBy actionWithDuration:2 position:ccp(-200,0)];
//	id a3 = [Sequence actions:a1,a2,a1,nil];
//	id a4 = [RepeatForever actionWithAction:a3];
//	[platform runAction:a4];
//	
//	return kEventHandled;
//}


-(void) onEnterTransitionDidFinish {
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kFPS)];  // define accel interval here
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];  // set the delegate
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];  // to disable phone lock if you're using only accelerometer in your game
    
    [super onEnterTransitionDidFinish];

    
}
- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration {
	if(gameSuspended) return;
	float accel_filter = 0.1f;
	bird_vel.x = bird_vel.x * accel_filter + acceleration.x * (1.0f - accel_filter) * 500.0f;
    NSLog(@"bird_vel.x: %f",bird_vel.x);
}
-(void) onExit {
/*	[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
	[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
 */
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
