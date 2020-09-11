import Vue from 'vue';
import VueRouter from 'vue-router';

import Top from '../pages/Top'
import Register from '../pages/Register'

Vue.use(VueRouter); 

const routes = [
  { path: '/', component: Top },
  { path: '/register', component: Register },
];

const router = new VueRouter({
  routes,
  mode: 'history'
});

export default router;