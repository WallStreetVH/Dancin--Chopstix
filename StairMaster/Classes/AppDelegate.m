#import "AppDelegate.h"
#import "Game.h"
#import "Main.h"
#import "cocos2d.h"
#import "Event.h"

extern BOOL gameSuspended;
extern NSString *music;
extern NSString *flip;

@implementation AppDelegate

@synthesize gameLoop,gameLoop2, gameLoop3, screamAudio,splashAudio,thrustAudio,bombAudio,cashAudio,cashAudio2,angelAudio;
@synthesize level1Audio, level2Audio, level3Audio, beepsAudio, jumpAudio, gruntAudio, winAudio, clickAudio, shotAudio, bloodAudio, gongAudio, newlifeAudio;

- (void)applicationDidFinishLaunching:(UIApplication *)application {

	[application setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];

	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window setUserInteractionEnabled:YES];
	[window setMultipleTouchEnabled:YES];	

	[[Director sharedDirector] setPixelFormat:kRGBA8];
	[[Director sharedDirector] attachInWindow:window];
//	[[Director sharedDirector] setDisplayFPS:YES];
	[[Director sharedDirector] setAnimationInterval:1.0/kFPS];
//    [[Director sharedDirector] setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
 
	[Texture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA8888]; 
    
    
/*    NSString *model = [self getModel];
    NSLog(@"Device model: %@",model);
    if ([model isEqualToString:@"iPhone3G"] || [model isEqualToString:@"iPhone1G"]  ){
        
        
        changeSettingAlert = [UIAlertView new];
        changeSettingAlert.title = @"Notice";
        changeSettingAlert.message = @"You are using an iPhone 3G or older. iPhones less than 3GS may experience slower game play. Also, Game Center is not available for this model.";
        changeSettingAlert.delegate = self;
        [changeSettingAlert addButtonWithTitle:@"OK"];
        
        [changeSettingAlert show];
      
        
    }*/
    
    [self getModel];
    
    NSString *path38 = [[NSBundle mainBundle] pathForResource:@"gong2" ofType:@"aiff"];
    NSURL *path39 = [[NSURL alloc] initFileURLWithPath:path38];
    gongAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path39 error:NULL];
    //    winAudio.numberOfLoops = -1;
    gongAudio.volume = 6;
    [gongAudio setDelegate:self];
    [gongAudio prepareToPlay];
    [gongAudio play];
    sleep(2);
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"manic" ofType:@"mp3"];
    NSURL *path3 = [[NSURL alloc] initFileURLWithPath:path2];
    gameLoop=[[AVAudioPlayer alloc] initWithContentsOfURL:path3 error:NULL];
    gameLoop.numberOfLoops = -1;
    [gameLoop setDelegate:self];
    [gameLoop prepareToPlay];
    
    NSString *path0 = [[NSBundle mainBundle] pathForResource:@"manic2" ofType:@"mp3"];
    NSURL *path1 = [[NSURL alloc] initFileURLWithPath:path0];
    gameLoop2=[[AVAudioPlayer alloc] initWithContentsOfURL:path1 error:NULL];
    gameLoop2.numberOfLoops = -1;
    gameLoop2.volume = 1;
    [gameLoop2 setDelegate:self];
    [gameLoop2 prepareToPlay];
    
    NSString *path01 = [[NSBundle mainBundle] pathForResource:@"manic4" ofType:@"mp3"];
    NSURL *path02 = [[NSURL alloc] initFileURLWithPath:path01];
    gameLoop3=[[AVAudioPlayer alloc] initWithContentsOfURL:path02 error:NULL];
    gameLoop3.numberOfLoops = -1;
    [gameLoop3 setDelegate:self];
    [gameLoop3 prepareToPlay];
    
    NSString *path4 = [[NSBundle mainBundle] pathForResource:@"scream" ofType:@"wav"];
    NSURL *path5 = [[NSURL alloc] initFileURLWithPath:path4];
    screamAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path5 error:NULL];
 //   screamAudio.numberOfLoops = -1;
    screamAudio.volume = 3;
    [screamAudio setDelegate:self];
    [screamAudio prepareToPlay];
    
    NSString *path6 = [[NSBundle mainBundle] pathForResource:@"splash" ofType:@"wav"];
    NSURL *path7 = [[NSURL alloc] initFileURLWithPath:path6];
    splashAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path7 error:NULL];
 //   splashAudio.numberOfLoops = -1;
    splashAudio.volume = 3;
    [splashAudio setDelegate:self];
    [splashAudio prepareToPlay];
    
    NSString *path8 = [[NSBundle mainBundle] pathForResource:@"shield2" ofType:@"wav"];
    NSURL *path9 = [[NSURL alloc] initFileURLWithPath:path8];
    thrustAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path9 error:NULL];
