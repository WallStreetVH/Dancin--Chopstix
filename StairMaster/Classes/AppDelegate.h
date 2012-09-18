#import "cocos2d.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <sqlite3.h>
@interface AppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window;
    UIAlertView *changeSettingAlert;
    AVAudioPlayer *gameLoop;
    AVAudioPlayer *gameLoop2;
     AVAudioPlayer *gameLoop3;
    AVAudioPlayer *screamAudio;
    AVAudioPlayer *splashAudio;
    AVAudioPlayer *thrustAudio;
    AVAudioPlayer *bombAudio;
    AVAudioPlayer *cashAudio;
    AVAudioPlayer *cashAudio2;
    AVAudioPlayer *angelAudio;
    AVAudioPlayer *level1Audio;
    AVAudioPlayer *level2Audio; 
    AVAudioPlayer *level3Audio; 
    AVAudioPlayer *beepsAudio;
    AVAudioPlayer *jumpAudio;
    AVAudioPlayer *gruntAudio;
    AVAudioPlayer *winAudio;
    AVAudioPlayer *clickAudio;
    AVAudioPlayer *shotAudio;
    AVAudioPlayer *bloodAudio;
    AVAudioPlayer *gongAudio;
    AVAudioPlayer *newlifeAudio;

}

@property (nonatomic, retain) AVAudioPlayer *gameLoop;
@property (nonatomic, retain) AVAudioPlayer *gameLoop2;
@property (nonatomic, retain) AVAudioPlayer *gameLoop3;
@property (nonatomic, retain) AVAudioPlayer *screamAudio;
@property (nonatomic, retain) AVAudioPlayer *splashAudio;
@property (nonatomic, retain) AVAudioPlayer *thrustAudio;
@property (nonatomic, retain) AVAudioPlayer *bombAudio;
@property (nonatomic, retain) AVAudioPlayer *cashAudio;
@property (nonatomic, retain) AVAudioPlayer *cashAudio2;
@property (nonatomic, retain) AVAudioPlayer *angelAudio;
@property (nonatomic, retain) AVAudioPlayer *level1Audio;
@property (nonatomic, retain) AVAudioPlayer *level2Audio;
@property (nonatomic, retain) AVAudioPlayer *level3Audio;
@property (nonatomic, retain) AVAudioPlayer *beepsAudio;
@property (nonatomic, retain) AVAudioPlayer *jumpAudio;
@property (nonatomic, retain) AVAudioPlayer *gruntAudio;
@property (nonatomic, retain) AVAudioPlayer *winAudio;
@property (nonatomic, retain) AVAudioPlayer *clickAudio;
@property (nonatomic, retain) AVAudioPlayer *shotAudio;
@property (nonatomic, retain) AVAudioPlayer *bloodAudio;
@property (nonatomic, retain) AVAudioPlayer *gongAudio;
@property (nonatomic, retain) AVAudioPlayer *newlifeAudio;


- (NSString *)getModel;
- (void) readAnimalsFromDatabase9;
- (void) copyDatabaseIfNeeded;
- (void) createEditableCopyOfDatabaseIfNeeded; 


@end
