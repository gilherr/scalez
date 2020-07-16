import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '@/views/Home.vue'
import Tester from '@/views/Tester.vue'
import Funnel from '@/views/Funnel.vue';

Vue.use(VueRouter)

const routes = [
  { path: '/', name: 'Tester', component: Tester },
  { path: '/home', name: 'Home', component: Home },
  { path: '/funnel', name: 'Funnel', component: Funnel }

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to, from, next) => {
  const isUserCookieSet = Boolean(Vue.$cookies.get('userMeta'))
  
  if (to.name !== 'Tester' && !isUserCookieSet){
    next({ name: 'Tester' })
  }
  else {
    next()
  }
})

export default router
