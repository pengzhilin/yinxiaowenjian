//
//  PZLAudioTools.h
//  yinxiaowenjian
//
//  Created by pengzhilin on 13/4/2.
//  Copyright © 2013年 pengzhilin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface PZLAudioTools : NSObject

/** 播放系统音效*/
+ (void)playSystemSoundWithURL:(NSURL *)url;

/** 播放震动音效*/
+ (void)playAlertSoundWithURL:(NSURL *)url;

/** 清空音效文件的内存*/
+ (void)clearMemory;

@end
