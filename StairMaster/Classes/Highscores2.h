#import "cocos2d.h"
#import "Main.h"
#import "GameCenterManager.h"
#import "Game_CenterViewController.h"

@interface Highscores2 : Main <UITextFieldDelegate>
{
	NSString *currentPlayer;
	//int currentScore;
	int currentScorePosition;
	NSMutableArray *highscores;
	UIAlertView *changePlayerAlert;
	UITextField *changePlayerTextField;
    GameCenterManager *gameCenterManager;
    NSString * currentLeaderBoard;
    
    int64_t  currentScore;
    UIWindow *window;
   
}

@property (nonatomic, retain) GameCenterManager *gameCenterManager;
@property (nonatomic, retain) NSString* currentLeaderBoard;
@property (nonatomic, assign) int64_t currentScore;

@property (nonatomic, retain) IBOutlet Game_CenterViewController *viewController;

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (id)initWithScore:(int)lastScore;

- (void) showLeaderboard;
@end
