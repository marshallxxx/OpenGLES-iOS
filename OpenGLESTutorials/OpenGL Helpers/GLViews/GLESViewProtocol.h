//
//  GLESViewProtocol.h
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@protocol OpenGLESViewDelegate <NSObject>

@required
- (void)render;

@optional
- (void) updateAnimation:(float) timestamp;

@end

//-------------------------------------------------------------------

@protocol GLESViewProtocol <NSObject>

@required

@property (nonatomic, weak) id<OpenGLESViewDelegate> delegate;
@property (nonatomic, strong) EAGLContext *context;

- (void)setupLayer;
- (void)setupContext;
- (void)setupRenderBuffer;
- (void)setupFrameBuffer;
- (void)setupDepthBuffer;
- (void)setupDisplayLink;
- (void)render:(CADisplayLink *) displayLink;

@end
