#import "cocos2d.h"
#import "Main.h"
#import "GameCenterManager.h"
#import "Game_CenterViewController.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Game.h"
#import <iAd/iAd.h>

@interface Highscores : Main <UITextFieldDelegate, ADBannerViewDelegate>
{
	NSString *currentPlayer;
	//int currentScore;
	int currentScorePosition;
	NSMutableArray *highscores;
	UIAlertView *changePlayerAlert;
	UITextField *changePlayerTextField;
    GameCenterManager *gameCenterManager;
    NSString * currentLeaderBoard;
    UIAlertView *changeSettingAlert;
    
    ADBannerView *adView;
    BOOL bannerIsVisible;
    NSUInteger *intRet;
    
  //  int64_t  currentScore;
    UIWindow *window;
   
}

@property (nonatomic, retain) GameCenterManager *gameCenterManager;

@property (nonatomic, retain) NSString* currentLeaderBoard;
//@property (nonatomic, assign) int64_t currentScore;

@property(nonatomic, retain) AVAudioPlayer *appPlayer;

@property (nonatomic, retain) IBOutlet Game_CenterViewController *viewController;

@property (nonatomic, retain) IBOutlet UIWindow *window;


- (id)initWithScore:(int)lastScore;

- (void) showLeaderboard;
@end