//    thrustAudio.numberOfLoops = -1;
    thrustAudio.volume = 2;
    [thrustAudio setDelegate:self];
    [thrustAudio prepareToPlay];
    
    NSString *path10 = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"wav"];
    NSURL *path11 = [[NSURL alloc] initFileURLWithPath:path10];
    bombAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path11 error:NULL];
//    bombAudio.numberOfLoops = -1;
    [bombAudio setDelegate:self];
    [bombAudio prepareToPlay];

    NSString *path12 = [[NSBundle mainBundle] pathForResource:@"chime2" ofType:@"wav"];
    NSURL *path13 = [[NSURL alloc] initFileURLWithPath:path12];
    cashAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path13 error:NULL];
//    cashAudio.numberOfLoops = -1;
    cashAudio.volume = 3;
    [cashAudio setDelegate:self];
    [cashAudio prepareToPlay];

    NSString *path14 = [[NSBundle mainBundle] pathForResource:@"chime2" ofType:@"wav"];
    NSURL *path15 = [[NSURL alloc] initFileURLWithPath:path14];
    cashAudio2=[[AVAudioPlayer alloc] initWithContentsOfURL:path15 error:NULL];
//    cashAudio2.numberOfLoops = -1;
    cashAudio2.volume = 3;
    [cashAudio2 setDelegate:self];
    [cashAudio2 prepareToPlay];
    
    NSString *path16 = [[NSBundle mainBundle] pathForResource:@"bell" ofType:@"wav"];
    NSURL *path17 = [[NSURL alloc] initFileURLWithPath:path16];
    angelAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path17 error:NULL];
//    angelAudio.numberOfLoops = -1;
    angelAudio.volume = 2;
    [angelAudio setDelegate:self];
    [angelAudio prepareToPlay];
    
    NSString *path18 = [[NSBundle mainBundle] pathForResource:@"level1" ofType:@"wav"];
    NSURL *path19 = [[NSURL alloc] initFileURLWithPath:path18];
    level1Audio=[[AVAudioPlayer alloc] initWithContentsOfURL:path19 error:NULL];
    level1Audio.numberOfLoops = 0;
    [level1Audio setDelegate:self];
    level1Audio.volume = 10;
    [level1Audio prepareToPlay];

    NSString *path20 = [[NSBundle mainBundle] pathForResource:@"level2" ofType:@"wav"];
    NSURL *path21 = [[NSURL alloc] initFileURLWithPath:path20];
    level2Audio=[[AVAudioPlayer alloc] initWithContentsOfURL:path21 error:NULL];
//    level2Audio.numberOfLoops = -1;
    level2Audio.volume = 10;
    [level2Audio setDelegate:self];
    [level2Audio prepareToPlay];
    
    NSString *path22 = [[NSBundle mainBundle] pathForResource:@"beeps" ofType:@"mp3"];
    NSURL *path23 = [[NSURL alloc] initFileURLWithPath:path22];
    beepsAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path23 error:NULL];
//    beepsAudio.numberOfLoops = -1;
    beepsAudio.volume = 3;
    [beepsAudio setDelegate:self];
    [beepsAudio prepareToPlay];

    NSString *path24 = [[NSBundle mainBundle] pathForResource:@"ScannerBeep" ofType:@"wav"];
    NSURL *path25 = [[NSURL alloc] initFileURLWithPath:path24];
    jumpAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path25 error:NULL];
//    jumpAudio.numberOfLoops = -1;
    jumpAudio.volume = 2;
    [jumpAudio setDelegate:self];
    [jumpAudio prepareToPlay];

    
    NSString *path26 = [[NSBundle mainBundle] pathForResource:@"grunt" ofType:@"wav"];
    NSURL *path27 = [[NSURL alloc] initFileURLWithPath:path26];
    gruntAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path27 error:NULL];
