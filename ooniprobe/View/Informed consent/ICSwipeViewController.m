#import "ICSwipeViewController.h"

@interface ICSwipeViewController ()

@end

@implementation ICSwipeViewController 

- (UIViewController *)first {
    if (!_first) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Onboarding" bundle:nil];
        _first = [sb instantiateViewControllerWithIdentifier:@"Onboarding_1"];
    }
    return _first;
}

- (UIViewController *)second {
    if (!_second) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Onboarding" bundle:nil];
        _second = [sb instantiateViewControllerWithIdentifier:@"Onboarding_2"];
    }
    return _second;
}
- (UIViewController *)third {
    if (!_third) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Onboarding" bundle:nil];
        _third = [sb instantiateViewControllerWithIdentifier:@"Onboarding_3"];
    }
    return _third;
}
- (UIViewController *)fourth {
    if (!_fourth) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Onboarding" bundle:nil];
        _fourth = [sb instantiateViewControllerWithIdentifier:@"Onboarding_4"];
    }
    return _fourth;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    question_number = 1;
    self.PageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.PageViewController.dataSource = self;
    viewControllers = [[NSArray alloc] initWithObjects:self.first, self.second, self.third, self.fourth, nil];

    [self.PageViewController setViewControllers:@[self.first]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
    
    self.PageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:self.PageViewController];
    [self.view addSubview:self.PageViewController.view];
    [self.PageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //Went back
    NSUInteger index = [viewControllers indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //Went forward
    NSUInteger index = [viewControllers indexOfObject:viewController];

    if (index == NSNotFound) {
        return nil;
    }
    if (index == 2 && question_number < 3){
        //return nil;
    }
    index++;
    if (index == [viewControllers count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

#pragma mark - Other Methods
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([viewControllers count] == 0) || (index >= [viewControllers count])) {
        return nil;
    }
    return [viewControllers objectAtIndex:index];
}


#pragma mark - No of Pages Methods
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [viewControllers count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
/*
#pragma mark - Page View Datasource Methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((GuidaAppChildViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((GuidaAppChildViewController*) viewController).pageIndex;
    
    if (index == NSNotFound)
    {
        return nil;
    }
    
    index++;
    if (index == [self.arrPageImages count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

#pragma mark - Other Methods
- (GuidaAppChildViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.arrPageImages count] == 0) || (index >= [self.arrPageImages count])) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    GuidaAppChildViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imgFile = self.arrPageImages[index];
    //pageContentViewController.txtTitle = self.arrPageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - No of Pages Methods
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.arrPageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (IBAction)btnDismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)btnStartAgain:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    GuidaAppChildViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.PageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

@end
 */