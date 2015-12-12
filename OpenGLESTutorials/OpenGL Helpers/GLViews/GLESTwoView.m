//
//  GLESTwoView.m
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "GLESTwoView.h"

@implementation GLESTwoView

- (void)setupContext {
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (self.context == nil || [EAGLContext setCurrentContext:self.context] == NO) {
        NSLog(@"Cannot create context");
        exit(EXIT_FAILURE);
    }
}

- (void)setupRenderBuffer {
    glGenRenderbuffers(1, &renderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, renderBuffer);
    
    [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer*)self.layer];
}

- (void)setupFrameBuffer {
    glGenFramebuffers(1, &frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, renderBuffer);
    
}

- (void)setupDepthBuffer {
    glGenRenderbuffers(1, &depthBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, depthBuffer);
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    glRenderbufferStorage(GL_RENDERBUFFER,
                          GL_DEPTH_COMPONENT16,
                          screenRect.size.width,
                          screenRect.size.height);
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthBuffer);
    
    glBindRenderbuffer(GL_RENDERBUFFER, renderBuffer);
    
    glEnable(GL_DEPTH_TEST);
}

- (void)render:(CADisplayLink *) displayLink {
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(updateAnimation:)]) {
            float elapsedSeconds = displayLink.timestamp - m_timestamp;
            m_timestamp = displayLink.timestamp;
            [self.delegate updateAnimation:elapsedSeconds];
        }
        [self.delegate render];
    }
    
    [self.context presentRenderbuffer:GL_RENDERBUFFER];
}

@end
