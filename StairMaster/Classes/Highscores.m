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
#import <OpenGLES/ES2/glext.h>
#import "AppDelegate.h"
#import "iAd/ADBannerView.h"
//#import "Game_CenterViewController.m"


@interface Highscores (Private)
- (void)loadCurrentPlayer;
- (void)loadHighscores;
- (void)updateHighscores;
- (void)saveCurrentPlayer;
- (void)saveHighscores;
- (void)showOver1000;
- (void)button1Callback:(id)sender;
- (void)button2Callback:(id)sender;
@end

extern int touches;
extern int level;
MenuItem *button1;
extern BOOL gameSuspended;
int currentScore;
extern int lives;


@implementation Highscores

@synthesize gameCenterManager, viewController, window;
//@synthesize currentScore;
@synthesize currentLeaderBoard;
//@synthesize currentScoreLabel;

- (id)initWithScore:(int)lastScore {
    
    //lastScore = 1100;
//	NSLog(@"Highscores::init");
    
   /* if (lastScore >=1000) {
        changeSettingAlert = [UIAlertView new];
        changeSettingAlert.title = @"Purchase";
        changeSettingAlert.message = @"You completed level 1 - to purchase the full app, tap OK and then tap on the Buy Full Version button.";
        changeSettingAlert.delegate = self;
        [changeSettingAlert addButtonWithTitle:@"OK"];
        
        [changeSettingAlert show];
        return;
   	}
    */
	
//	sleep(1);
    if(![super init]) return nil;
    
    self->window.rootViewController = self.viewController;

//	NSLog(@"lastScore = %d",lastScore);
	
	currentScore = lastScore - (touches * 25);

    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [app.gameLoop stop]; 
    [app.gameLoop2 stop];
    [app.gameLoop3 stop];
    [app.shotAudio stop];
    
//	NSLog(@"currentScore = %d",currentScore);
	
	if ([GameCenterManager isGameCenterAvailable]) {
		
		self.gameCenterManager = [[GameCenterManager alloc] init];
//		[self.gameCenterManager setDelegate:self];
		[self.gameCenterManager authenticateLocalUser];
		[self.gameCenterManager release];
		
	} else {
		
		// The current device does not support Game Center.
        [self.gameCenterManager release];
	}

    
    [self loadCurrentPlayer];
	[self loadHighscores];
	[self updateHighscores];
	if(currentScorePosition >= 0) {
		[self saveHighscores];
	}
    
   
 //   controller.view.frame = CGRectMake(0,415,320,64);
    
    //From the official iAd programming guide
 /*   adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
     adView.frame = CGRectOffset(adView.frame, 0, 415);
    adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    
    adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    
    [controller.view addSubview:adView];
 */   
   
	
    AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	
    AtlasSprite *titleMain = [AtlasSprite spriteWithRect:CGRectMake(3,264,272,42) spriteManager:spriteManager];
	[spriteManager addChild:titleMain z:5];
	titleMain.position = ccp(155,442);
	
    AtlasSprite *title = [AtlasSprite spriteWithRect:CGRectMake(297,180,355,40) spriteManager:spriteManager];
	[spriteManager addChild:title z:5];
	title.position = ccp(172,400);
    
    
 /*   NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];   
    clickAudio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    clickAudio.volume = 18;
  */  
    if ((currentScore >= 1000) && (level == 1)) {
        lives += 1;
        level = 2;
        /*  changeSettingAlert = [UIAlertView new];
         changeSettingAlert.title = @"Scoring Alert!";
         changeSettingAlert.message = @"You have made it to Level 2 and earned an additional life.\n Tap OK to play again.";
         changeSettingAlert.delegate = self;
         [changeSettingAlert addButtonWithTitle:@"OK"];
         
         [changeSettingAlert show];*/
        
    //    [self performSelector:@selector(showOver1000) withObject:nil afterDelay:1];
        
        
    }

    
    Label *label01 = [Label labelWithString:[NSString stringWithFormat:@"Current score: %d - %d (25ea) =  Net: %d",lastScore,(touches * 25),currentScore] dimensions:CGSizeMake(280,40) alignment:UITextAlignmentRight fontName:@"Arial" fontSize:12];
    [self addChild:label01 z:5];
    [label01 setRGB:0 :0 :0];
    [label01 setOpacity:200];
    label01.position = ccp(140, 395);

	float start_y = 360.0f;
	float step = 27.0f;
	int count = 0;
    for (int i = 0;i< highscores.count;i++)
    {
        NSString *player = [highscores objectAtIndex:i];
	//	int score = [[highscores objectAtIndex:2] intValue];
    //    int touches = [[highscores objectAtIndex:1]intValue];
    //    NSLog(@"highscores: %@ ",player);
    }
	for(NSMutableArray *highscore in highscores) {
		NSString *player = [highscore objectAtIndex:0];
		int score = [[highscore objectAtIndex:2] intValue];
        int touches = [[highscore objectAtIndex:1]intValue];

        
		Label *label1 = [Label labelWithString:[NSString stringWithFormat:@"%d",(count+1)] dimensions:CGSizeMake(30,40) alignment:UITextAlignmentRight fontName:@"Arial" fontSize:14];
		[self addChild:label1 z:5];
		[label1 setRGB:0 :0 :0];
		[label1 setOpacity:200];
		label1.position = ccp(5,start_y-count*step-2.0f);
		
		Label *label2 = [Label labelWithString:player dimensions:CGSizeMake(240,40) alignment:UITextAlignmentLeft fontName:@"Karate" fontSize:16];
		[self addChild:label2 z:5];
		[label2 setRGB:0 :0 :0];
		label2.position = ccp(150,start_y-count*step);

		Label *label3 = [Label labelWithString:[NSString stringWithFormat:@"%d",score] dimensions:CGSizeMake(290,40) alignment:UITextAlignmentRight fontName:@"Arial" fontSize:16];
		[self addChild:label3 z:5];
		[label3 setRGB:0 :0 :0];
		[label3 setOpacity:200];
		label3.position = ccp(150,start_y-count*step);
        
        Label *label4 = [Label labelWithString:[NSString stringWithFormat:@"%d",touches] dimensions:CGSizeMake(90,40) alignment:UITextAlignmentRight fontName:@"Arial" fontSize:16];
		[self addChild:label4 z:5];
		[label4 setRGB:0 :0 :0];
		[label4 setOpacity:200];
		label4.position = ccp(160,start_y-count*step);
		
		count++;
		if(count == 10) break;
	}

    if (lives < 1) {
        
        level = 1;
        lives = 3;
        
        NSUInteger adStatus = adView.retainCount;
        
      //  [adView release];
     //   [adView removeFromSuperview];
        
        changeSettingAlert = [UIAlertView new];
        changeSettingAlert.title = @"Sadly!";
        changeSettingAlert.message = @"You have lost several lives. This may be your final life cycle. If not, you will be returned to your highest level achieved and the lives of your current life cycle will be restored.\n Tap OK to play again.";
        changeSettingAlert.delegate = self;
        [changeSettingAlert addButtonWithTitle:@"OK"];
        
        [changeSettingAlert show];
        
       
        
        // [self showHighscores];
        //  return 0;
        
    }
    
    if (currentScore >= 1000) {
       
        [NSThread detachNewThreadSelector:@selector(showOver1000 ) toTarget:self withObject:nil];
     
        level = 2;
       
    }
    
    
/*    if (currentScore < 1000) {
    /*changeSettingAlert = [UIAlertView new];
    changeSettingAlert.title = @"Scoring Alert!";
    changeSettingAlert.message = @"A minimum of 1,000 points is necessary to move on to Level 2.\n Tap OK to play again.";
    changeSettingAlert.delegate = self;
    [changeSettingAlert addButtonWithTitle:@"OK"];
    
    [changeSettingAlert show];

        level = 1;
    }
*/
    
      if ((currentScore >= 5000) && (level == 2)) {
        lives += 1;
        level = 3;
    /*    changeSettingAlert = [UIAlertView new];
        changeSettingAlert.title = @"Scoring Alert!";
        changeSettingAlert.message = @"You have made it to Level 3 and earned an additional life.\n Tap OK to play again.";
        changeSettingAlert.delegate = self;
        [changeSettingAlert addButtonWithTitle:@"OK"];
        
        [changeSettingAlert show];
     */   
        
    }
    
    switch (level) {
        case 1:{
           button1 = [MenuItemImage itemFromNormalImage:@"playAgainButton.png" selectedImage:@"playAgainButton.png" target:self selector:@selector(button1Callback:)];

            break;
        }
        case 2:{
            
            button1 = [MenuItemImage itemFromNormalImage:@"buyFull.png" selectedImage:@"buyFull.png" target:self selector:@selector(button1Callback:)];
            
            //button1 = [MenuItemImage itemFromNormalImage:@"level2.png" selectedImage:@"level2.png" target:self selector:@selector(button1Callback:)];
            
            break;
        }
        case 3:{
            button1 = [MenuItemImage itemFromNormalImage:@"level3.png" selectedImage:@"level3.png" target:self selector:@selector(button1Callback:)];
            
            break;
        }

     //   default:
     //       break;
    }
    
  //  MenuItem *button1 = [MenuItemImage itemFromNormalImage:@"playAgainButton.png" selectedImage:@"playAgainButton.png" target:self selector:@selector(button1Callback:)];
	
    
    MenuItem *button2;
    if (level < 2) {
   button2 = [MenuItemImage itemFromNormalImage:@"changePlayerButton.png" selectedImage:@"changePlayerButton.png" target:self selector:@selector(button2Callback:)];
    }else {
   button2 = [MenuItemImage itemFromNormalImage:@"playAgainButton.png" selectedImage:@"playAgainButton.png" target:self selector:@selector(button2Callback:)];
    }
    
	MenuItem *button3 = [MenuItemImage itemFromNormalImage:@"showLeaderboard.png" selectedImage:@"showLeaderboard.png" target:self selector:@selector(button3Callback:)];
    
    MenuItem *button4 = [MenuItemImage itemFromNormalImage:@"Instructions.png" selectedImage:@"Instructions.png" target:self selector:@selector(button4Callback:)];
  
    MenuItem *button5 = [MenuItemImage itemFromNormalImage:@"gameSettings.png" selectedImage:@"gameSettings.png" target:self selector:@selector(button5Callback:)];

    Menu *menu = [Menu menuWithItems: button1, button2, button3, button4, button5, nil];
    
	[menu alignItemsVerticallyWithPadding:0];
	menu.position = ccp(160,148);
	
	self.isTouchEnabled = YES;
    self.isAccelerometerEnabled = YES;
    
    gameSuspended = YES;
    
 //   [self draw];
    
   // NSLog(@"High Scores");
    
    [self addChild:menu];
    
   	return self;
}



