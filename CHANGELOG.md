## 3.4.2 - August 17, 2023

- Moved version in home screen to be loaded in the VersionBloc instead.
- Added Reload prompt if the loaded VERSION and the version from the API do not match.
- Updated the Raw HTML of each blog to have a return to website button.
- Updated the Raw HTML to convert special single and double quote to the simple version.

## 3.4.1 - August 6, 2023

- Added Poems category for blogs (Red Category)
- Added raw HTML share link at the bottom of each blog.

## 3.4.0 - July 31, 2023

- Added integration with newly added vhcsite_api
- Added view count to individual blogs
- Rearranged blocs and repositories into their own bloc_builders and repository_builders file
- Moved BlogManifest to vhcsite_models

## 3.3.5 - July 25, 2023

- Updated event_bloc to 4.6.0
- Removed resetStream from BlogBloc and replaced with eventBus

## 3.3.4 - July 24, 2023

- Added Sort for Blog List
- Added onSubmitted to Search TextField so that hitting enter would initiate the search as well

## 3.3.3 - July 23, 2023

- Refactored Bloc Category Picker into its own Widget
- Added Searchbar in Blog List
- Added current version to Home Page to more easily spot version differences
- Added Refresh Functionality to all scrollable screens
- Added TextScaleFactor Override if web - DISABLED because it doesn't solve the problem I thought it would
- Renamed UIEvent to VHCSiteEvent
- Deleted old_setup folder

## 3.3.2 - July 19, 2023

- Added Category Picker to filter the blogs in the blog list

## 3.3.1 - July 13, 2023

- Reorganized folder structure so that Flutter is in the root folder
- Added Date under the Name of each individual blog

## 3.3.0 - July 12, 2023

- Added Blog Selection Screen
- Moved dev to blog
- Added Next and Previous buttons to Blog posts
- Changed Changelog to use EssayScreen
- Used EssayScroll in more places where it was appropriate
- Upgraded event_bloc to 4.5.1
- Upgraded event_essay to 0.1.5
- Upgraded event_navigation to 0.6.6

-------------------------
## 3.2.3 - April 8, 2023

- Updated index.html
- Changed the default blog that shows up

-------------------------
## 3.2.2 - March 26, 2023

- Updated weight.md
- Adjusted apps displayed in apps tab to max 3 per row.

-------------------------
## 3.2.1 - March 21, 2023

- Removed animations package and used vhcblade_theme instead.

-------------------------
## 3.2.0 - March 20, 2023

- Removed essay package and replaced it with event_essay - https://pub.dev/packages/event_essay
- Updated blog markdown
- Updated weight blade to reflect the fact that it is now publicly available on the play store.

-------------------------
## 3.1.0 - March 14, 2023

- Upgraded to vhcblade_theme 0.2.2
- Changed Apps to be cross-aligned by start, to make the different sizes feel better.
- Changed images from hard links to relative links to improve display in different domains.
- Updated Weight Blade Logo to the official logo
- Added Apps Made for Others section in Apps
  - Added Pearls of Asia
- Changed YouTube Reference to Software Development Referencec

-------------------------
## 3.0.0 - February 23, 2023

- Updated event_bloc to 4.2.0
- Removed navigation package and replaced it with event_navigation - https://pub.dev/packages/event_navigation
- Added Apps Page
- Converted custom rendering to instead use flutter_markdown
- Moved theme to use vhcblade_theme instead - https://pub.dev/packages/vhcblade_theme
- Upgraded to Flutter 3!

-------------------------
## 2.0.0 - July 14, 2021

- Removed State Package and replaced it with event_bloc - https://pub.dev/packages/event_bloc
- Reinvigorated with hopes and dreams.

-------------------------
## 1.3.1 - March 10, 2021

- Built with Flutter 2.

-------------------------
## 1.3.0 - February 25, 2021

- Added Changelog to About Screen.
- Sub Navigation has been enabled.
- Removed Strange Scrolling on Images.

-------------------------
## 1.2.0 - February 12, 2021

- Integrated with Web Navigation and Back and Forward! Can now easily share links!
- Scrollbars can now be used to control the Scroll Position. Thanks Flutter Update!
- Fixed Bug that Scrollbars wouldn't show up until a scroll actually happened in Flutter and About Page.

-------------------------
## 1.1.0 - February 6, 2021

- Added handling for when there isn't enough space for the actions in the appbar. Turns the actions into a drawer instead.
- Fixed Scroll Issue (Can now use the scroll wheel from negative space)
- Added About Page.

-------------------------
## 1.0.0 - January 31, 2021

- Released the Website!