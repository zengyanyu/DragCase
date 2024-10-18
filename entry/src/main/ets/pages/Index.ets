@Entry
@Component
struct Index {
  @State
  list: PeopleItem[] = [
    { name: '张三', age: 20, sex: '男' ,work:'互联网'},
    { name: '李四', age: 19, sex: '女'  ,work:'互联网'},
    { name: '王五', age: 20, sex: '男' ,work:'互联网' },
    { name: '赵六', age: 17, sex: '女'  ,work:'互联网'},
    { name: '老高', age: 28, sex: '男'  ,work:'互联网'},
  ]

  @State
  headerList: IHeaderItem[] = [
    {
      title: '姓名',
      name: 'name',
      index: 0
    },
    {
      title: '年龄',
      name: 'age',
      index: 1
    },
    {
      title: '性别',
      name: 'sex',
      index: 2
    },
    {
      title: '工作',
      name: 'work',
      index: 3
    }
  ]

  getHeaderItemByIndex (index: number) {
    return this.headerList.find(item => item.index === index)
  }

  @Builder
  getDragItemList (index: number) {
    Column() {
      Text(this.getHeaderItemByIndex(index)?.title || "")
        .backgroundColor(Color.Blue)
        .fontColor(Color.White)
        .height(50)
        .width(120)
        .textAlign(TextAlign.Center)

      List() {
        ForEach(this.list, (item: PeopleItem) => {
          ListItem() {
            Text((item as object)[this.getHeaderItemByIndex(index)?.name || ""].toString())
              .fontColor(Color.White)
              .width("100%")
              .textAlign(TextAlign.Center)
          }
          .height(50)
        })
      }
      .width(120)
    }
    .backgroundColor(Color.Gray)
  }

  // 交换listArr数组中listItem的位置
  changeListItemIndex(startIndex: number, toIndex: number) {
    let startTarget = new HeaderItem(this.headerList[startIndex]) ;
    startTarget.index = toIndex
    let toTarget =  new HeaderItem(this.headerList[toIndex])
    toTarget.index = startIndex

    this.headerList[startIndex] = startTarget as IHeaderItem;
    this.headerList[toIndex] = toTarget as IHeaderItem;
    this.headerList.sort((a, b) =>  a.index - b.index)
  }

  build() {
    Column() {
      List () {
        ForEach(this.headerList, (item: HeaderItem, index: number) => {
          ListItem() {
            Column() {
              Text(item.title)
                .fontColor(Color.White)
                .backgroundColor(Color.Blue)
                .width("100%")
                .height(50)
                .textAlign(TextAlign.Center)
              List() {
                ForEach(this.list, (valueItem: PeopleItem) => {
                  ListItem() {
                    Row() {
                      Text((valueItem as object)[item.name].toString())
                        .height(50)
                        .layoutWeight(1)
                        .textAlign(TextAlign.Center)
                    }
                  }
                })
              }
              .layoutWeight(1)
              .listDirection(Axis.Vertical)
            }
          }
          .width("33%")
          .border({
            color: Color.White,
            width: {
              right: index < this.headerList.length - 1 ? this.headerList.length : 0
            }
          })
        })
      }
      .width("100%")
      .listDirection(Axis.Horizontal)
      .onItemDragStart((event, index) => {
        return this.getDragItemList(index)
      })
      .onItemDrop((event: ItemDragInfo, itemIndex: number, insertIndex: number, isSuccess: boolean) => {
        if (!isSuccess || insertIndex >= this.headerList.length) {
          return;
        }
        this.changeListItemIndex(itemIndex, insertIndex);
      })
    }
    .height("100%")
    .width("100%")
    .padding({
      top: 100
    })
  }
}

interface  IHeaderItem {
  title: string
  name: string
  index: number
}

class HeaderItem {
  title: string = ""
  name: string = ""
  index: number = 0
  work:string = ""

  constructor(item: IHeaderItem) {
    this.title = item.title
    this.name = item.name
    this.index = item.index
  }
}

interface PeopleItem {
  name: string
  age: number
  sex: "男" | "女",
  work:'互联网'
}