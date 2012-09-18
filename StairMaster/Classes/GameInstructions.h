#import "cocos2d.h"
#import "Main.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "Highscores.h"
#import "GameCenterManager.h"

@interface GameInstructions : Main <AVAudioPlayerDelegate, UIScrollViewDelegate> {
    AVAudioPlayer *clickAudio;
}

@property(nonatomic, retain) AVAudioPlayer *clickAudio;
@end
