import preferences from '@ohos.data.preferences'
import { AdModel } from '../models'
import { USER_SETTING, USER_AD_SETTING } from '../constants'
const defaultAd: AdModel = {
  show: true,
  duration: 5,
  img: $r('app.media.start')
}
export class UserSettingClass {
  context: Context
  constructor(context: Context) {
    this.context = context
  }
  // 获取用户配置
   getStore() {
    return preferences.getPreferences(this.context, USER_SETTING)
  }
  // 设置用户首选项
  async setSAd(ad: AdModel) {
    const store = await this.getStore()
    await store.put(USER_AD_SETTING, JSON.stringify(ad))
    await store.flush()
  }
  // 获取广告配置
  async getAd(): Promise<AdModel> {
    const store = await this.getStore()
    const adString = await store.get(USER_AD_SETTING, JSON.stringify(defaultAd) as string)
    return JSON.parse(adString as string) as AdModel
  }
}