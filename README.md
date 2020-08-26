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
    - [x] When a search is active, the additional widgets should be hidden
- [x] Describe why a Scroll to index API is not as straightforward with normal `ListView` or `Sliver` widgets in the README of the project
- [x] Please finish your coding challenge with a short README outlining your thinking behind the implementation and any open issues you would want to explore if there were more time.

## Implementation

### Design

The app's primary goal is to **display a list of contacts** provided by either a local or remote data source. Users also have the ability to **search** for specific contacts from the list or tap on tiles to **access further information**.

The graphical user interface and experience were tailored with the [Material](https://material.io/design/foundation-overview) design system in mind. Rather than adapting interface components to each platform's native look, a customized app theme was created to convey a unified look and feel of the *product*'s brand. Certain platform-defining characteristics were preserved (e.g. back button icons and transitions).

<p align="middle">
<img width="400" src=".github/theme-overview.png">
</p>

### Architecture

> “It is not enough for code to work.”

As [uncle Bob](https://books.google.com.br/books?id=_i6bDeoCQzsC&printsec=frontcover&dq=inauthor:%22Robert+C.+Martin%22&hl=pt-BR&sa=X&ved=2ahUKEwjy-tSez7frAhXsLLkGHU41CLMQ6AEwAHoECAQQAg#v=onepage&q&f=false) said, **even bad code can function**. To make sure it is also clean, this project's code is divided into four layers: `Presentation`, `Business Logic`, `Repository`, and `Data Source`.

- **Presentation layer** => Contains reactive [widgets](https://flutter.dev/docs/development/ui/widgets) which draw visual components to the screen (e.g. `MyContactTile`).
- **Business Logic** => Is implemented by using the [BLoC](https://www.didierboelens.com/2018/08/reactive-programming-streams-bloc/) design pattern, where a middleware listens to streams of events and output states mapped according to some business logic.
- **Repository** => Encapsualtes data access logic and exposes a single source of truth. Data can be retrieved from either a local or remote source.
- **Data Source** => Persistence or networking logic to retrieve data.

<p align="middle">
<img width="400" src=".github/frontend-architecture.png">
</p>


> “It is not enough for code to work.”
As uncle Bob said, **even bad code can function**. To make it also clean, this project's code is

The app's primary goal is to **display a list of contacts** provided by either a local or remote data source. Users also have the ability to **search** for specific contacts from the list or tap on tiles to **access further information** about their contacts.

The graphical user interface and experience were tailored with the [Material](https://material.io/design/foundation-overview) design system in mind. Rather than adapting interface components to each platform's native look, a customized app theme was created to convey a unified look and feel of the *product*'s brand. Certain platform-defining characteristics were preserved (e.g. back button icons and transitions).



This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
