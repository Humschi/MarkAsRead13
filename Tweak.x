@interface NCNotificationSectionSettings : NSObject
@property (nonatomic,copy,readonly) id sectionIdentifier;
@end

@interface SBIcon
-(void)setBadge:(id)arg1;
@end

@interface SBIconModel
-(id)applicationIconForBundleIdentifier:(id)arg1;
@end

@interface SBIconController
+(id)sharedInstance;
-(SBIconModel* )model;
@end

%hook NCNotificationSection
-(BOOL) removeNotificationRequest:(NCNotificationSectionSettings *)notification {
	//Application id
	id identity = notification.sectionIdentifier;

	//Prevent SB-Crash
	if(identity == nil) return %orig;

	//Getting icon.
	SBIconController* _controller = [%c(SBIconController) sharedInstance];
	SBIconModel* _model = _controller.model;
	SBIcon* _icon = [_model applicationIconForBundleIdentifier:identity];

	// "Removing" badge by setting it to 0.
	[_icon setBadge:[NSNumber numberWithInt:0]];
	return %orig;
}
%end
