#import "Highscores2.h"
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
//#import "Game_CenterViewController.m"


@interface Highscores2 (Private)
- (void)loadCurrentPlayer;
- (void)loadHighscores;
- (void)updateHighscores;
- (void)saveCurrentPlayer;
- (void)saveHighscores;
- (void)button1Callback:(id)sender;
- (void)button2Callback:(id)sender;
@end

extern int touches;
extern int level;
MenuItem *button1;
extern BOOL gameSuspended;


@implementation Highscores2

@synthesize gameCenterManager, viewController, window;
@synthesize currentScore;
@synthesize currentLeaderBoard;
//@synthesize currentScoreLabel;

- (id)initWithScore:(int)lastScore {
//	NSLog(@"Highscores::init");
	
	if(![super init]) return nil;
    
    self->window.rootViewController = self.viewController;

//	NSLog(@"lastScore = %d",lastScore);
	
	currentScore = lastScore - (touches * 1000);

//	NSLog(@"currentScore = %d",currentScore);
	
	if ([GameCenterManager isGameCenterAvailable]) {
		
		self.gameCenterManager = [[[GameCenterManager alloc] init] autorelease];
//		[self.gameCenterManager setDelegate:self];
		[self.gameCenterManager authenticateLocalUser];
		
		
	} else {
		
		// The current device does not support Game Center.
        
	}

    
    [self loadCurrentPlayer];
	[self loadHighscores];
	[self updateHighscores];
	if(currentScorePosition >= 0) {
		[self saveHighscores];
	}
	
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	
    AtlasSprite *titleMain = [AtlasSprite spriteWithRect:CGRectMake(3,264,272,42) spriteManager:spriteManager];
	[spriteManager addChild:titleMain z:5];
	titleMain.position = ccp(145,442);
	
    AtlasSprite *title = [AtlasSprite spriteWithRect:CGRectMake(297,180,355,40) spriteManager:spriteManager];
	[spriteManager addChild:title z:5];
	title.position = ccp(172,400);
    
    Label *label01 = [Label labelWithString:[NSString stringWithFormat:@"Gross score: %d - %d =  Net: %d",lastScore,(touches * 1000),currentScore] dimensions:CGSizeMake(250,40) alignment:UITextAlignmentRight fontName:@"Arial" fontSize:12];
    [self addChild:label01 z:5];
    [label01 setRGB:0 :0 :0];
    [label01 setOpacity:200];
    label01.position = ccp(150, 395);

	float start_y = 360.0f;
	float step = 27.0f;
	int count = 0;
    for (int i = 0;i< highscores.count;i++)
    {
        NSString *player = [highscores objectAtIndex:i];
	//	int score = [[highscores objectAtIndex:2] intValue];
    //    int touches = [[highscores objectAtIndex:1]intValue];
        NSLog(@"highscores: %@ ",player);
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

	
    
    switch (level) {
        case 1:{
           button1 = [MenuItemImage itemFromNormalImage:@"playAgainButton.png" selectedImage:@"playAgainButton.png" target:self selector:@selector(button1Callback:)];

            break;
        }
        case 2:{
            button1 = [MenuItemImage itemFromNormalImage:@"level2.png" selectedImage:@"level2.png" target:self selector:@selector(button1Callback:)];
            
            break;
        }
        case 3:{
            button1 = [MenuItemImage itemFromNormalImage:@"level3.png" selectedImage:@"level3.png" target:self selector:@selector(button1Callback:)];
            
            break;
        }

        default:
            break;
    }
    
  //  MenuItem *button1 = [MenuItemImage itemFromNormalImage:@"playAgainButton.png" selectedImage:@"playAgainButton.png" target:self selector:@selector(button1Callback:)];
	
    
    
    
    MenuItem *button2 = [MenuItemImage itemFromNormalImage:@"changePlayerButton.png" selectedImage:@"changePlayerButton.png" target:self selector:@selector(button2Callback:)];

	MenuItem *button3 = [MenuItemImage itemFromNormalImage:@"showLeaderboard.png" selectedImage:@"showLeaderboard.png" target:self selector:@selector(button3Callback:)];
    
    MenuItem *button4 = [MenuItemImage itemFromNormalImage:@"Instructions.png" selectedImage:@"Instructions.png" target:self selector:@selector(button4Callback:)];
  
    MenuItem *button5 = [MenuItemImage itemFromNormalImage:@"gameSettings.png" selectedImage:@"gameSettings.png" target:self selector:@selector(button5Callback:)];

	Menu *menu = [Menu menuWithItems: button1, button2, button3, button4, button5, nil];

	[menu alignItemsVerticallyWithPadding:2];
	menu.position = ccp(160,138);
	
	self.isTouchEnabled = YES;
    self.isAccelerometerEnabled = YES;
    
    gameSuspended = YES;
    
    [self draw];
    
    [self addChild:menu];
	
	return self;
}

- (void)dealloc {
//	NSLog(@"Highscores::dealloc");
	[highscores release];
	[super dealloc];
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
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
		[highscores addObject:[NSArray arrayWithObjects:@"None",[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil]];
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
            NSLog(@"highscores: %@ ",player);
        }

        [highscores removeLastObject];
                
      //  [self.gameCenterManager reportScore:currentScore forCategory:@"2"];
        
		
           /* }else{
                [highscores insertObject:[NSArray arrayWithObjects:currentPlayer,[NSNumber numberWithInt:touches],[NSNumber numberWithInt:currentScore],nil] atIndex:currentScorePosition];
                [highscores removeLastObject];
            }*/
       // }];
	}


      [self.gameCenterManager reportScore:currentScore forCategory: @"2"];
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
    

    [self.gameCenterManager reportScore:currentScore forCategory:@"2"];
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



- (void)button1Callback:(id)sender {
//	NSLog(@"button1Callback");

    isAccelerometerEnabled = NO;
	
    
    switch (level) {
        case 1:
        { 
            Game *gameInstructions = [[Game alloc] init];            
            Scene *scene = [[Scene node] addChild:gameInstructions z:4];
           // TransitionScene *ts = [FadeTransition transitionWithDuration:0.5f scene:scene withColorRGB:0xffffff];
            [[Director sharedDirector] pushScene:scene];
            
            break;
        }   
        case 2:
        {
            GameLevel5 *gameInstructions2 = [[GameLevel5 alloc] initWithScore:currentScore];            
            Scene *scene2 = [[Scene node] addChild:gameInstructions2 z:4];
            //  TransitionScene *ts = [FadeTransition transitionWithDuration:0.5f scene:scene withColorRGB:0xffffff];
            [[Director sharedDirector] pushScene:scene2];
            break;
        }
        case 3:
        {
            GameLevel4 *gameInstructions = [[GameLevel4 alloc] initWithScore:currentScore];            
            Scene *scene = [[Scene node] addChild:gameInstructions z:4];
      //      TransitionScene *ts = [FadeTransition transitionWithDuration:0.5f scene:scene withColorRGB:0xffffff];
            [[Director sharedDirector] pushScene:scene];
            break;
        }
        default:
            break;
            
    }
}

- (void)button2Callback:(id)sender {
//	NSLog(@"button2Callback");
    
      
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
- (void)button3Callback:(id)sender {
    //	NSLog(@"button2Callback");
    
    [self showLeaderboard];
	
   }

- (void)button4Callback:(id)sender {
    //	NSLog(@"button2Callback");
    
  
 //   gameSuspended = YES;
	[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [[TouchDispatcher sharedDispatcher] removeEventHandler:self];
    
    GameInstructions *gameInstructions = [[GameInstructions alloc] initWithScore:4032];
    
    Scene *scene = [[Scene node] addChild:gameInstructions z:-1];
	

    [[Director sharedDirector] replaceScene:[FadeUpTransition transitionWithDuration:0.5f scene:scene]];
    
    
    	
}
- (void)button5Callback:(id)sender {
    //	NSLog(@"button2Callback");
    
    
    //   gameSuspended = YES;
	[[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [[TouchDispatcher sharedDispatcher] removeEventHandler:self];
    
    GameSettings *gameInstructions = [[GameSettings alloc] initWithScore:4032];
    
    Scene *scene = [[Scene node] addChild:gameInstructions z:-1];
	
    
    [[Director sharedDirector] replaceScene:[FadeUpTransition transitionWithDuration:0.5f scene:scene]];
    
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//	NSLog(@"textFieldShouldReturn");
	[changePlayerAlert dismissWithClickedButtonIndex:0 animated:YES];
	[self changePlayerDone];
	return YES;
}

@end
