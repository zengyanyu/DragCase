@Entry
@Component
struct BadgePage {

  build() {
    Column({space:10}) {
      Badge({
        count: 80,
        style: {
          fontSize:'25',
          fontWeight:FontWeight.Bold
        },
        position: BadgePosition.Left,
      }){
        Image($r("app.media.startIcon"))
          .width(100)
          .aspectRatio(1)
      }
    }
    .height('100%')
    .width('100%')
    .padding(20)
  }
}