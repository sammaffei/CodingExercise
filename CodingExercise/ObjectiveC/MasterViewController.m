//
//  MasterViewController.m
//  SimpsonsViewerOC
//
//  Created by Samuel Maffei on 6/30/18.
//  Copyright © 2018 sammaffei. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterCollectionViewController.h"
#import "DetailViewController.h"
#import "Constants.h"

@interface MasterViewController ()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *modeSelectorHeightConstraint;
@property (weak, nonatomic) MasterCollectionViewController *childCollectionVC;

@property (readonly, nonatomic) Boolean haveAnyCompactDimenson;


@end

@implementation MasterViewController

CGFloat defaultModeSelectorHeight = 0.0;

-(Boolean)haveAnyCompactDimenson
    {
    if (self.splitViewController == nil)
        return true;
        
    return (self.splitViewController.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) ||
        (self.splitViewController.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact);
    }


- (IBAction)performModeSwitch:(UISegmentedControl *)sender
    {
    if (_childCollectionVC != nil)
        {
        [_childCollectionVC setCurColMode:sender.selectedSegmentIndex];
        }
    }

- (void)rotatedNotification:(NSNotification *) notification
    {
    if ((self.childCollectionVC != nil) && (self.childCollectionVC.collectionView != nil))
        [self.childCollectionVC.collectionView reloadData];
    }


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_modeSelectorHeightConstraint != nil)
        {
        defaultModeSelectorHeight = _modeSelectorHeightConstraint.constant;
        }
    
    self.title = cDataTitleStr;
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(rotatedNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
}


-(void)setModeSelectorVisibilty:(Boolean)visible
    {
    if (_modeSelectorHeightConstraint != nil)
        {
        _modeSelectorHeightConstraint.constant = visible ? defaultModeSelectorHeight : 0.0;
            
        [self.view setNeedsLayout];
        }
    }


/*     override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
 {
 guard let splitPlaneVC = self.splitViewController
 else {return}
 
 // OK, we really shouldn't be talking iPhone vs. iPad these days. We really should be supporting
 // size classes where we can. So, the spec really only wants the mode selector to be visible
 // when the size class is compact. Otherwise, it always only text
 
 setModeSelectorVisibilty(visible: splitPlaneVC.traitCollection.horizontalSizeClass == .compact)
 } */

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
    {
    // OK, we really shouldn't be talking iPhone vs. iPad these days. We really should be supporting
    // size classes where we can. So, the spec really only wants the mode selector to be visible
    // when the size class is compact. Otherwise, it always only text

    if (self.splitViewController != nil)
        {
        [self setModeSelectorVisibilty:self.haveAnyCompactDimenson];
        }
    }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    {
    // use embed to store MasterCollectionViewController
    
    if ([segue.identifier isEqualToString:@"CollectionEmbedSegue"])
        {
        _childCollectionVC = (MasterCollectionViewController *) segue.destinationViewController;
        }
    }

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    }



@end
