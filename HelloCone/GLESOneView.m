//
//  GLESOneView.m
//  HelloCone
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

- (void)render {
    glClearColor(0.5, 0.5, 0.5, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [self.context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

@end
