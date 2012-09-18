#import "cocos2d.h"
#import "Main.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Highscores.h"
#import "GameCenterManager.h"

@interface GameStory : Main <AVAudioPlayerDelegate> {
    AVAudioPlayer *clickAudio;
}

@property(nonatomic, retain) AVAudioPlayer *clickAudio;
@end
