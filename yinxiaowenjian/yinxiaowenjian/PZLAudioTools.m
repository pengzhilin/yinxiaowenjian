//
//  PZLAudioTools.m
//  yinxiaowenjian
//
//  Created by pengzhilin on 13/4/2.
//  Copyright © 2013年 pengzhilin. All rights reserved.
//

#import "PZLAudioTools.h"

/** 缓存字典*/
static NSMutableDictionary *_soundIDDict;

@implementation PZLAudioTools

// 只要头文件参与了编译调用
//+ (void)load

/** 缓存字典初始化*/
+ (void)initialize
{
    _soundIDDict = [NSMutableDictionary dictionary];
}

+ (void)playSystemSoundWithURL:(NSURL *)url
{
    // 不带震动的播放
    AudioServicesPlaySystemSound([self loadSoundIDWithURL:url]);
}

/** 播放震动音效*/
+ (void)playAlertSoundWithURL:(NSURL *)url
{
    // 带震动的播放
    AudioServicesPlayAlertSound([self loadSoundIDWithURL:url]);
    
}

#pragma mark 播放音效的公用方法
+ (SystemSoundID)loadSoundIDWithURL:(NSURL *)url
{
    // 思路思路
    // soundID重复创建 --> soundID每次创建, 就会有对应的URL地址产生
    // 可以将创建后的soundID 及 对应的URL 进行缓存处理
    
    //1. 获取URL的字符串
    NSString *urlStr = url.absoluteString;
    
    //2. 从缓存字典中根据URL来取soundID 系统音效文件
    SystemSoundID soundID = [_soundIDDict[urlStr] intValue];
    
    //需要在刚进入的时候, 判断缓存字典是否有url对应的soundID
    
    //3. 判断soundID是否为0, 如果为0, 说明没有找到, 需要创建
    if (soundID == 0) {
        //3.1 创建音效文件
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
        
        //3.2 缓存字典的添加键值
        _soundIDDict[urlStr] = @(soundID);
    }
    
    return soundID;
}


/** 清空音效文件的内存  
 
 *全局清空音效文件，应该在AppDelegate
 *- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application;
 *
 *局部清空音效文件,应该在当控制器收到内存警告时清空，
 *-(void)didReceiveMemoryWarning;
 *
 *遍历字典有个好处就是：stop，当条件达到了，找到了就stop了，就不需要再去遍历了
 */
+ (void)clearMemory
{
    //1. 遍历字典
    [_soundIDDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        //2. 清空音效文件的内存
        SystemSoundID soundID = [obj intValue];
        AudioServicesDisposeSystemSoundID(soundID);
    }];
    
}

@end
