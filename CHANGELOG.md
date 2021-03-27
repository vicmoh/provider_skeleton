## [0.0.22] - 27/03/21

- Added dispose check for view logic.
- This can be useful to prevent logic being
  called when it already been disposed.

## [0.0.21] - 11/28/20

- [UniquefyListModel] bug fix on presort newly add items
  where it would presort previous data to to pointing
  to same pointer. Fix by copying new list to be added.
- Update dart util package.

## [0.0.20] - 10/22/20

- [UniquefyListModel] breaking changes.
- Added changes [oderBy] by [init] function.
- Added presort option on [init].

## [0.0.19] - 10/22/20

- Adding items or replacing items on [UniquefyListModel]
  no longer sort by timestamp. Will be default to based on
  first come first serve.

## [0.0.1] - TODO: Add release date.

- TODO: Describe initial release.
