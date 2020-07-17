import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store'

import Home from '@/views/Home.vue'
import Tester from '@/views/Tester.vue'
import Funnel from '@/views/Funnel.vue';
import Summary from '@/views/Summary.vue';


Vue.use(VueRouter)

const routes = [
  { path: '/', name: 'Tester', component: Tester },
  { path: '/home', name: 'Home', component: Home },
  { path: '/funnel', name: 'Funnel', component: Funnel },
  { path: '/funnel/summary', name: 'Summary', component: Summary }

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to, from, next) => {
  const userCookie = Vue.$cookies.get('userMeta')

  if(userCookie) {
    store.dispatch('user/setAllUserData', userCookie)
  }

  const goingToTesterOrHome = to.name === 'Tester' || to.name === 'Home';
  
  if (!goingToTesterOrHome && !userCookie){
    next({ name: 'Tester' })
  }
  else {
    next()
  }
})

export default router