- (void) showOver1000 {
    currentScore = 0;
    [adView release];
    level = 2;
    
    changeSettingAlert = [UIAlertView new];
    changeSettingAlert.title = @"Buy Full Version";
    changeSettingAlert.message = @"You have completed level one successfully. You may tap Buy Full Version or tap Play Again to play level one.";
    changeSettingAlert.delegate = self;
    [changeSettingAlert addButtonWithTitle:@"OK"];
    [changeSettingAlert show];
    
    

}

- (void)dealloc {
//	NSLog(@"Highscores::dealloc");
	[highscores release];
   // [adView release];
	[super dealloc];
    
 //   [self.gameCenterManager release];
}

- (void)loadCurrentPlayer {
//	NSLog(@"loadCurrentPlayer");
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	currentPlayer = nil;
	currentPlayer = [defaults objectForKey:@"player"];
	if(!currentPlayer) {
		currentPlayer = @"Player";
	}

//	NSLog(@"currentPlayer = %@",currentPlayer);
}

- (void)loadHighscores {
//	NSLog(@"loadHighscores");
    
    	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	highscores = nil;
	highscores = [[NSMutableArray alloc] initWithArray: [defaults objectForKey:@"highscores"]];
#ifdef RESET_DEFAULTS	
	[highscores removeAllObjects];
#endif
	if([highscores count] == 0) {
    [highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
	/*	[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
     */
      /*  for (int i = 0;i< highscores.count;i++)
        {
            NSString *player = [highscores objectAtIndex:i];
            //	int score = [[highscores objectAtIndex:2] intValue];
            //    int touches = [[highscores objectAtIndex:1]intValue];
            NSLog(@"highscores: %@ ",player);
        }*/

    }
#ifdef RESET_DEFAULTS	
	[self saveHighscores];
#endif
}

- (void)updateHighscores {
//	NSLog(@"updateHighscores");
	
	currentScorePosition = -1;
	int count = 0;
	for(NSMutableArray *highscore in highscores) {
		int score = [[highscore objectAtIndex:2] intValue];
		
		if(currentScore >= score) {
			currentScorePosition = count;
			break;
		}
		count++;
	}
	
	if(currentScorePosition >= 0) {
		
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
     //   [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
       //     if (localPlayer.isAuthenticated)
         //   {
                // Perform additional tasks for the authenticated player.
                NSString *gcName = [[GKLocalPlayer localPlayer] alias];
          //      NSLog(@"User alias: %@",[[GKLocalPlayer localPlayer]alias]);
        
      //*/ 
      [highscores insertObject:[NSArray arrayWithObjects:currentPlayer,[NSNumber numberWithInt:touches],[NSNumber numberWithInt:currentScore],nil] atIndex:currentScorePosition];
        for (int i = 0;i< highscores.count;i++)
        {
            NSString *player = [highscores objectAtIndex:i];
            //	int score = [[highscores objectAtIndex:2] intValue];
            //    int touches = [[highscores objectAtIndex:1]intValue];
          //  NSLog(@"highscores: %@ ",player);
        }

        [highscores removeLastObject];
                
      //  [self.gameCenterManager reportScore:currentScore forCategory:@"2"];
        
		
           /* }else{
                [highscores insertObject:[NSArray arrayWithObjects:currentPlayer,[NSNumber numberWithInt:touches],[NSNumber numberWithInt:currentScore],nil] atIndex:currentScorePosition];
                [highscores removeLastObject];
            }*/
       // }];
	}


      [self.gameCenterManager reportScore:currentScore forCategory: @"3"];
}

- (void)saveCurrentPlayer {
//	NSLog(@"saveCurrentPlayer");
//	NSLog(@"currentPlayer = %@",currentPlayer);
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:currentPlayer forKey:@"player"];
}