//    gruntAudio.numberOfLoops = -1;
    gruntAudio.volume = 2;
    [gruntAudio setDelegate:self];
    [gruntAudio prepareToPlay];

    
    NSString *path28 = [[NSBundle mainBundle] pathForResource:@"win" ofType:@"wav"];
    NSURL *path29 = [[NSURL alloc] initFileURLWithPath:path28];
    winAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path29 error:NULL];
//    winAudio.numberOfLoops = -1;
    winAudio.volume = 3;
    [winAudio setDelegate:self];
    [winAudio prepareToPlay];
    
    NSString *path30 = [[NSBundle mainBundle] pathForResource:@"level3" ofType:@"wav"];
    NSURL *path31 = [[NSURL alloc] initFileURLWithPath:path30];
    level3Audio=[[AVAudioPlayer alloc] initWithContentsOfURL:path31 error:NULL];
    //    winAudio.numberOfLoops = -1;
    level3Audio.volume = 10;
    [level3Audio setDelegate:self];
    [level3Audio prepareToPlay];

    NSString *path32 = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];
    NSURL *path33 = [[NSURL alloc] initFileURLWithPath:path32];
    clickAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path33 error:NULL];
    //    winAudio.numberOfLoops = -1;
    clickAudio.volume = 10;
    [clickAudio setDelegate:self];
    [clickAudio prepareToPlay];
    
    NSString *path34 = [[NSBundle mainBundle] pathForResource:@"shot" ofType:@"wav"];
    NSURL *path35 = [[NSURL alloc] initFileURLWithPath:path34];
    shotAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path35 error:NULL];
    //    winAudio.numberOfLoops = -1;
    shotAudio.volume = 3;
    [shotAudio setDelegate:self];
    [shotAudio prepareToPlay];
    
    NSString *path36 = [[NSBundle mainBundle] pathForResource:@"blood" ofType:@"wav"];
    NSURL *path37 = [[NSURL alloc] initFileURLWithPath:path36];
    bloodAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path37 error:NULL];
    //    winAudio.numberOfLoops = -1;
    bloodAudio.volume = 6;
    [bloodAudio setDelegate:self];
    [bloodAudio prepareToPlay];
    
    
  //  [[Director sharedDirector] setDeviceOrientation: CCDeviceOrientationLandscapeLeft];
    
    
    [self copyDatabaseIfNeeded];
    [self createEditableCopyOfDatabaseIfNeeded];
    [self readAnimalsFromDatabase9];
    
	NSLog(@"Appdelegate");
    [window makeKeyAndVisible];
    
	Scene *scene = [[Scene node] addChild:[Game node] z:0];
    [[Director sharedDirector] runWithScene: scene];
}

- (void) copyDatabaseIfNeeded {
	
    NSString *databaseName;
	NSString *databasePath;
	
    //Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
    // Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    //  databasePath = [documentsDir stringByAppendingPathComponent:databaseName2];
    databasePath =  [[NSBundle mainBundle]pathForResource:@"localCal"ofType:@"rdb"];
  //  NSLog(databasePath);
  //  NSLog(databaseName2);
    
	//NSString *dbPath = [self  getDBPath];
	BOOL success = [fileManager fileExistsAtPath:databasePath]; 
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"localCal.rdb"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:databasePath error:&error];
		NSLog(@"Database file copied from bundle to %@", databasePath);
		
		if (!success) 
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	} else {
        
		NSLog(@"Database file found at path %@", databasePath);
		
	}
}

- (void)createEditableCopyOfDatabaseIfNeeded  
{ 
    // First, test for existence. 
    BOOL success; 
    NSFileManager *fileManager = [NSFileManager defaultManager]; 
    NSError *error; 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"localCal.rdb"]; 
    success = [fileManager fileExistsAtPath:writableDBPath]; 
    // NSLog(@"path : %@", writableDBPath); 
    if (success) return; 
    // The writable database does not exist, so copy the default to the appropriate location. 
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"localCal.rdb"]; 
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error]; 
    if (!success)  
    { 
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]); 
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
                flip = aUserNameLast;
				NSString *aUserEmail = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                music = aUserEmail;
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



