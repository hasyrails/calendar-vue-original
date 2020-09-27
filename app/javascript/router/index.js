import Vue from 'vue';
import VueRouter from 'vue-router';

import Top from '../pages/Top'
import GanttChartPage from '../pages/GanttChartPage'
import Register from '../pages/Register'
import Login from '../pages/Login'

Vue.use(VueRouter); 

const routes = [
  { path: '/', component: Top },
  { path: '/schedules', component: GanttChartPage },
  { path: '/register', component: Register },
  { path: '/login', component: Login },
];

const router = new VueRouter({
  routes,
  mode: 'history'
});

export default router;
