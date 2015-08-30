#iBeacons iOS和Swift教程

升级提示：这篇教程已经由Adrian Strahan更新到支持 iOS8 ，Swift1.2 和 Xcode6.3 了。[原始的文章](http://www.raywenderlich.com/66584/ios7-ibeacons-tutorial)是由 Tutorial Team 的成员 [Chris Wagner](http://www.raywenderlich.com/u/cwagdev) 创作的。

你有没有期待过有一天你可以在一个类似购物商场或者棒球场这么巨大的建筑中通过手机找到你所在的位置？

当然可以，GPS 足够让你知道你在建筑物的哪一边。但是要想在这些钢筋混凝土建筑中获得精确的GPS信号就不是那么轻松的了。你将需要通过建筑内部的某种设施来精确定位你的设备的物理坐标。

![Use Core Location and iBeacons to track distances from your phone!](http://cdn3.raywenderlich.com/wp-content/uploads/2014/03/iBeacons-250x250.png)

*Use Core Location and iBeacons to track distances from your phone!*

来看看 [iBeacons](http://en.wikipedia.org/wiki/IBeacon) 吧！在这个 `iBeacons` 的教程中你将会创建一个应用程序，它能够让你注册已知的 `iBeacons` 发射器并且在你的手机离开发射器范围的时候收到通知。在实际使用中，你可以将 `iBeacons` 发射器附加在任何你觉得重要并不想轻易丢失的东西上—手提电脑包，钱包，甚至你猫咪的项圈上，并且通过这个应用程序来追踪。一旦你的设备离开了这些发射器的有效范围，你的应用程序就能检测到变化并且通知你。

想要继续这篇教程，你需要在 iOS 真机和一个 `iBeacon` 设备上测试。如果你没有 `iBeacon` 但是有另一个 iOS 设备， 你也可以把它当做一个信标来用，往下读吧！

## 如何开始

其实有很多 `iBeacon` 的设备，快速的[谷歌搜索](https://www.google.com/search?client=safari&rls=en&q=ibeacon+hardware&ie=UTF-8&oe=UTF-8)可以让你更好的明白。但是当苹果介绍 iBeacon 的时候，他们也宣称任意 iOS 的设备都可以被当做一个 `iBeacon` 来使用。下面的列表目前包含了这么些设备：

*     iPhone 4s 或更新的设备
*     第三代 iPad 或更新的设备
*     iPad Mini 或更新的设备
*     第五代 iPod touch 或更新的设备

> 小贴士：如果你并没有一个单独的 iBeacon 发射器但是确实有另一台iOS设备并且支持 iBeacons，你可以遵照章节22—*What’s new in Core Location of [iOS 7 by Tutorials](http://www.raywenderlich.com/?page_id=48020)* 去创建一个像 `iBeacon` 一样工作的应用程序来继续这个教程。

一个 `iBeacon` 其实就是一个低功耗蓝牙设备，通过一个特定的结构来广播信息。这些特定的结构超出了这篇教程的范畴，但是要理解的很重要的一点就是 iOS 可以监听 `iBeacons` 发出的三种值，分别是 `UUID`, `major` 和 `minor`。

`UUID` 是 *universally unique identifier* 的首字母缩写，他是一个128位的值，通常以16进制字符串来显示，例如：`B558CBDA-4472-4211-A350-FF1196FFE8C8`。在 `iBeacons` 的应用中，`UUID`则用来标识你的最高层级的唯一身份。

最大值和最小值则提供了`UUID`之上更细微的粒度。这两个值都是16位无符号整数类型，他们可以唯一标识出每一个独立的 `iBeacon` ，甚至是那些`UUID`相同的设备都可以标识出来。

比方说，你有很多个百货商场，你希望你的这些商场中的 `iBeacons` 设备都拥有相同的`UUID`。虽然所有的设备都有相同的`UUID`，但是每一个商场都会有它自己的最大值，商场中的每一个商店都会有一个最小值。这样你的应用程序就可以根据其中的一个 `iBeacons` 设备定位到你在迈阿密，佛罗里达分店的鞋店了。

## “勿忘我”

这个新手教程的名称叫做“勿忘我”。你可以在[这里](http://cdn1.raywenderlich.com/wp-content/uploads/2015/04/ForgetMeNot-Swift-starter-project2.zip)下载到源代码，它包括了简单的从 `TableView` 中增删元素的界面。每一个元素都表示了一个单独的`iBeacon`发射器，在现实世界中，你可以将它们变成那些你不想轻易就找不到的东西。

编译和运行应用程序，你会看到一个空的列表，什么也没有。点击右上方的+按钮来添加一个物品，如下图所示：

![image](http://cdn5.raywenderlich.com/wp-content/uploads/2015/04/firstlaunch.png)

*初次运行*

要添加一个物品，你只要输入物品的名称和物品的`iBeacons`所响应的值。你可以通过浏览`iBeacon`的文档来找到你的`iBeacons`的`UUID`，尝试着加吧，不然就先用一些替代的值来使用：

![image](http://cdn3.raywenderlich.com/wp-content/uploads/2015/04/additem.png)

*添加一个物品*

点击 `Save` 回到物品列表，你会看到一个位置未知的物品：

![image](http://cdn4.raywenderlich.com/wp-content/uploads/2015/04/itemadded.png)

*已添加物品的列表*

你可以根据自己的需要来添加更多的物品，或者通过滑动来删除已经添加的物品。`NSUserDefaults`会持久化的存储列表中的物品，所以你重新进入应用程序也不会丢失这些数据。

表面上看什么事情也没发生，其实大多数有趣的部分都隐藏在背后！这个应用程序里最独特的地方就是用来表示列表中的物品的`Item`模型类。

打开`Item.swift`并且在Xcode中看看。这个类映射了界面上所显示的属性，并且遵照了`NSCoding`，这样才可以实现序列化和反序列化的持久化存储。

现在再来看看`AddItemViewController.swift`。这是一个用来添加新物品的控制器。它是个简单的`UITableViewController`，除此之外它还做了一些用户输入的合法性验证来保证用户输入的名称和`UUID`时合法的。

页面右上方的`Save`按钮会在`nameTextField`和`uuidTextField`都满足合法性验证条件的时候变成可点击的状态。

现在你已经了解了这个新手工程，你可以开始在你的工程里实现`iBeacons`啦！

##Core Location 授权
你的设备不会自动为你去监听其他的 `iBeacon` 设备，你需要做一些设置来告诉他这么做。`CLBeaconRegion`这个类代表了一个 `iBeacon`，`CL`前缀表示这是 `Core Location`框架的一部分。

因为 `iBeacon` 是通过蓝牙来进行数据传输的，因此在这里和 `Core Location` 产生联系也许会让你有些迷惑，但是仔细想想就会明白，`iBeacon`提供的是高精度的定位信息，而较低精度的定位信息我们则需要通过 GPS 来得到。如果你正在将一台 iOS 设备作为一个 `iBeacon` 设备来编程的话，你就需要借用 `Core Bluetooth` 框架，但是当你在真实的 `iBeacon` 设备上工作的时候，你只需要关心 `Core Location` 就好了。

好了，接下来是你要做的第一件事情：将 `Item` 改写为 `CLBeaconRegion`。

打开 Item.swift 然后在文件的头部加上如下引用：

```swift
import CoreLocation
```

接下来，修改一下 `majorValue` 和 `minorValue` 的定义，就像下面这个初始化器所展示的这样：

```swift
let majorValue: CLBeaconMajorValue
let minorValue: CLBeaconMinorValue
 
init(name: String, uuid: NSUUID, majorValue: CLBeaconMajorValue, minorValue: CLBeaconMinorValue) {
  self.name = name
  self.uuid = uuid
  self.majorValue = majorValue
  self.minorValue = minorValue
}
```

`CLBeaconMajorValue` 和 `CLBeaconMinorValue` 都是 `UInt16` 的一种别名，并且在 `CoreLocation` 框架中分别用来表示 `major` 和 `minor` 值。

尽管他们底层的数据类型是一样的，不同的命名能够增强阅读性，同时能够增强安全性 —— 因为你不会轻易的弄混他们了。

继续！打开 `ItemsViewController.swift`，同样在文件头部加上 `CoreLocation` 的引用：

```swift
import CoreLocation
```

然后将下面的属性添加到 `ItemsViewController`：

```swift
let locationManager = CLLocationManager()
```

这个 `CLLocationManager` 实例将会作为你进入 `CoreLocation` 的入口。

接下来，用下面的方法替换掉你的 `viewDidLoad()`：

```swift
override func viewDidLoad() {
  super.viewDidLoad()
 
  locationManager.requestAlwaysAuthorization()
 
  loadItems()
}
```

调用 `requestAlwaysAuthorization()` 将会提示用户授权访问位置服务 —— 当然如果他们已经授权，系统的提示就不会出现。`始终` 和 `使用应用程序期间` 是 iOS8 中位置服务权限的新形式。当用户给应用程序授权了 `始终` ，应用程序就可以在不论是前台还是后台运行的情况下调用任何可用的位置服务。

由于这篇教程将会覆盖 `iBeacon` 的区域监听，你需要的是 `始终` 的位置服务权限，这样我们才可以在任何时候监听到设备的事件。

iOS8 要求你在 `Info.plist` 中设置一个字符串的值作为你获取用户位置信息的时候展示给用户的提示信息。如果你没有设置这个，位置服务也不会生效，你也甚至不会从编译器得到一个警告。

打开 `Info.plist` 并且点击 `Information Property List` 这一行上的 + 来添加一项。

![image](http://cdn1.raywenderlich.com/wp-content/uploads/2015/04/plistwithoutentry.png)

不幸的是，你需要添加的键并不在预先定义好的下拉列表里，所以你需要手动输入键的名称。将这个键命名为 `NSLocationAlwaysUsageDescription` 并且保证它的类型是 `String`。接着，写上你需要从用户那里获取位置信息的原因，比方说：“ForgetMeNot 想要教你如何使用 iBeacons!”。

![image](http://cdn3.raywenderlich.com/wp-content/uploads/2015/04/plistwithentry.png)

编译运行你的应用程序，你将会看到一个获取位置信息的提示信息：

![image](http://cdn1.raywenderlich.com/wp-content/uploads/2015/04/allowlocation-281x500.jpg)

*允许获取位置信息*

选择同意，这样程序就可以追踪你的 `iBeacon` 的位置啦。

##监听你的 `iBeacon`

现在你的应用程序已经拥有了必要的位置信息获得权限，是时候去找到这些设备了！在 `ItemsViewController.swift` 的最底部添加如下的类扩展：

```swift
// MARK: - CLLocationManagerDelegate
 
extension ItemsViewController: CLLocationManagerDelegate {
}
```

这将声明 `ItemsViewController` 遵照 `CLLocationManagerDelegate` 协议。你可以在这个扩展中添加委托方法的实现，这样他们就可以很好地聚集在一起了。

接下来，在 `viewDidLoad()` 的最后加上下面这行：

```swift
locationManager.delegate = self
```

这会将 `CLLocationManager` 的委托指向 `self`，你才能接收到委托方法的回调。

现在你拥有了一个 `CLLocationManager` 的实例了，你现在可以使用 `CLBeaconRegion` 来让你的应用程序监听指定区域啦！当你要注册一个需要监听的区域的时候，这些区域在你的应用程序每一次的启动之间都是存在的。这对于之后要做的当你的应用程序没有在运行的时候也能监听区域边界的触发事件是很重要的。

列表中你的 `iBeacon` 设备都会被表示为 `items` 数组属性中的 `Item` 模型。 `CLLocationManager` 需要你提供一个 `CLBeaconRegion` 实例好让它能开始监听一个区域。

在 `ItemsViewController.swift` 中的 `ItemsViewController` 类中创建下述方法：

```swift
func beaconRegionWithItem(item:Item) -> CLBeaconRegion {
  let beaconRegion = CLBeaconRegion(proximityUUID: item.uuid,
                                            major: item.majorValue,
                                            minor: item.minorValue,
                                       identifier: item.name)
  return beaconRegion
}
```

这将会根据提供的 `Item` 对象返回一个新的 `CLBeaconRegion` 实例。

你能看到这些类在结构上彼此很相似，因此想要创建一个 `CLBeaconRegion` 的实例显得十分的直接 —— 因为它拥有 `UUID` , `major value` 和 `minor value` 的直接同名属性。

现在你需要一个方法来开始监听一个设备。接下来在 `ItemsViewController` 中添加下述方法：

```swift
func startMonitoringItem(item: Item) {
  let beaconRegion = beaconRegionWithItem(item)
  locationManager.startMonitoringForRegion(beaconRegion)
  locationManager.startRangingBeaconsInRegion(beaconRegion)
}
```

这个方法需要传入一个 `Item` 的实例并且通过你上面定义的方法生成一个 `CLBeaconRegion` 实例。它会接着让 `locationManager` 开始监听给定的区域，并且开始在这个区域内搜索 `iBeacon`。

搜索是一个在指定区域发现 `iBeacon` 设备并确定距离的过程。当一个 iOS 设备收到来自 `iBeacon` 设备的传输信息的时候，它能够计算出较为精确的从 `iBeacon` 到 iOS 设备的距离。这个距离（在发送消息的 `iBeacon` 和接收消息的设备之间的距离）被分类成3种不同的范围：

* `Immediate` 只有几厘米的距离了
* `Near` 几米以内的距离
* `Far` 10米以上的距离

>小贴士：`Far`，`Near`，`Immediate` 三种范围的确切距离并没有明确的在文档中给出，但是这一个[ StackOverflow 的提问](http://stackoverflow.com/questions/19007306/what-are-the-nominal-distances-for-ibeacon-far-near-and-immediate)对这些距离的确切值提供了一个大致的看法。

默认情况下，无论你的应用是否在运行，监听都会在区域有物体进入和离开的时候告知你。而搜索这个操作还可以在应用运行的状态下监听物体在区域中的距离。

你也将需要在删除了一个设备之后停止对它的区域的监听。因此在 `ItemsViewController` 中添加下面的方法：

```swift
func stopMonitoringItem(item: Item) {
  let beaconRegion = beaconRegionWithItem(item)
  locationManager.stopMonitoringForRegion(beaconRegion)
  locationManager.stopRangingBeaconsInRegion(beaconRegion)
}
```

上述方法只是反转了 `startMonitoringItem(_:)` 产生的结果并且让 `CLLocationManager` 停止监听和搜索的操作。

现在你已经写好了开始和结束的方法了，是时候让他们发挥作用了！最合适的开始监听的位置自然是当用户向列表中添加了一个新的设备的时候。

看一看 `ItemsViewController.swift` 中的 `saveItem(_:)` 方法，这个 `unwind segue` 会在用户点击 `AddItemViewController` 中的保存按钮的时候被调用并且同时创建一个新的 `Item` 对象。找到方法中对 `persistItems()` 的调用并且在这个调用前面加上下述一行代码：

```swift
startMonitoringItem(newItem)
```

这将会在用户保存一个新的 `item` 的时候开始监听。同理，当应用程序启动的时候，程序会从 `NSUserDefaults` 加载持久化存储的数据，这也意味着你也需要在启动的时候调用开始监听的方法。

在 `ItemsViewController.swift` 中找到 `loadItems()` 这个方法然后在内部的 `for` 循环中添加下述一行代码：

```swift
startMonitoringItem(item)
```

这能保证每一个 `item` 都能被监听到。

现在我们要着眼于从列表中删除 `item` 了。找到 `tableView(_:commitEditingStyle:forRowAtIndexPath:)` 然后在 `itemToRemove` 的声明之后添加下述一行代码：

```swift
stopMonitoringItem(itemToRemove)
```

这个 `tableview` 的委托方法在用户删除任意一行的时候被调用。现有的代码处理了从模型和界面删除的操作，你刚刚添加的那行代码也将使你的程序停止对这个 `item` 的监听。

到此为止你已经有了很大的进步啦！你的程序现在已经能够合理的对指定的 `iBeacon` 设备启动和停止监听了。

现在，你可以编译运行一下你的应用程序了，但即使你的 `iBeacon` 设备在你的应用程序的监听范围内，你的程序也还没有任何响应事件的实现，所以现在我们就开始解决这个问题吧！

##当找到 `iBeacon` 的时候的响应

既然你的 `location manager` 已经在监听你的 `iBeacon` 设备了，是时候实现一些 `CLLocationManagerDelegate` 的方法来响应他们了。

首要任务是添加一些错误处理，因为你将会处理一些非常特定的设备硬件特性，如果没有详细的错误提示，你将无法知道你的监听或者搜索为什么挂了。

在 `CLLocationManagerDelegate` 委托的类扩展中添加下述两个方法，你在上文中已经在 `ItemsViewController.swift` 的最底部定义了这一个扩展：

```swift
func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
  println("Failed monitoring region: \(error.description)")
}
 
func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
  println("Location manager failed: \(error.description)")
}
```

这两个方法会简单打印出监听 `iBeacons` 时可能产生的错误日志。

当然，如果一切都很顺利的话，你永远也不会看到这两个方法所打印的日志。然而，一旦发生了错误，打印出来的错误日志很可能为你提供十分有用的信息。

下一步我们需要实时的将程序对 `iBeacon` 设备能够感知到的距离显示出来。在 `CLLocationManagerDelegate` 类扩展中添加下述暂时没有返回值的方法：

```swift
func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
  if let beacons = beacons as? [CLBeacon] {
    for beacon in beacons {
      for item in items {
        // TODO: Determine if item is equal to ranged beacon
      }
    }
  }
}
```

这个委托方法会在 `iBeacon` 设备进入监听范围，离开监听范围，或者监听范围改变的时候被调用。

你的程序的目标是通过这个委托方法提供的 `iBeacon` 数组来更新列表中的数据并且显示他们的距离。你需要从遍历 `beacons` 数组开始，然后再遍历你的 `items` 数组来寻找他们之前的匹配。你会很快回到 `TODO`这里的。

进入 `Item.swift` 并且在 `Item` 类中添加下述属性：

```swift
dynamic var lastSeenBeacon: CLBeacon?
```

这个属性保存了指定 `item` 最后对应的 `CLBeacon` 实例，这会被用来显示距离信息。这个属性有一个 `dynamic` 修饰符，这样你才能在接下来的教程中为其添加一个 `KVO`。

现在在文件底部添加下述的等式操作符的重载，记得要添加在类的定义之外：

```swift
func ==(item: Item, beacon: CLBeacon) -> Bool {
  return ((beacon.proximityUUID.UUIDString == item.uuid.UUIDString)
    && (Int(beacon.major) == Int(item.majorValue))
    && (Int(beacon.minor) == Int(item.minorValue)))
}
```

这个等式方法会比较一个 `CLBeacon` 实例和一个 `Item` 实例是否相等 —— 也就意味着三个主要的属性都相等。在这种情况下，如果一个 `CLBeacon` 实例和一个 `Item` 实例的 `UUID`, `major value` 和 `minor value` 都相等，这两者就是相等的。

现在你需要通过调用上面的方法来完成搜索的委托方法。打开 `ItemsViewController.swift` 然后回到 `locationManager(_:didRangeBeacons:inRegion:)`。用下述代码替换掉 `for` 循环中的 `TODO` 注释：

```swift
if item == beacon {
  item.lastSeenBeacon = beacon
}
```

在这里，你就在你匹配到一个 `item` 对应的 `iBeacon` 设备的时候设置了它的 `lastSeenBeacon` 。因为有了你的等式运算符，寻找 `item` 和 `iBeacon` 的对应关系变得简单多了！

现在，是时候使用这个属性来显示搜索到的 `iBeacon` 的距离了。

进入 `ItemCell.swift` 并且在 `item` 的属性观察器 `didSet` 方法的开头添加下述代码：

```swift
item?.addObserver(self, forKeyPath: "lastSeenBeacon", options: .New, context: nil)
```

当你为每一个 `cell` 设置 `item` 的时候你同时也添加了一个对于 `lastSeenBeacon` 属性的观察器。为了保持合理的均衡，你也需要在 `cell` 已经设置了一个 `item` 的时候移除这个观察器，这也是 `KVO` 模式所要求的。在 `didSet` 后添加一个 `willSet` 属性观察器。确保它仍然在 `item` 属性中。

```swift
willSet {
  if let thisItem = item {
    thisItem.removeObserver(self, forKeyPath: "lastSeenBeacon")
  }
}
```

这能保证只有一个属性正在被观察。

你也需要在 `cell` 被释放的时候移除观察器。还是在 `ItemCell.swift`，在 `ItemCell` 类中添加下述释放方法：

```swift
deinit {
  item?.removeObserver(self, forKeyPath: "lastSeenBeacon")
}
```

现在你已经在保持对值的观察了，你可以对 `iBeacon` 的距离变化的响应添加一些逻辑啦。

每一个 `CLBeacon` 实例都有一个名为 `proximity` 的属性，这是一个枚举类型，包括了 `Far` ，`Near` ，`Immediate` ，`Unknown` 几种值。

在 `ItemCell.swift` 中，添加对于 `CoreLocation` 的引用声明：

```swift
import CoreLocation
```

接下来，在 `ItemCell` 类中添加下述方法：

```swift


func nameForProximity(proximity: CLProximity) -> String {
  switch proximity {
  case .Unknown:
    return "Unknown"
  case .Immediate:
    return "Immediate"
  case .Near:
    return "Near"
  case .Far:
    return "Far"
  }
}
```

这会根据 `proximity` 返回一个我们能看得懂的距离值，你等会会用到的。

现在添加下述方法：

```swift
override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
  if let anItem = object as? Item where anItem == item && keyPath == "lastSeenBeacon" {
    let proximity = nameForProximity(anItem.lastSeenBeacon!.proximity)
    let accuracy = String(format: "%.2f", anItem.lastSeenBeacon!.accuracy)
    detailTextLabel!.text = "Location: \(proximity) (approx. \(accuracy)m)"
  }
}
```

你会在每次 `lastSeenBeacon` 的值变化的时候调用上面的方法，它会设置 `cell` 的 `detailTextLabel.text` 属性值为 `CLBeacon` 的感知距离值和大致的精度。

后面的那个值也许会随着周围的一些电子干扰有一些波动。无论你的设备和 `iBeacon` 设备是否在移动都是可能发生的，所以它对于获取 `iBeacon` 的精确位置并不是那么可靠。

现在确保你的 `iBeacon` 设备已经在你的应用程序中注册，并且移动设备来改变他们之间的距离。你将会看到标签上的显示会随着你的移动更新，就像下面这样：

![image](http://cdn1.raywenderlich.com/wp-content/uploads/2015/04/itemnear.jpg)

你可能会发现这个感知距离和精度完全是被你的 `iBeacon` 所在的物理位置所影响着。如果它被放在包或是一个盒子里，`iBeacon` 的信号可能就被屏蔽了 —— 因为它是一个非常低功率的设备，它的信号很容易就被削弱了。

在设计你的程序的时候牢牢记住这点 —— 当然，当你要决定放置 `iBeacon` 设备的最佳位置的时候，也别忘了这点。

## 通知

到这里看起来我们已经做得足够好了：你有了一个 `iBeacon` 设备的列表并且可以实时的监听他们和你的距离。但是这并不是你的程序要做的最终目标。当应用程序没有在运行的时候，你仍然需要时刻准备着通知用户，以防他们什么时候忘记了自己的电脑包或者一不留神猫就走丢了，甚至有些人的猫在走丢的时候还会带着他们的电脑包！:]

![image](http://cdn4.raywenderlich.com/wp-content/uploads/2014/03/zorro-ibeacon.jpg)

他们看起来很天真对不对？

在这里，你可能已经注意到我们在程序中并没有用太多代码就实现了 `iBeacon` 的基本功能。所以添加一个在你的猫走丢的时候能及时通知你的功能也并不难嘛！

进入 `AppDelegate.swift` 然后添加下述引用：

```swift
import CoreLocation
```

接下来，使 `AppDelegate` 类遵照 `CLLocationManagerDelegate` 协议，在 `AppDelegate.swift` 的最下方添加下述代码(在右大括号下方)：

```swift
// MARK: - CLLocationManagerDelegate
extension AppDelegate: CLLocationManagerDelegate {
}
```

像之前一样，你需要初始化 `location manager` 并且相应地设置它的委托。

为 `Appdelegate` 类添加一个新的 `locationManager` 属性，并用一个 `CLLocationManager` 实例来初始化它：

```swift
let locationManager = CLLocationManager()
```

然后在 `application(_:didFinishLaunchingWithOptions:)` 的开始处添加下述声明：

```swift
locationManager.delegate = self
```

回想一下所有你用 `startMonitoringForRegion(_:)` 来添加并监听的区域，他们在你的应用程序中可以被所有的 `location manager` 共享。当一个区域的边界被触发的时候，`Core Location` 会唤醒你的程序，这个时候我们只需要完成最后的一步，那就是简单地响应这个事件就好了。

还记得刚才你在 `AppDelegate.swift` 中添加的类扩展吗？在里面添加下述的方法吧： 

```swift
func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
  if let beaconRegion = region as? CLBeaconRegion {
    var notification = UILocalNotification()
    notification.alertBody = "Are you forgetting something?"
    notification.soundName = "Default"
    UIApplication.sharedApplication().presentLocalNotificationNow(notification)
  }
}
```

你的 `location manager` 会在你离开一个区域的时候调用上面的方法，这也是你的应用程序有趣的一点。你不需要在你靠近你的笔记本电脑包的时候收到通知 —— 只有你离开它太远的时候才会。

这里你需要检查这里的 `region` 是否是一个 `CLBeaconRegion` 类的实例，因为它也有可能是 `CLCircularRegion` 的实例 —— 当你在使用地理位置区域的监听的时候。然后你会发送一个本地的通知，内容为“你是不是遗忘了什么？”。

在 iOS8 和之后的版本里，应用程序不论是使用本地还是远程推送都需要注册他们想要传递的通知类型。系统就可以让用户来自己选择需要显示的通知类型。如果相应的通知的类型在你的应用程序中没有被注册，即使你在通知里声明了通知的类型，系统也不会显示数量的角标和提示信息，也不会有新通知的提示声音。

在 `application(_:didFinishLaunchingWithOptions:)` 的最开始添加下述代码：

```swift
let notificationType:UIUserNotificationType = UIUserNotificationType.Sound | UIUserNotificationType.Alert
let notificationSettings = UIUserNotificationSettings(forTypes: notificationType, categories: nil)
UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
```

这里只是简单地声明了当应用收到一个新的通知的时候，系统会显示提示消息并且播放提示声音。

编译运行你的程序，确保你的程序里能够看到一个已注册的 `iBeacon` 设备并且通过点击 `Home` 键将程序放在后台运行。这是一个现实生活中的场景，特别是当你正在被其他程序或事情占用的时候，你想要应用程序提醒你，也许这是另一个 `Ray Wenderlich` 教程的应用程序？:]现在拿走你的 `iBeacon`，一旦你离得足够远了，你就会看到弹出来的通知：

![image](http://cdn3.raywenderlich.com/wp-content/uploads/2015/04/notification.jpg)

>小贴士：苹果在没有文档说明的情况下延迟了离开区域的通知。这也许是设计的时候就这么考虑了，这样你的应用程序就不会过于草率的收到一大堆推送，特别是当你正在区域的边缘来回移动或者 `iBeacon` 设备的信号变得时断时续的时候。根据我的经验来看，离开区域的通知通常会在 `iBeacon` 设备离开了区域差不多一分钟的时候出现。

## 我还需要做什么？

没有成功绑定到一个 `iBeacon` 设备吗？你可以[在这里](http://cdn3.raywenderlich.com/wp-content/uploads/2015/04/ForgetMeNot-Swift-final-project2.zip)下载到最终的工程，这里面有你在这个教程里完成的所有东西。

你现在有了一个非常有用的应用程序，他可以用来帮你监控那些让你觉得记住他们的位置十分费劲的物品。加上一点点的想象力和编程的高超技巧，你可以为这个程序添加许多超级有用的功能：

* 告知用户哪一个设备离开了区域
* 重复发送通知，确保用户看到了通知
* 当`iBeacon`设备回到区域中的时候通知用户

这篇教程只不过是揭开了你用 `iBeacon` 能实现的事情的很表面的部分。

`iBeacon` 不仅仅局限于自定义的应用程序，你可以把他们当成 Passbook 的通行证来使用。比方说，如果你运营着一个电影院，你可以将你的电影票以 Passbook 的通行证的形式卖出去。当你的老顾客们走过一个带有 `iBeacon` 设备的收票员的时候，他们的应用程序就会自动的把票显示在他们的手机上了！

如果你关于这篇教程还有任何问题或者评论，或者你对于 `iBeacon` 的使用有什么屌炸天的想法， 请随意的加入下面的讨论吧！