- (NSString *)getModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *sDeviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);                              
    if ([sDeviceModel isEqual:@"i386"])      return @"Simulator";  //iPhone Simulator
    if ([sDeviceModel isEqual:@"iPhone1,1"]) return @"iPhone1G";   //iPhone 1G
    if ([sDeviceModel isEqual:@"iPhone1,2"]) return @"iPhone3G";   //iPhone 3G
    if ([sDeviceModel isEqual:@"iPhone2,1"]) return @"iPhone3GS";  //iPhone 3GS
    if ([sDeviceModel isEqual:@"iPhone3,1"]) return @"iPhone3GS";  //iPhone 4 - AT&T
    if ([sDeviceModel isEqual:@"iPhone3,2"]) return @"iPhone3GS";  //iPhone 4 - Other carrier
    if ([sDeviceModel isEqual:@"iPhone3,3"]) return @"iPhone4";    //iPhone 4 - Other carrier
    if ([sDeviceModel isEqual:@"iPhone4,1"]) return @"iPhone4S";   //iPhone 4S
    if ([sDeviceModel isEqual:@"iPod1,1"])   return @"iPod1stGen"; //iPod Touch 1G
    if ([sDeviceModel isEqual:@"iPod2,1"])   return @"iPod2ndGen"; //iPod Touch 2G
    if ([sDeviceModel isEqual:@"iPod3,1"])   return @"iPod3rdGen"; //iPod Touch 3G
    if ([sDeviceModel isEqual:@"iPod4,1"])   return @"iPod4thGen"; //iPod Touch 4G
    if ([sDeviceModel isEqual:@"iPad1,1"])   return @"iPadWiFi";   //iPad Wifi
    if ([sDeviceModel isEqual:@"iPad1,2"])   return @"iPad3G";     //iPad 3G
    if ([sDeviceModel isEqual:@"iPad2,1"])   return @"iPad2";      //iPad 2 (WiFi)
    if ([sDeviceModel isEqual:@"iPad2,2"])   return @"iPad2";      //iPad 2 (GSM)
    if ([sDeviceModel isEqual:@"iPad2,3"])   return @"iPad2";      //iPad 2 (CDMA)
    
    NSString *aux = [[sDeviceModel componentsSeparatedByString:@","] objectAtIndex:0];
    
    //If a newer version exist
    if ([aux rangeOfString:@"iPhone"].location!=NSNotFound) {
        int version = [[aux stringByReplacingOccurrencesOfString:@"iPhone" withString:@""] intValue];
        if (version == 3) return @"iPhone4";
        if (version >= 4) return @"iPhone4s";
        
    }
    if ([aux rangeOfString:@"iPod"].location!=NSNotFound) {
        int version = [[aux stringByReplacingOccurrencesOfString:@"iPod" withString:@""] intValue];
        if (version >=4) return @"iPod4thGen";
    }
    if ([aux rangeOfString:@"iPad"].location!=NSNotFound) {
        int version = [[aux stringByReplacingOccurrencesOfString:@"iPad" withString:@""] intValue];
        if (version ==1) return @"iPad3G";
        if (version >=2) return @"iPad2";
    }
    //If none was found, send the original string
    return sDeviceModel;
}


- (void)dealloc {
//	[window release];
	[super dealloc];
    [gameLoop release];
    [screamAudio release];
    [splashAudio release];
    [thrustAudio release];
    [bombAudio release];
    [cashAudio release];
    [cashAudio2 release];
    [angelAudio release];
    [level1Audio release];
    [level2Audio release];
    [level3Audio release];
    [beepsAudio release];
    [jumpAudio release];
    [gruntAudio release];
    [winAudio release];
    [clickAudio release];
    [shotAudio release];
    [bloodAudio release];
}

- (void)applicationWillResignActive:(UIApplication*)application {
	[[Director sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication*)application {
	[[Director sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication*)application {
	[[TextureMgr sharedTextureMgr] removeAllTextures];
}

- (void)applicationSignificantTimeChange:(UIApplication*)application {
	[[Director sharedDirector] setNextDeltaTimeZero:YES];
}

@end
