//
//  GLESOneView.m
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "GLESOneView.h"

@implementation GLESOneView

- (void)setupLayer {
    CAEAGLLayer *layer = (CAEAGLLayer *)super.layer;
    layer.opaque = YES;
}

- (void)setupContext {
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    
    if (self.context == nil || [EAGLContext setCurrentContext:self.context] == NO) {
        NSLog(@"Cannot create context");
        exit(EXIT_FAILURE);
    }
}

- (void)setupRenderBuffer {
    glGenRenderbuffersOES(1, &renderBuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderBuffer);
    
    [self.context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
}

- (void)setupFrameBuffer {
    glGenFramebuffersOES(1, &frameBuffer);
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, frameBuffer);
    
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, renderBuffer);
}

- (void)setupDepthBuffer {
    glGenRenderbuffersOES(1, &depthBuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthBuffer);
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    glRenderbufferStorageOES(GL_RENDERBUFFER_OES,
                          GL_DEPTH_COMPONENT16_OES,
                          screenRect.size.width,
                          screenRect.size.height);
    
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthBuffer);
    
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderBuffer);
    
    glEnable(GL_DEPTH_TEST);
}

- (void)render:(CADisplayLink *) displayLink {
    if (self.delegate != nil) {
        [self.delegate render];
    }
    
    [self.context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

@end
