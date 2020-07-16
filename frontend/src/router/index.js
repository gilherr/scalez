import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Tester from '../views/Tester.vue'

Vue.use(VueRouter)

  const routes = [
    {path: '/',name: 'Tester',component: Tester},
    {path: '/home',name: 'Home',component: Home}

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
