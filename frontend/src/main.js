import Vue from 'vue'
import App from './App.vue'
import store from './store'
import router from './router'
import VueCookies from 'vue-cookies'

Vue.config.productionTip = false
Vue.use(VueCookies)

new Vue({
  render: h => h(App),
  router,
  store
}).$mount('#app')
