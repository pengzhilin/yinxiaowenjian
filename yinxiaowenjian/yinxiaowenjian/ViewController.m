//
//  ViewController.m
//  yinxiaowenjian
//
//  Created by pengzhilin on 16/4/2.
//  Copyright © 2016年 pengzhilin. All rights reserved.
//

#import "ViewController.h"
//#import <AVFoundation/AVFoundation.h>
#import "PZLAudioTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //    00、创建url
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"buyao.wav" withExtension:nil];
    
    [PZLAudioTools playSystemSoundWithURL:url];
}

#pragma mark - 音效文件基本使用
-(void)test{
    //    1、导入AVFoundation框架
    //    2、创建音效文件
    //    3、播放音响文件
    
    //    00、创建url
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"buyao.wav" withExtension:nil];
    
    //    1、播放系统音效文件
    SystemSoundID soundId;
    
    //2、创建音效文件
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundId);
    
    //3、、播放音效文件 带和不带震动的播放
    //    AudioServicesPlaySystemSound(soundId);
    AudioServicesPlayAlertSound(soundId);
    
    //4、不播放了，就需要干掉所占用的内存 不能在这清除它，因为刚刚创建就释放了，等于没有创建
    //    AudioServicesDisposeSystemSoundID(soundId);
}
-(void)didReceiveMemoryWarning{
    
//    局部音效在这里释放
    
}

@end
