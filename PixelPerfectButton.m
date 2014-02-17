//
//  PixelPerfectButton.h
//
//
//  Created by Raphaël Pinto on 01/06/12.
//
//  The MIT License (MIT)
//  Copyright (c) 2013 Raphael Pinto.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.



#import "PixelPerfectButton.h"


@implementation PixelPerfectButton



#pragma mark -
#pragma mark Hit Test Method



- (BOOL)isPointTransparent:(CGPoint)point inImage:(UIImage*)_Image
{
    unsigned char lPpixel[1] = {0};
    CGContextRef lContext = CGBitmapContextCreate(lPpixel,
                                                  1, 1, 8, 1, NULL,
                                                  (CGBitmapInfo)kCGImageAlphaOnly);
    UIGraphicsPushContext(lContext);
    [_Image drawAtPoint:CGPointMake(-point.x, -point.y)];
    UIGraphicsPopContext();
    CGContextRelease(lContext);
    CGFloat lAlpha = lPpixel[0]/255.0;
    return lAlpha < 0.01;
}


- (UIView *)hitTest:(CGPoint)_Point withEvent:(UIEvent *)_Event
{
	if (!CGRectContainsPoint([self bounds], _Point) || self.userInteractionEnabled == NO)
    {
        return nil;
    }
	
  
	UIGraphicsBeginImageContext(self.frame.size);
	[[self backgroundImageForState:UIControlStateNormal] drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	UIImage* lScaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	if ( [self isPointTransparent:_Point inImage:lScaledImage] )
	{
		return nil;
	}
	else
	{
		return self;
	}
}


@end
