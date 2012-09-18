#import "GameSettings.h"
#import "Main.h"
#import "Highscores.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Scene.h"
#import "GameCenterManager.h"
#import "Game.h"
#import "AppDelegate.h"
#import "Event.h"
#import "GameStory.h"

extern NSString *sound;
extern NSString *music;
extern NSString *flip;

@interface GameSettings (Private)

@end



@implementation GameSettings

@synthesize clickAudio;

- (id)initWithScore:(int)lastScore {
    //	NSLog(@"Highscores::init");
	
	if(![super init]) return nil;
    
  	
	AtlasSpriteManager *spriteManager = (AtlasSpriteManager*)[self getChildByTag:kSpriteManager];
	
    AtlasSprite *titleMain = [AtlasSprite spriteWithRect:CGRectMake(6,263,275,47) spriteManager:spriteManager];
	[spriteManager addChild:titleMain z:5];
	titleMain.position = ccp(165,440);
    
    AtlasSprite *titleMain2 = [AtlasSprite spriteWithRect:CGRectMake(142,228,163,40) spriteManager:spriteManager];
	[spriteManager addChild:titleMain2 z:5];
	titleMain2.position = ccp(160,402);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];   
    clickAudio =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];   
    clickAudio.volume = 18;
    
  /*  Sprite *details = [Sprite spriteWithFile:@"instructionDetails.png"];
    details.position = ccp(155,278);
    [self addChild:details];
   */
	
  /*  AtlasSprite *title = [AtlasSprite spriteWithRect:CGRectMake(333,418,355,37) spriteManager:spriteManager];
	[spriteManager addChild:title z:5];
	title.position = ccp(189,400);
    */
    
    
    MenuItem *button0 = [MenuItemImage itemFromNormalImage:@"storyButton.png" selectedImage:@"storyButton.png" target:self selector:@selector(button0Callback:)];

    
    MenuItem *button1 = [MenuItemImage itemFromNormalImage:@"musicOff.png" selectedImage:@"musicOff.png" target:self selector:@selector(button1Callback:)];
	
    MenuItem *button2 = [MenuItemImage itemFromNormalImage:@"musicOn.png" selectedImage:@"musicOn.png" target:self selector:@selector(button2Callback:)];
    
    
    MenuItem *button3 = [MenuItemImage itemFromNormalImage:@"TL.png" selectedImage:@"TL.png" target:self selector:@selector(button3Callback:)];
    
    MenuItem *button4 = [MenuItemImage itemFromNormalImage:@"BL.png" selectedImage:@"BL.png" target:self selector:@selector(button4Callback:)];
    
    MenuItem *button5 = [MenuItemImage itemFromNormalImage:@"TR.png" selectedImage:@"TR.png" target:self selector:@selector(button5Callback:)];
    
    MenuItem *button6 = [MenuItemImage itemFromNormalImage:@"BR.png" selectedImage:@"BR.png" target:self selector:@selector(button6Callback:)];
    
     MenuItem *button7 = [MenuItemImage itemFromNormalImage:@"goBack.png" selectedImage:@"goBack.png" target:self selector:@selector(button7Callback:)];
    
 //   MenuItem *button4 = [MenuItemImage itemFromNormalImage:@"Instructions.png" selectedImage:@"Instructions.png" target:self selector:@selector(button4Callback:)];
    

    Menu *menu = [Menu menuWithItems: button0,button1,button2, button3, button4, button5, button6, button7, nil];
    
	[menu alignItemsVerticallyWithPadding:0];
	 menu.position = ccp(160,210);
	
	[self addChild:menu];
 
	
	return self;
}

- (void)button0Callback:(id)sender {
    //	NSLog(@"button2Callback");
    
    [self readAnimalsFromDatabase8];
    
    [clickAudio play];
    GameStory *gameInstructions = [[GameStory alloc] initWithScore:0];
    
	Scene *scene = [[Scene node] addChild:gameInstructions z:-1];
	
    [[Director sharedDirector] pushScene:scene];
    
    [gameInstructions release];
    
}


- (void)button1Callback:(id)sender {
    //	NSLog(@"button2Callback");
    
    [clickAudio play];
    music = @"OFF";
    changeSettingAlert = [UIAlertView new];
	changeSettingAlert.title = @"Change Setting";
	changeSettingAlert.message = @"Music is now Off\n";
	changeSettingAlert.delegate = self;
	[changeSettingAlert addButtonWithTitle:@"OK"];
    
    [changeSettingAlert show];
  
}
- (void)button2Callback:(id)sender {
    //	NSLog(@"button2Callback");
    
    [clickAudio play]; 
    music = @"ON";
    changeSettingAlert = [UIAlertView new];
	changeSettingAlert.title = @"Change Setting";
	changeSettingAlert.message = @"Music is now On\n";
	changeSettingAlert.delegate = self;
	[changeSettingAlert addButtonWithTitle:@"OK"];
    
    [changeSettingAlert show];
    
}

