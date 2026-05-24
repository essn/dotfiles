{ ... }:
{
  system.defaults = {
    #   NSGlobalDomain = {
    #     KeyRepeat = 1;
    #     InitialKeyRepeat = 50;
    #     AppleShowAllExtensions = true;
    #     ApplePressAndHoldEnabled = false;        # key repeat over accent popup
    #     "com.apple.keyboard.fnState" = true;     # fn keys as standard function keys
    #     NSAutomaticCapitalizationEnabled = false;
    #     NSAutomaticDashSubstitutionEnabled = false;
    #     NSAutomaticPeriodSubstitutionEnabled = false;
    #     NSAutomaticQuoteSubstitutionEnabled = false;
    #     NSAutomaticSpellingCorrectionEnabled = false;
    #     NSNavPanelExpandedStateForSaveMode = true;
    #     NSNavPanelExpandedStateForSaveMode2 = true;
    #     PMPrintingExpandedStateForPrint = true;
    #     NSDocumentSaveNewDocumentsToCloud = false;
    #     NSWindowResizeTime = 1.0e-3;
    #   };

    screencapture = {
      location = "/Users/jesse/Pictures/Screenshots";
      type = "png";
    };

    ActivityMonitor = {
      ShowCategory = 100; # All Processes
      SortColumn = "CPUUsage";
      SortDirection = 0; # descending
    };

    #   dock = {
    #     autohide = true;
    #     show-recents = false;
    #     minimize-to-application = true;
    #     tilesize = 48;
    #   };

    finder = {
      AppleShowAllFiles = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "Nlsv"; # list view by default
      FXDefaultSearchScope = "SCcf"; # search current folder
      FXEnableExtensionChangeWarning = false;
      _FXSortFoldersFirst = true;
    };

    #   screensaver = {
    #     askForPasswordDelay = 0;
    #   };
  };
}
