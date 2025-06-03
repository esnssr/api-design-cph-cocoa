//
//  IndexStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct IndexStyleView: View {
    
    @State private var selectedPage = 0

    var body: some View {
        TabView(selection: $selectedPage) {
            ForEach(0..<3) { index in
                VStack {
                    Text("Page \(index + 1)")
                        .font(.largeTitle)
                        .bold()
                    Image(systemName: "circle.fill")
                        .font(.system(size: 60))
                }
                .tag(index)
            }
        }
#if !os(macOS)
        .tabViewStyle(.page)
        .indexViewStyle(CustomIndexStyle())
#endif
    }
}

struct CustomIndexStyle: IndexViewStyle {
    // use AnyView so we can build anything we want.
    typealias _Body = AnyView

    func _makeBody(configuration: IndexViewStyle._Configuration) -> AnyView {
        /*
         IndexViewStyle is a much more complicated object than
         TableStyle, so even though we can see what the properties are,
         it will be veeeery tricky to recreate, since it uses a lot of internal
         types.
         below is a the description log of the configuration

         ▿ _IndexViewStyleConfiguration
         ▿ _index : Binding<Int>
         ▿ transaction : Transaction
         ▿ plist : []
         - elements : nil
         ▿ location : <LocationBox<ScopedLocation>: 0x600000c717d0>
         - _value : 0
         ▿ content : _VariadicView_Children
         ▿ list : ModifiedViewList<AccessibilityContainerModifier>
         ▿ base : ForEachList<Range<Int>, Int, ModifiedContent<ModifiedContent<VStack<TupleView<(Text, ModifiedContent<Image, _EnvironmentKeyWritingModifier<Optional<Font>>>)>>, _TraitWritingModifier<TagValueTraitKey<Int>>>, _TraitWritingModifier<TagValueTraitKey<Optional<Int>>>>>
         ▿ state : <ForEachState<Range<Int>, Int, ModifiedContent<ModifiedContent<VStack<TupleView<(Text, ModifiedContent<Image, _EnvironmentKeyWritingModifier<Optional<Font>>>)>>, _TraitWritingModifier<TagValueTraitKey<Int>>>, _TraitWritingModifier<TagValueTraitKey<Optional<Int>>>>>: 0x10720f6f0>
         - seed : 1
         ▿ modifier : #11681
         ▿ base : #11681
         ▿ _details : __Unnamed_struct__details
         ▿ identifier : #11681
         - rawValue : 11681
         - seed : 8
         ▿ inputs : _GraphInputs
         ▿ customInputs : [StyleableViewContextInput = nil, SourceInput<Content> = empty, ViewListShouldParentToPlaceholderSubgraph = false, SourceInput<Content> = node(value: SwiftUI.(unknown context at $1d3ce6160).AnySource(formula: SwiftUI.(unknown context at $1d3ce6104).SourceFormula<SwiftUI.ModifiedContent<SwiftUI.ModifiedContent<SwiftUI.ForEach<Swift.Range<Swift.Int>, Swift.Int, SwiftUI.ModifiedContent<SwiftUI.ModifiedContent<SwiftUI.VStack<SwiftUI.TupleView<(SwiftUI.Text, SwiftUI.ModifiedContent<SwiftUI.Image, SwiftUI._EnvironmentKeyWritingModifier<Swift.Optional<SwiftUI.Font>>>)>>, SwiftUI._TraitWritingModifier<SwiftUI.TagValueTraitKey<Swift.Int>>>, SwiftUI._TraitWritingModifier<SwiftUI.TagValueTraitKey<Swift.Optional<Swift.Int>>>>>, SwiftUI.StyleContextWriter<SwiftUI.ContainerStyleContext>>, SwiftUI.AccessibilityContainerModifier>>, value: #10433, valueIsNil: nil), next: SwiftUI.Stack<SwiftUI.(unknown context at $1d3ce6160).AnySource>.empty), ReusableInputs = ReusableInputStorage(filter: SwiftUI.BloomFilter(value: 8875180060), stack: SwiftUI.Stack<SwiftUI.GraphInput.Type>.node(value: SwiftUI.(unknown context at $1d3ce6184).SourceInput<SwiftUI.TabViewStyleConfiguration<Swift.Int>.Content>, next: SwiftUI.Stack<SwiftUI.GraphInput.Type>.node(value: SwiftUI.(unknown context at $1d4809f48).StyleInput<SwiftUI._IndexViewStyleConfiguration>, next: SwiftUI.Stack<SwiftUI.GraphInput.Type>.node(value: SwiftUI.(unknown context at $1d47f074c).BodyInput<SwiftUI._ViewModifier_Content<SwiftUI.RootModifier>>, next: SwiftUI.Stack<SwiftUI.GraphInput.Type>.node(value: SwiftUI.(unknown context at $1d47f074c).BodyInput<SwiftUI._ViewModifier_Content<SwiftUI.EditModeScopeModifier>>, next: SwiftUI.Stack<SwiftUI.GraphInput.Type>.empty))))), IsInLazyContainer = true, TabViewStyleInput = Optional(SwiftUI.(unknown context at $1d3c9eaa4).AnyStyle(type: SwiftUI.(unknown context at $1d3c9e950).StyleType<SwiftUI.PageTabViewStyle>, value: #10033)), StyleInput<_IndexViewStyleConfiguration> = node(value: SwiftUI.(unknown context at $1d4809f24).AnyStyleModifier(value: #9937, _type: SwiftUI.(unknown context at $1d4809fe8).StyleModifierType<SwiftUI.IndexViewStyleModifier<api_design_examples.CustomIndexStyle>>), next: SwiftUI.Stack<SwiftUI.(unknown context at $1d4809f24).AnyStyleModifier>.empty), ReusableInputs = ReusableInputStorage(filter: SwiftUI.BloomFilter(value: 8875180056), stack: SwiftUI.Stack<SwiftUI.GraphInput.Type>.node(value: SwiftUI.(unknown context at $1d4809f48).StyleInput<SwiftUI._IndexViewStyleConfiguration>, next: SwiftUI.Stack<SwiftUI.GraphInput.Type>.node(value: SwiftUI.(unknown context at $1d47f074c).BodyInput<SwiftUI._ViewModifier_Content<SwiftUI.RootModifier>>, next: SwiftUI.Stack<SwiftUI.GraphInput.Type>.node(value: SwiftUI.(unknown context at $1d47f074c).BodyInput<SwiftUI._ViewModifier_Content<SwiftUI.EditModeScopeModifier>>, next: SwiftUI.Stack<SwiftUI.GraphInput.Type>.empty)))), ViewListOptionsInput = Options(rawValue: 0), BodyInput<_ViewModifier_Content<RootModifier>> = empty, PresentedSceneValueInput = #5273, BodyInput<_ViewModifier_Content<RootModifier>> = node(value: SwiftUI.(unknown context at $1d47f0728).BodyInputElement.view((Function)), next: SwiftUI.Stack<SwiftUI.(unknown context at $1d47f0728).BodyInputElement>.empty), ReusableInputs = ReusableInputStorage(filter: SwiftUI.BloomFilter(value: 8875147272), stack: SwiftUI.Stack<SwiftUI.GraphInput.Type>.node(value: SwiftUI.(unknown context at $1d47f074c).BodyInput<SwiftUI._ViewModifier_Content<SwiftUI.RootModifier>>, next: SwiftUI.Stack<SwiftUI.GraphInput.Type>.node(value: SwiftUI.(unknown context at $1d47f074c).BodyInput<SwiftUI._ViewModifier_Content<SwiftUI.EditModeScopeModifier>>, next: SwiftUI.Stack<SwiftUI.GraphInput.Type>.empty))), BodyInput<_ViewModifier_Content<EditModeScopeModifier>> = empty, BodyInput<_ViewModifier_Content<EditModeScopeModifier>> = node(value: SwiftUI.(unknown context at $1d47f0728).BodyInputElement.view((Function)), next: SwiftUI.Stack<SwiftUI.(unknown context at $1d47f0728).BodyInputElement>.empty), ReusableInputs = ReusableInputStorage(filter: SwiftUI.BloomFilter(value: 268435464), stack: SwiftUI.Stack<SwiftUI.GraphInput.Type>.node(value: SwiftUI.(unknown context at $1d47f074c).BodyInput<SwiftUI._ViewModifier_Content<SwiftUI.EditModeScopeModifier>>, next: SwiftUI.Stack<SwiftUI.GraphInput.Type>.empty)), TextAlwaysOnProviderKey = Optional(SwiftUI.SwiftUITextAlwaysOnProvider), UIKitHostContainerFocusItemInput = #4168, InterfaceIdiomInput = Optional(SwiftUI.AnyInterfaceIdiom(base: SwiftUI.(unknown context at $1d4817464).InterfaceIdiomBox<SwiftUI.PhoneInterfaceIdiom>)), GestureContainerFactoryInput = Optional(SwiftUI.UIKitGestureContainerFactory), EventBindingBridgeFactoryInput = Optional(SwiftUI.UIKitResponderEventBindingBridge.Factory), AccessibilityRelationshipScope = Optional(SwiftUI.AccessibilityRelationshipScope), OpacityAccessibilityProviderKey = SwiftUIOpacityAccessibilityProvider, GestureAccessibilityProviderKey = SwiftUIGestureAccessibilityProvider, LayoutAccessibilityProviderKey = SwiftUILayoutAccessibilityProvider, PrivacyReductionAccessibilityProviderKey = SwiftUIPrivacyReductionAccessibilityProvider, ImageAccessibilityProviderKey = SwiftUIImageAccessibilityProvider, TextAccessibilityProviderKey = SwiftUITextAccessibilityProvider, AccessibilityFocusInputKey = #3752, AccessibilityFocusStoreInputKey = #3696, IsFocusSystemEnabledKey = #3664, FocusStoreInputKey = #3608, FocusedValuesInputKey = #3528, FocusedItemInputKey = #3492, MatchedGeometryScope = Optional(SwiftUI.(unknown context at $1d47f4dfc).MatchedGeometryScope)]
         ▿ elements : Optional<Element>
         ▿ some : StyleableViewContextInput = nil
         ▿ time : #2584
         ▿ identifier : #2584
         - rawValue : 2584
         ▿ cachedEnvironment : <MutableBox<CachedEnvironment>: 0x600002615f80>
         ▿ phase : #11560
         ▿ identifier : #11560
         - rawValue : 11560
         ▿ transaction : #11520
         ▿ identifier : #11520
         - rawValue : 11520
         ▿ changedDebugProperties : Properties
         - rawValue : 120
         ▿ options : Options
         - rawValue : 4326
         ▿ mergedInputs : 3 elements
         ▿ 0 : #2744
         - rawValue : 2744
         ▿ 1 : #2672
         - rawValue : 2672
         ▿ 2 : #10264
         - rawValue : 10264
         - contentSubgraph : <AGSubgraph 0x6000002547c0 [0x1e3a77680]>
         ▿ transform : _ViewList_SublistTransform
         - items : 0 elements
         */
        debugPrint(configuration)
        return AnyView(
            Text("Index")
        )
    }
}

#Preview {
    IndexStyleView()
}