- (void)saveHighscores {
//	NSLog(@"saveHighscores");
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:highscores forKey:@"highscores"];
    

    [self.gameCenterManager reportScore:currentScore forCategory:@"3"];
}
- (void) showLeaderboard
{
	UIViewController *tempVC=[[UIViewController alloc] init];
    
	GKLeaderboardViewController *leaderboardController = [[[GKLeaderboardViewController alloc] init] autorelease];
	if (leaderboardController != nil)
	{
		leaderboardController.leaderboardDelegate = self;
		[[[Director sharedDirector] openGLView] addSubview:tempVC.view];
		[tempVC presentModalViewController:leaderboardController animated:YES];
	}
    
 //   [tempVC dismissModalViewControllerAnimated:NO];
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController2
{
	[viewController2 dismissModalViewControllerAnimated:YES];
//	[viewController2 release];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        bannerIsVisible = YES;
        [adView setHidden:NO];
        
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        banner.frame = CGRectOffset(banner.frame, 0, 520);
        [UIView commitAnimations];
        bannerIsVisible = NO;
    }
}


- (void)button1Callback:(id)sender {
//	NSLog(@"button1Callback");

    isAccelerometerEnabled = NO;	
  //  NSLog(@"At Main Menu");
    switch (level) {
        case 1:
        { 
       /*     [clickAudio release];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];   
            clickAudio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
            clickAudio.volume = 18;
            [clickAudio play];*/
            
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app.clickAudio play];
            
            sleep(1);
            
            Game *gameInstructions = [[Game alloc] init];
            Scene *scene = [Scene node];
            [scene removeChild:gameInstructions cleanup:YES];
            scene = [[Scene node] addChild:gameInstructions z:4];
            [gameInstructions release];
            
               
        //    if (adView.bannerLoaded) { 
            [adView setHidden:YES];    
            [adView removeFromSuperview];
            [adView release];
            
          //  }
            
          //  bannerIsVisible = YES;
           
            [[Director sharedDirector] replaceScene:scene];
        //    NSLog(@"Main game");
            break;
        }   
        case 2:
        {
          /*  [clickAudio release];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];   
            clickAudio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
            clickAudio.volume = 18;
            [clickAudio play];*/
            
            [adView setHidden:YES];    
            [adView removeFromSuperview];
            [adView release];

            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://itunes.apple.com/us/app/dancin-chopstix/id516638908?mt=8"]];
            
           /* AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app.clickAudio play];
            
            GameLevel5 *gameInstructions = [[GameLevel5 alloc] initWithScore:currentScore];            
            Scene *scene2 = [Scene node];
            [scene2 removeChild:gameInstructions cleanup:YES];
            scene2 = [[Scene node] addChild:gameInstructions z:4];
            //  TransitionScene *ts = [FadeTransition transitionWithDuration:0.5f scene:scene withColorRGB:0xffffff];
            [gameInstructions release];
            [[Director sharedDirector] replaceScene:scene2];
        //    NSLog(@"Level 2 game");
            break;
            */
        }
        case 3:
        {
         /*   [clickAudio release];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];   
            clickAudio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
            clickAudio.volume = 18;
            [clickAudio play];*/
            
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app.clickAudio play];
            
            GameLevel4 *gameInstructions = [[GameLevel4 alloc] initWithScore:currentScore];            
            Scene *scene = [Scene node];
            [scene removeChild:gameInstructions cleanup:YES];
            scene = [[Scene node] addChild:gameInstructions z:4];
      //      TransitionScene *ts = [FadeTransition transitionWithDuration:0.5f scene:scene withColorRGB:0xffffff];
            [gameInstructions release];
            [[Director sharedDirector] replaceScene:scene];
          //   NSLog(@"Level 3 game");
            break;
        }
        default:
            break;
            
    }
}

