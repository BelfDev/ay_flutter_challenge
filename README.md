<h1 align="center">
  <img width="200" src=".github/project-logo.png">
  <br>
  <br>
  Flutter Coding Challenge
  <br>
</h1>

<p align="middle">
  <img src=".github/ios-app-result.png" width="200" hspace="24" />
  <img src=".github/android-app-result.png" width="200" />
</p>

## Requirements


> Given a list of contact names (as `List<String>` for demo purposes), render an address book list where the names are grouped by their first character.

### Basic

- [x] Implementation should be done in its own Widget
    - [x] We expect a `GroupedListView` widget which receives the items
    - [x] Make this widget generic and be able to work with any data type, given the appropriate builder is provided
    - [x] It should be a single, continuous list widget
        - [x] Preferably this scroll view should be using `Slivers` and a `CustomScrollView`
    - [x] In the end, all data should be displayed in one continuous scrolling list
    - [x] Only visible items should be rendered (expect huge amounts of test data and a requirement to show images next to each contact)
- [x] Use any styling you want, stock Material widgets are fine
- [x] Only show groups that have entries
- [x] Each entry should be tappable (next screen may just show the name in "detail view"

### Additional

- [x] There should be the ability to show widgets on the top and below the list
    - For this challenge, we only want to inject a vertical list of buttons
- [x] A search field should be provided to filter down the list
    - When a search is active, the additional widgets should be hidden
- [x] Describe why a Scroll to index API is not as straightforward with normal `ListView` or `Sliver` widgets in the README of the project
- [x] Please finish your coding challenge with a short README outlining your thinking behind the implementation and any open issues you would want to explore if there were more time.

## Getting Started



This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
