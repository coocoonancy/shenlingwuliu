import router from '@ohos.router'
import { AdModel } from '../../models'
import { UserSettingClass } from '../../utils'
@Entry
@Component
struct Start {
  userSetting: UserSettingClass = new UserSettingClass(getContext(this))
  @State
  adModel: AdModel = {
    show: false,
    duration: 5,
    img: ''
  }
  timer: number = -1
  async getUserAd() {
    this.adModel = await this.userSetting.getAd()
    this.timer = setInterval(() => {
      if (this.adModel.duration === 0) {
        clearInterval(this.timer)
        router.replaceUrl({ url: 'pages/Index'})
      } else {
        this.adModel.duration--
      }
    }, 1000)
  }
  aboutToAppear() {
    this.getUserAd();
  }
  aboutToDisappear() {
    clearInterval(this.timer)
  }
  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image(this.adModel.img).objectFit(ImageFit.Cover)
      Text(`${this.adModel.duration}秒后跳过`)
        .padding({ left: 10, right: 10 })
        .margin({ right: 20, top: 20 })
        .height(30)
        .fontSize(14)
        .borderRadius(15)
        .backgroundColor($r('app.color.background_page'))
        .textAlign(TextAlign.Center)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/Index'})
        })
    }
    .width('100%')
    .height('100%')
  }
}