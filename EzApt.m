#import "EzApt.h"
#import <spawn.h>
#import <sys/wait.h>

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzApt
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return [UIColor greenColor];
}

- (BOOL)isSelected {
	return self.EzApt;
}

- (void)setSelected:(BOOL)selected {
	self.EzApt = selected;
	[super refreshState];
  [self AptGet];
}


- (void)AptGet {
    pid_t pid;
    int status;
    const char* args[] = {"aptme.sh", "update", NULL, NULL};
    posix_spawn(&pid, "/usr/bin/CCModules/aptme", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 30.0, false);
		self.EzApt = FALSE;
}
@end
