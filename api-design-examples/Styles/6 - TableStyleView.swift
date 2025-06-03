//
//  TableStyleView.swift
//  api-design-examples
//
//  Created by Eslam Nasser on 2025-06-02.
//

import SwiftUI

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
}

struct TableStyleView: View {

    let people = [
        Person(name: "Alice", age: 28),
        Person(name: "Bob", age: 34),
        Person(name: "Charlie", age: 22)
    ]

    var body: some View {
        Table(people) {
            TableColumn("Name", value: \.name)
            TableColumn("Age") { person in
                Text("\(person.age)")
            }
        }
        .frame(width: 300, height: 200)
        .tableStyle(CustomTableStyle())
    }
}

struct CustomTableStyle: TableStyle {
    func makeBody(configuration: Configuration) -> some View {

        // TL;DR: Configuration is useless here, but feel free to read my findings about it.

        /*
         Apple doesn't expose any public APIs that allow us
         to create custom table styles. i don't know why, but maybe
         because they want to maintain a certain look for all tables.
         but unlike other styles that just shout private APIs at our face,
         this one does have a public interface, and it does pass in a Configuration
         object. sadly, this configuration doesn't have any public properties we can access, so it's pretty much useless.
         if we print it's description in the console, we get the following: 👇🏼

                    ▿ TableStyleConfiguration
                        - selection : nil
                        - sortOrder : nil
                        - columnCustomization : nil
                        - rows : SwiftUI.TableStyleConfiguration.RowsAlias()
                        - columns : SwiftUI.TableStyleConfiguration.ColumnsAlias()

         interesting. `selection`, `sortOrder` are obviously nil because we don't
         pass any above when using the Table. but they have interesting values

         selection -> SwiftUI.Binding<SwiftUI.SelectionManagerBox<AnyHashable>>?
         sortOrder -> SwiftUI.Binding<[SwiftUI.SwiftUIAnySortComparator]>?

         those are internal APIs. but they are optional in the object, just like `columnCustomization`

         columnCustomization -> SwiftUI.Binding<SwiftUI.AnyTableColumnCustomization>?

         ummm, okay. the last two, rows and columns, they look like they are just empty closures?
         */
        debugPrint(configuration)
        let config = _Configuration()

        /*
         if we create an object that matches the Configuration's type and try to cast it, it works?
         but this doesn't help us and we still can't style the table.
         trying to change any of the casted object we create results in cast failure, and since we
         can't access any content or labels, the configuration is pretty much useless for us 😔

         Note: as of 2025-06-02, the code below runs for now, but if Apple changes the configurations's object signature,
         the casting code will result in a runtime failure error. 💥
         */
        let veryDangerousConfig = unsafeBitCast(config, to: TableStyle.Configuration.self)
        return Text(String(describing: configuration) + String(describing: veryDangerousConfig))
    }
}

// type erased identifiable object to use in the casted config.
struct AnyIdentifiable: Identifiable {

    var id: ObjectIdentifier {
        ObjectIdentifier(value)
    }

    let value: any Identifiable & AnyObject

    init<V: Identifiable & AnyObject>(value: V) {
        self.value = value
    }
}

// a configuration object that *matches* the
struct _Configuration {
    let selection: Any? = nil
    let sortOrder: (any SortComparator)? = nil
    let columnCustomization: TableColumnCustomization<AnyIdentifiable>? = nil
    let rows: () -> Void = {}
    let columns: () -> Void = {}
}

#Preview {
    TableStyleView()
}
