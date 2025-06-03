# SwiftUI API Design Examples

This repository contains examples from a talk about API design in SwiftUI, demonstrating progressive disclosure and composable API patterns. Each example shows different approaches to designing SwiftUI component APIs.

## Examples

### View Styles
> Note: Components marked with ❌ cannot have custom styles created for them because their style protocols are private/internal in SwiftUI. This is a limitation of the current SwiftUI API design.

- `FormStyleView.swift` - Form API with progressive disclosure ✅
- `ListStyleView.swift` - List API customization ❌
- `MenuStyleView.swift` - Menu API design ✅
- `GaugeStyleView.swift` - Gauge API patterns ✅
- `LabelStyleView.swift` - Label API design ✅
- `TableStyleView.swift` - Table API patterns ❌
- `ButtonStyleView.swift` - Button API design ✅
- `PickerStyleView.swift` - Picker API patterns ❌
- `ToggleStyleView.swift` - Toggle API design ✅
- `TabViewStyleView.swift` - Tab view API patterns ❌
- `GroupBoxStyleView.swift` - Group box API design ✅
- `IndexStyleView.swift` - Index API patterns ❌
- `TextFieldStyleView.swift` - Text field API design ✅
- `DatePickerStyleView.swift` - Date picker API patterns ✅
- `TextEditorStyleView.swift` - Text editor API design ✅
- `ControlGroupStyleView.swift` - Control group API patterns ✅
- `ProgressViewStyleView.swift` - Progress view API design ✅
- `LabeledContentStyleView.swift` - Labeled content API patterns ✅
- `DisclosureGroupStyleView.swift` - Disclosure group API design ✅
- `NavigationSplitStyleView.swift` - Navigation split API patterns ❌

### Format Styles
- `RelationalFormatStyleView.swift` - Relational text format style API

### Composable Styles
- `ComposableStyles.swift` - Demonstrates composable API design patterns

## References

- [On Progressive Disclosure in Swift - Doug Gregor - Swift Craft 2025 Keynote Preview](https://www.youtube.com/watch?v=CRtyWqwLM3M&t=12s)
- [WWDC22: The craft of SwiftUI API design: Progressive disclosure | Apple](https://www.youtube.com/watch?v=mLsZmnW0kTo)
- [Composable Styles in SwiftUI](https://movingparts.io/composable-styles-in-swiftui) 