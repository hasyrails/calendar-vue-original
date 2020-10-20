import Vue from 'vue';
import VueRouter from 'vue-router';

import Top from '../pages/Top'
import GanttChartPage from '../pages/GanttChartPage'
import Register from '../pages/Register'
import Login from '../pages/Login'
import UserInfo from '../pages/UserInfo'

Vue.use(VueRouter); 

const routes = [
  { path: '/', component: Top },
  { path: '/schedules', component: GanttChartPage },
  { path: '/register', component: Register },
  { path: '/login', component: Login },
  { path: '/userinfo', component: UserInfo },
];

const router = new VueRouter({
  routes,
  mode: 'history'
});

export default router;
