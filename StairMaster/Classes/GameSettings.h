#import "cocos2d.h"
#import "Main.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Highscores.h"
#import "GameCenterManager.h"

@interface GameSettings : Main <AVAudioPlayerDelegate> {
    
    UIAlertView *changeSettingAlert;
    AVAudioPlayer *clickAudio;

}

@property(nonatomic, retain) AVAudioPlayer *clickAudio;

- (void) readAnimalsFromDatabase8;
- (void) readAnimalsFromDatabase9;
@end
