#import "EzApt.h"
#import <spawn.h>

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzAptModule
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return [UIColor blueColor];
}

- (BOOL)isSelected {
	return self.EzApt;
}

- (void)setSelected:(BOOL)selected {
	self.EzApt = selected;
	[super refreshState];
    [self aptget];
}

- (void)aptget {
    pid_t pid;
    int status;
    const char* args[] = {"apt-get", "update",NULL};
    posix_spawn(&pid, "/usr/bin/apt-get", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}
@end
