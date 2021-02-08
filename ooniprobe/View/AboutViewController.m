#import "AboutViewController.h"
#import "Engine.h"
#import "VersionUtility.h"

@interface AboutViewController ()
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Settings.About.Label", nil);
    [NavigationBarUtility setNavigationBar:self.navigationController.navigationBar];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.headerView setBackgroundColor:[UIColor colorNamed:@"color_blue5"]];
    [self.learnMoreButton setTitle:NSLocalizedString(@"Settings.About.Content.LearnMore", nil) forState:UIControlStateNormal];
    self.learnMoreButton.layer.cornerRadius = 20;
    self.learnMoreButton.layer.masksToBounds = YES;
    [self.learnMoreButton setTitleColor:[UIColor whiteColor]
                        forState:UIControlStateNormal];
    [self.learnMoreButton setBackgroundColor:[UIColor colorNamed:@"color_blue5"]];
    
    [self.textLabel setText:NSLocalizedString(@"Settings.About.Content.Paragraph", nil)];
    [self.textLabel setTextColor:[UIColor colorNamed:@"color_gray9"]];
    
    [self.ppButton setTitle:[NSString stringWithFormat:@"%@", NSLocalizedString(@"Settings.About.Content.DataPolicy", nil)] forState:UIControlStateNormal];
    [self.ppButton setTitleColor:[UIColor colorNamed:@"color_blue5"]
                        forState:UIControlStateNormal];
    
    [self.versionLabel setText:[NSString stringWithFormat:@"OONI Probe: %@", [VersionUtility get_software_version]]];
    [self.versionLabel setTextColor:[UIColor whiteColor]];
}


-(IBAction)learnMore:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://ooni.io/"]];
}


-(IBAction)privacyPolicy:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://ooni.io/about/data-policy/"]];
}


@end
