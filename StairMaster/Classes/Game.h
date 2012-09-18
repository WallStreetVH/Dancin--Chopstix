#import "cocos2d.h"
#import "Main.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Highscores.h"
#import "GameCenterManager.h"
#import <AudioToolbox/Audiotoolbox.h>

#define kNumPlatforms1 3

@interface Game : Main <AVAudioPlayerDelegate> {
	ccVertex2F bird_pos;
	ccVertex2F bird_vel;
	ccVertex2F bird_acc;	

	float currentPlatformY;
	int currentPlatformTag;
	float currentMaxPlatformStep;
	int currentBonusPlatformIndex;
	int currentBonusType;
	int platformCount;
    
    SystemSoundID pmph;
    SystemSoundID scream;
    AVAudioPlayer *appPlayer;
    
    GameCenterManager *gameCenterManager;
	
	//BOOL gameSuspended;
	BOOL birdLookingRight;
    
    AVAudioPlayer *TheAudio;
    AVAudioPlayer *TheAudio2;
    AVAudioPlayer *TheAudio3;
    AVAudioPlayer *TheAudio4;
    AVAudioPlayer *cashAudio;
    AVAudioPlayer *cashAudio2;
    AVAudioPlayer *bombAudio;
    AVAudioPlayer *gruntAudio;
    AVAudioPlayer *screamAudio;
    AVAudioPlayer *beepAudio;
    AVAudioPlayer *thrustAudio;
    AVAudioPlayer *thrustAudio2;
    AVAudioPlayer *jumpAudio;
    AVAudioPlayer *beeps;
    AtlasSprite *playButton;
    AtlasSprite *pauseButton;
	AtlasSprite *powerButton;
    AtlasSprite *starburst;
    AtlasSprite *hundred;
    AtlasSprite *burst;
    AtlasSprite *bomb;
    AtlasSprite *bomb2;
    AtlasSprite *bomb3;
    AtlasSprite *bomb4;
    AtlasSprite *bomb5;
    AtlasSprite *dude1;
    AtlasSprite *explosion;
    AtlasSprite *money;
    AtlasSprite *money1;
    AtlasSprite *money2;
    AtlasSprite *money3;
    AtlasSprite *splash;
    AtlasSprite *angelTime;
    AtlasSprite *bullet1;
    AtlasSprite *bullet2;
    AtlasSprite *blood;
    LabelAtlas *scoreLabel;
    LabelAtlas *scoreLabel2;
    LabelAtlas *timeLabel;
    LabelAtlas *livesLabel;
    LabelAtlas *flashScoreLabel;
    LabelAtlas *touchLabel;
    LabelAtlas *updateLabel;
//    Scene *scene;
//    Highscores *highscores;

	int score;
    int newscore;
    float delay1, delay2, delay3, delay4, delay5, delay6, delay7;
    
    float timer;
 //   int touches;
    
    ParticleExplosion *emitter;
    ParticleSmoke *emitterSmoke;
    ParticleFlower *emitterMoney;
    ParticleFlower *emitterMoney2;
    ParticleGalaxy *emitterTime;
    ParticleSun *emitterBurst;
    
    
    UIAlertView *changeSettingAlert;
    
    NSTimer *Timer;
   
}
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
@property(nonatomic, retain) AVAudioPlayer *TheAudio;
@property(nonatomic, retain) AVAudioPlayer *appPlayer;
@property(nonatomic, retain) AVAudioPlayer *TheAudio2;
@property(nonatomic, retain) AVAudioPlayer *TheAudio3;
@property(nonatomic, retain) AVAudioPlayer *TheAudio4;
@property(nonatomic, retain) AVAudioPlayer *cashAudio;
@property(nonatomic, retain) AVAudioPlayer *cashAudio2;
@property(nonatomic, retain) AVAudioPlayer *bombAudio;
@property(nonatomic, retain) AVAudioPlayer *gruntAudio;
@property(nonatomic, retain) AVAudioPlayer *screamAudio;
@property(nonatomic, retain) AVAudioPlayer *beepAudio;
@property(nonatomic, retain) AVAudioPlayer *thrustAudio;
@property(nonatomic, retain) AVAudioPlayer *thrustAudio2;
@property(nonatomic, retain) AVAudioPlayer *jumpAudio;
@property(nonatomic, retain) AVAudioPlayer *beeps;
@property(nonatomic, retain) AtlasSprite *playButton;
@property(nonatomic, retain) AtlasSprite *pauseButton;
@property(nonatomic, retain) AtlasSprite *powerButton;
@property(nonatomic, retain) AtlasSprite *starburst;
@property(nonatomic, retain) AtlasSprite *hundred;
@property(nonatomic, retain) AtlasSprite *burst;
@property(nonatomic, retain) AtlasSprite *bomb;
@property(nonatomic, retain) AtlasSprite *bomb2;
@property(nonatomic, retain) AtlasSprite *bomb3;
@property(nonatomic, retain) AtlasSprite *bomb4;
@property(nonatomic, retain) AtlasSprite *bomb5;
@property(nonatomic, retain) AtlasSprite *dude1;
@property(nonatomic, retain) AtlasSprite *money;
@property(nonatomic, retain) AtlasSprite *money1;
@property(nonatomic, retain) AtlasSprite *money2;
@property(nonatomic, retain) AtlasSprite *money3;
@property(nonatomic, retain) AtlasSprite *explosion;
@property(nonatomic, retain) AtlasSprite *splash;
@property(nonatomic, retain) AtlasSprite *angelTime;
@property(nonatomic, retain) AtlasSprite *bullet1;
@property(nonatomic, retain) AtlasSprite *bullet2;
@property(nonatomic, retain) AtlasSprite *blood;
@property(nonatomic, retain) NSTimer *Timer;
//@property(nonatomic, retain) Scene *scene;
//@property(nonatomic, retain) Highscores *highscores;


@end
