//Classes
@interface NCNotificationSectionSettings : NSObject
@property (nonatomic,copy,readonly) id sectionIdentifier;
@end

@interface SBIcon
-(void)setBadge:(id)arg1;
@end

@interface SBIconModel
-(id)applicationIconForBundleIdentifier:(id)arg1;
@end

@interface SBIconController : UIViewController {}
+(id)sharedInstance;
-(SBIconModel* )model;
@end

@interface NCNotificationListCell : UIView
-(double) _actionButtonTriggerDistanceForView:(id)arg1;
@end


%hook NCNotificationListCell
//Perform "clean" Notification on the first swipe.
-(double) _actionButtonTriggerDistanceForView:(id) arg1
	{
		return 0;
	}
%end

%hook NCNotificationSection
-(BOOL) removeNotificationRequest:(NCNotificationSectionSettings *)notification {
	//Application id
	id identity = notification.sectionIdentifier;

	//Prevent SB-Crash
	if(identity == nil) return %orig;

	//Getting icon.
	SBIconController* controller = [%c(SBIconController) sharedInstance];
	SBIconModel* model = controller.model;
	id icon = [model applicationIconForBundleIdentifier:identity];

	// "Removing" badge by setting it to 0.
	[icon performSelector:@selector(setBadge:) withObject:nil];
	//[icon setBadge:[NSNumber numberWithInt:0]];

	//Run original code
	return %orig;
}
%end