- (void)button3Callback:(id)sender {
    [clickAudio play];
    flip = @"TL";
    changeSettingAlert = [UIAlertView new];
	changeSettingAlert.title = @"Change Setting";
	changeSettingAlert.message = @"Thrust button is now on top left\n";
	changeSettingAlert.delegate = self;
	[changeSettingAlert addButtonWithTitle:@"OK"];
    
    [changeSettingAlert show];

}
- (void)button4Callback:(id)sender {
    [clickAudio play];
    flip = @"BL";
    changeSettingAlert = [UIAlertView new];
	changeSettingAlert.title = @"Change Setting";
	changeSettingAlert.message = @"Thrust button is now on bottom left\n";
	changeSettingAlert.delegate = self;
	[changeSettingAlert addButtonWithTitle:@"OK"];
    
    [changeSettingAlert show];
}
- (void)button5Callback:(id)sender {
    [clickAudio play];
    flip = @"TR";
    changeSettingAlert = [UIAlertView new];
	changeSettingAlert.title = @"Change Setting";
	changeSettingAlert.message = @"Thrust button is now on top right\n";
	changeSettingAlert.delegate = self;
	[changeSettingAlert addButtonWithTitle:@"OK"];
    
    [changeSettingAlert show];
}
- (void)button6Callback:(id)sender {
    [clickAudio play];
    flip = @"BR";
    changeSettingAlert = [UIAlertView new];
	changeSettingAlert.title = @"Change Setting";
	changeSettingAlert.message = @"Thrust button is now on bottom right\n";
	changeSettingAlert.delegate = self;
	[changeSettingAlert addButtonWithTitle:@"OK"];
    
    [changeSettingAlert show];
}
- (void)button7Callback:(id)sender {
    //	NSLog(@"button2Callback");
    
    [self readAnimalsFromDatabase8];
    
    [clickAudio play];
    Highscores *gameInstructions = [[Highscores alloc] initWithScore:0];
    
	Scene *scene = [[Scene node] addChild:gameInstructions z:-1];
	
    [[Director sharedDirector] pushScene:scene];
    
    [gameInstructions release];
    
}

- (void) readAnimalsFromDatabase8  {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSString *databaseName;
	NSString *databasePath;

	
	// Setup some globals
	databaseName = @"localCal.rdb";
    
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	    
    databasePath = [documentsDir stringByAppendingPathComponent:@"localCal.rdb"];
    NSLog(databasePath);
	
	// Setup the database object
	sqlite3 *database;
	
	// Init the animals Array
	NSMutableArray *animals = [[NSMutableArray alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        
      //  NSLog(@"appDelegate.UserID:%@",appDelegate.UserID);
        
   //     [self readAnimalsFromDatabase9];
     
        //    Event *animal = [animals objectAtIndex:0];
            
       //     NSLog(@"animal.english:%@",animal.english);
            
      //      if ([animal.english isEqualToString:@""])
      //          return;
            
          //  const char *sqlStatement = [[NSString stringWithFormat:@"INSERT INTO localUser (localUserID, localUserLoginName) values ('%@','%@')",userNum.text,loginName.text] UTF8String];
        
        const char *sqlStatement = [[NSString stringWithFormat:@"Update localUser set buttonOrientation = '%@', music = '%@' where serial = 1",flip,music] UTF8String];
            
            NSLog([NSString stringWithUTF8String:sqlStatement]);
            //	const char *sqlStateignment = "select * from events where eventdate = '2011-03-11'";
            NSString *temps = [NSString stringWithUTF8String:sqlStatement];
            NSLog(@"%@",temps);
            sqlite3_stmt *compiledStatement;
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
                
            {
                
                // Loop through the results and add them to the feeds array
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    
                    // Read the data from the result row
                    NSString *aUserLogin = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                    NSString *aUserPassword = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                    
                    // aUserPassword actually represents loginName in this case
             //       loginName.text = aUserPassword;
                    
                    NSString *aUserNameFirst = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                    NSString *aUserNameLast = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                    NSString *aUserEmail = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                    NSString *aSubID1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                    NSString *aSubID2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                    
                    // Create a new event object with the data from the database
                    Event *animal = [[Event alloc] initWithName:aUserLogin description:aUserPassword url:aUserNameFirst url:aUserNameLast written:aUserEmail category:aSubID1 category2:aSubID2 image:aSubID2];
                    
                    // Add the animal object to the animals Array
                    [animals addObject:animal];				
                    [animal release];
                    
                }
            }
        }else{
            return;
        }
}
    

- (void) readAnimalsFromDatabase9  {
    
    NSString *databaseName;
	NSString *databasePath;
	
	// Setup some globals
	databaseName = @"localCal.rdb";
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	
    databasePath = [documentsDir stringByAppendingPathComponent:@"localCal.rdb"];
	
	// Setup the database object
	sqlite3 *database;
	
	// Init the animals Array
	NSMutableArray *animals = [[NSMutableArray alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        
        const char *sqlStatement = [[NSString stringWithFormat:@"select serial, localUserID, localUserLoginName, buttonOrientation, music from localUser"] UTF8String];
        
        
		NSLog([NSString stringWithUTF8String:sqlStatement]);
        NSString *temps = [NSString stringWithUTF8String:sqlStatement];
		NSLog(@"%@",temps);
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				
				// Read the data from the result row
				NSString *aUserLogin = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                
                //     appDelegate.UserID = aUserLogin;
                
                NSString *aUserPassword = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *aUserNameFirst = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *aUserNameLast = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				NSString *aUserEmail = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				NSString *aSubID1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				NSString *aSubID2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                
				// Create a new event object with the data from the database
				Event *animal = [[Event alloc] initWithName:aUserLogin description:aUserPassword url:aUserNameFirst url:aUserNameLast written:aUserEmail category:aSubID1 category2:aSubID2 image:aSubID2];
                
				// Add the animal object to the animals Array
				[animals addObject:animal];				
				[animal release];
				
				
			}
		}
	}
	/*if ([appDelegate.UserID isEqualToString:nil]){
     
     //run login screen
     [self loadLogin];
     }*/
    
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
    [changeSettingAlert dealloc];
}


@end
