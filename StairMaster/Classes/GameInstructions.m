#import "GameInstructions.h"
#import "Main.h"
#import "Highscores.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Scene.h"
#import "GameCenterManager.h"
#import "Game.h"


@interface GameInstructions (Private)

@end


@implementation GameInstructions

@synthesize clickAudio;

- (id)initWithScore:(int)lastScore {
    //	NSLog(@"Highscores::init");
	
	if(![super init]) return nil;
    
   /* UIViewController *controller = [[UIViewController alloc] init];
    controller.view.frame = CGRectMake(0,0,320,3200);
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [scroll setContentSize:CGSizeMake(300, 3200)];
    scroll.scrollEnabled = YES;
    [controller.view addSubview:scroll];
  */	
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	
    AtlasSprite *titleMain = [AtlasSprite spriteWithRect:CGRectMake(3,264,275,40) spriteManager:spriteManager];
//	[spriteManager addChild:titleMain z:5];
	titleMain.position = ccp(155,440);
    
    Sprite *details = [Sprite spriteWithFile:@"instructionDetails.png"];
    details.position = ccp(155,231);
    [self addChild:details];
	
    NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];   
    clickAudio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    clickAudio.volume = 18;
    
  /*  AtlasSprite *title = [AtlasSprite spriteWithRect:CGRectMake(333,418,355,37) spriteManager:spriteManager];
	[spriteManager addChild:title z:5];
	title.position = ccp(189,400);
    */
    
    MenuItem *button1 = [MenuItemImage itemFromNormalImage:@"goBack.png" selectedImage:@"goBack.png" target:self selector:@selector(button1Callback:)];
	
/*    MenuItem *button2 = [MenuItemImage itemFromNormalImage:@"changePlayerButton.png" selectedImage:@"changePlayerButton.png" target:self selector:@selector(button2Callback:)];
    
	MenuItem *button3 = [MenuItemImage itemFromNormalImage:@"showLeaderboard.png" selectedImage:@"showLeaderboard.png" target:self selector:@selector(button3Callback:)];
    
    MenuItem *button4 = [MenuItemImage itemFromNormalImage:@"Instructions.png" selectedImage:@"Instructions.png" target:self selector:@selector(button4Callback:)];
    
*/
    Menu *menu = [Menu menuWithItems: button1, nil];
    
	[menu alignItemsVerticallyWithPadding:1];
	 menu.position = ccp(160,25);
	
	[self addChild:menu];
 
	
	return self;
}

- (void)button1Callback:(id)sender {
    //	NSLog(@"button2Callback");
    
    [clickAudio play];
    //   gameSuspended = YES;
	[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [[TouchDispatcher sharedDispatcher] removeEventHandler:self];
    
 //  [[Director sharedDirector] popScene];
     Highscores *gameInstructions = [[Highscores alloc] initWithScore:0];
    
	Scene *scene = [[Scene node] addChild:gameInstructions z:-1];
	
    [[Director sharedDirector] pushScene:scene];
    
    [gameInstructions release];
    
  //  [[Director sharedDirector] replaceScene:[FadeUpTransition transitionWithDuration:0.5f scene:scene]];
	
   
    
  //  [scene removeChild:gameInstructions cleanup:YES];
}


- (id)init {
//	NSLog(@"Game::init");
    
  //  Timer = [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(dropBomb) userInfo:nil repeats:YES];
	
                     
    AtlasSpriteManager *spriteManager2 = [AtlasSpriteManager spriteManagerWithFile:@"stairsMaster.png" capacity:10];
	[self addChild:spriteManager2 z:0 tag:kSpriteManager2];
    
    
    //    AtlasSpriteManager *spriteManager = [AtlasSpriteManager spriteManagerWithFile:@"sprites.png" capacity:10];
    //  	[self addChild:spriteManager z:-1 tag:kSpriteManager];
    
    
	AtlasSprite *background = [AtlasSprite spriteWithRect:CGRectMake(0,324,320,480) spriteManager:spriteManager2];
	[spriteManager2 addChild:background z:0 tag:kSpriteManager2];
	background.position = CGPointMake(160,240);
    
    
    AtlasSprite *dude2 = [AtlasSprite spriteWithRect:CGRectMake(93,16,35,65) spriteManager:spriteManager2];
    //  dude1.scale = 2.0f;
    [spriteManager2 addChild:dude2 z:0 tag:kDude2];
    
    return self;

   // return self;
    
	
	}

- (void)dealloc {
//	NSLog(@"Game::dealloc");
	[super dealloc];
}


@end
