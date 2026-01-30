# VHCSite

This is the GitHub for my statically hosted site [vhcblade.com](vhcblade.com) I made this open source so that anyone can just take it and use it for their own projects. Powered by Flutter.

This project also serves as a demonstration for the various event-based packages I've developed for Flutter, as well as Dart in general.

# General Packages Used

- [event_bloc](github.com/VHCBlade/event_bloc) - an event-based implementation of the BLoC pattern.
- [event_db](github.com/VHCBlade/event_db) - A companion package for handling serializable models and databases with event_bloc.

# Additional Code for Site

- [vhcsite_models](github.com/VHCBlade/vhcsite_models) - contains the models used across the api and the website
- [vhcsite_api](github.com/VHCBlade/vhcsite_api) - the server that this website interfaces with.

# How to upload a blog

- Convert your blog into a markdown file
  - The name will become the end of the link
  - The First line will become the title
  - the folder in assets/text/blog will determine the category
- Run release_blog.sh
- If HTML is not generated, make sure that markdown is installed in python