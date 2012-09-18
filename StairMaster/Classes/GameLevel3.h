#import "cocos2d.h"
#import "Main.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Highscores.h"
#import "GameCenterManager.h"


#define kNumPlatforms3 1


@interface GameLevel3 : Main <AVAudioPlayerDelegate> {
	ccVertex2F bird_pos;
	ccVertex2F bird_vel;
	ccVertex2F bird_acc;	
    
	float currentPlatformY;
	int currentPlatformTag;
	float currentMaxPlatformStep;
	int currentBonusPlatformIndex;
	int currentBonusType;
	int platformCount;
    
    GameCenterManager *gameCenterManager;
	
	BOOL gameSuspended;
	BOOL birdLookingRight;
    
    AVAudioPlayer *TheAudio;
    AVAudioPlayer *TheAudio2;
    AVAudioPlayer *TheAudio3;
    AVAudioPlayer *TheAudio4;
    AtlasSprite *playButton;
    AtlasSprite *pauseButton;
	AtlasSprite *powerButton;
    AtlasSprite *level2Button;
    AtlasSprite *level3Button;
    AtlasSprite *starburst;
    AtlasSprite *bomb11;
    AtlasSprite *bomb12;
    AtlasSprite *bomb13;
    AtlasSprite *bomb14;
    AtlasSprite *bomb15;
    UIAccelerometer *accelerometer;
    //    Scene *scene;
    //    Highscores *highscores;
    
	int score;
    int newscore;
    
    float timer;
    //   int touches;
    
    NSTimer *Timer;
    UIAlertView *changeSettingAlert;
    
}
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
@property(nonatomic, retain) AVAudioPlayer *TheAudio;
@property(nonatomic, retain) AVAudioPlayer *TheAudio2;
@property(nonatomic, retain) AVAudioPlayer *TheAudio3;
@property(nonatomic, retain) AVAudioPlayer *TheAudio4;
@property(nonatomic, retain) AtlasSprite *playButton;
@property(nonatomic, retain) AtlasSprite *pauseButton;
@property(nonatomic, retain) AtlasSprite *powerButton;
@property(nonatomic, retain) AtlasSprite *level2Button;
@property(nonatomic, retain) AtlasSprite *level3Button;
@property(nonatomic, retain) AtlasSprite *starburst;
@property(nonatomic, retain) AtlasSprite *bomb6;
@property(nonatomic, retain) AtlasSprite *bomb7;
@property(nonatomic, retain) AtlasSprite *bomb8;
@property(nonatomic, retain) AtlasSprite *bomb9;
@property(nonatomic, retain) AtlasSprite *bomb10;
@property(nonatomic, retain) NSTimer *Timer;
@property(nonatomic, retain) UIAccelerometer *accelerometer;
//@property(nonatomic, retain) Scene *scene;
//@property(nonatomic, retain) Highscores *highscores;


@end