- (void)button2Callback:(id)sender {
//	NSLog(@"button2Callback");
    
      
/*	[clickAudio release];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];   
    clickAudio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    clickAudio.volume = 18;
    [clickAudio play];*/
    
    if (level > 1) {
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.clickAudio play];
    
    sleep(1);
    
    Game *gameInstructions = [[Game alloc] init];
    Scene *scene = [Scene node];
    [scene removeChild:gameInstructions cleanup:YES];
    scene = [[Scene node] addChild:gameInstructions z:4];
    [gameInstructions release];
    
    
  //  if (adView.bannerLoaded) { 
        [adView setHidden:YES];    
        [adView removeFromSuperview];
        [adView release];
        
   // }
    
  //  bannerIsVisible = YES;
    
    [[Director sharedDirector] replaceScene:scene];
    //    NSLog(@"Main game");
  //  break;
    }else {
    
   AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.clickAudio play];

    changePlayerAlert = [UIAlertView new];
	changePlayerAlert.title = @"Change Name";
	changePlayerAlert.message = @"\n";
	changePlayerAlert.delegate = self;
	[changePlayerAlert addButtonWithTitle:@"Save"];
	[changePlayerAlert addButtonWithTitle:@"Cancel"];

	changePlayerTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 45, 245, 27)];
	changePlayerTextField.borderStyle = UITextBorderStyleRoundedRect;
	[changePlayerAlert addSubview:changePlayerTextField];
//	changePlayerTextField.placeholder = @"Enter your name";
//	changePlayerTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	changePlayerTextField.keyboardType = UIKeyboardTypeDefault;
	changePlayerTextField.returnKeyType = UIReturnKeyDone;
	changePlayerTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	changePlayerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	changePlayerTextField.delegate = self;
	[changePlayerTextField becomeFirstResponder];

	[changePlayerAlert show];
        
    }
     
 
}
- (void)button3Callback:(id)sender {
    //	NSLog(@"button2Callback");
    
  /*  [clickAudio release];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];   
    clickAudio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    clickAudio.volume = 18;
    [clickAudio play];*/
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.clickAudio play];

    [self showLeaderboard];
	
   }

- (void)button4Callback:(id)sender {
    //	NSLog(@"button2Callback");
    
    if (adView.bannerLoaded){
        [adView removeFromSuperview];
        [adView release];
   
    }
 //   gameSuspended = YES;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.clickAudio play];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [[TouchDispatcher sharedDispatcher] removeEventHandler:self];
    
    GameInstructions *gameInstructions = [[GameInstructions alloc] initWithScore:4032];
    
    Scene *scene = [[Scene node] addChild:gameInstructions z:-1];
	

    [[Director sharedDirector] replaceScene:[FadeUpTransition transitionWithDuration:0.5f scene:scene]];
    
    
    	
}
- (void)button5Callback:(id)sender {
    //	NSLog(@"button2Callback");
   
    if (adView.bannerLoaded) {
    [adView removeFromSuperview];
    [adView release];
    
    }
    
    //   gameSuspended = YES;
	/*[clickAudio release];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];   
    clickAudio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    clickAudio.volume = 18;
    [clickAudio play];*/
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.clickAudio play];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [[TouchDispatcher sharedDispatcher] removeEventHandler:self];
    
    GameSettings *gameInstructions = [[GameSettings alloc] initWithScore:4032];
    
    Scene *scene = [[Scene node] addChild:gameInstructions z:-1];
	
    
    [[Director sharedDirector] replaceScene:[FadeUpTransition transitionWithDuration:0.5f scene:scene]];
    
}
- (void) onTransitionDidFinish {
   
    if (level > 1)
        return;
    
    UIViewController *controller = [[UIViewController alloc] init];
    
    BOOL bannerRes = adView.bannerLoaded;
    intRet = adView.retainCount;
    NSLog(@"intRet: %u",intRet);
    
    if (!adView.bannerLoaded) {
        adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
        adView.frame = CGRectOffset(adView.frame, 0, 460);
        //  adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifier320x50];
        adView.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifier320x50,ADBannerContentSizeIdentifier480x32,nil];
        //    adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
        [controller.view addSubview:adView];
        adView.delegate=self;
        bannerIsVisible=NO;
        [adView setHidden:YES];
    }
    
    
    //Then I add the adView to the openglview of cocos2d
    [[[Director sharedDirector] openGLView] addSubview:controller.view];	
}

- (void)draw {
//	NSLog(@"draw");

	if(currentScorePosition < 0) return;
	
	glColor4ub(50,0,0,50);

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
	
	glDrawElements(GL_TRIANGLE_STRIP, 4, GL_UNSIGNED_BYTE, indices);
	
	glDisableClientState(GL_VERTEX_ARRAY);	
}

- (void)changePlayerDone {
	currentPlayer = [changePlayerTextField.text retain];
	[self saveCurrentPlayer];
	if(currentScorePosition >= 0) {
		[highscores removeObjectAtIndex:currentScorePosition];
		[highscores addObject:[NSArray arrayWithObjects:@"Player",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[self saveHighscores];
		Highscores *h = [[Highscores alloc] initWithScore:currentScore];
		Scene *scene = [[Scene node] addChild:h z:0];
		[[Director sharedDirector] replaceScene:[FadeTransition transitionWithDuration:1 scene:scene withColorRGB:0xffffff]];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//	NSLog(@"alertView:clickedButtonAtIndex: %i",buttonIndex);
	
	if(buttonIndex == 0) {
		[self changePlayerDone];
	} else {
		// nothing
	}
}
- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration {
	
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//	NSLog(@"textFieldShouldReturn");
	[changePlayerAlert dismissWithClickedButtonIndex:0 animated:YES];
	[self changePlayerDone];
	return YES;
}

@end
