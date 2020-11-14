/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import router from '../router'
import store from '../store'
import App from '../app.vue'
import VueCookies from 'vue-cookies'
import axios from 'axios'
import { pick } from 'lodash'
import status from 'http-status'
import { extend } from 'vee-validate';
import { required, email, confirmed } from 'vee-validate/dist/rules';

// Add the required rule
extend('required', {
  ...required,
  message: '入力必須の項目です'
});

// Add the email rule
extend('email', {
  ...email,
  message: '正しいメールアドレスの形式で入力してください'
});

extend('confirmed', {
  ...confirmed,
  message: '入力内容が一致していません'
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    store,
    router,
    // Vuetify,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})

// Put your instance of Axios in `Vue.prototype` which gives you easy global access to it.
// You can pass in configuration that is shared application-wide.
Vue.prototype.$http = axios.create()
// This first fat arrow function defines a callback invoked after any SUCCESSFUL request.
// This is where we check if the backend included an `access-token` header.
Vue.prototype.$http.interceptors.response.use((response) => {
  if (response.headers['access-token']) {
    // Commits the relevant headers to the store, calling mutation `auth`.
    const authHeaders = pick(r.headers, ["access-token","client","expiry","uid","token-type"])
    store.commit('auth', authHeaders)

    var session = vueCookie.get('session')

    // Stores the tokens in a cookie called `session` too. Cookie values are strings, so have to
    // serialize it to JSON.
    //
    // The object we are storing in session looks like this:
    // {'tokens': {'access-token': 'foo', ...}, 'user': {'email': 'foo@bar.com', ...}}
    // so that is why we are extracting and modifying, so that the `user` key isn't blown away.
    if (session) {
      var session = JSON.parse(session)
      session['tokens'] = authHeaders

      vueCookie.set('session', JSON.stringify(session), { expires: '14D' })
    }
  }

  return response
}, (error) => {
  // This second fat arrow function defines a callback invoked after any FAILED request.
  // This handles every case when the server responds with a 403 / unauthorized. That means
  // we need to redirect the user to the SignIn component.
  if (router.currentRoute.name !== 'signin' && error.response.status === status.UNAUTHORIZED) {
    store.commit('user', null)
    router.push({ name: 'signin' })
  }

  return Promise.reject(error)
})

this.$http.post('api/v1/auth/sign_in', { email: this.email, password: this.password})
  .then((response) => {
  // Again commits the relevant headers to the store.
  const authHeaders = pick(response.headers,
                           ["access-token","client","expiry","uid","token-type"])
  this.$store.commit('auth', authHeaders)

  // response.data.data is an object containing public information about the current user.
  // This is useful to keep track of so that your app can display the current user's
  // email/username somewhere.
  this.$store.commit('user', response.data.data)

  // Write both the response headers and the current user data to the cookie.
  const contents = {
    tokens: authHeaders,
    user: response.data.data
  }

  this.$cookie.set('session',
                   JSON.stringify(contents),
                   { expires: '14D' })

  // Go home or wherever the user originally wanted to go
  this.$router.push({ name: 'home' })
})

Vue.prototype.$http.interceptors.request.use((config) => {
  const headers = store.getters['auth']

  // object that holds configuration of the request that's about to be made
  config.headers = headers
  return config
})

if (sessionStorage.getItem('ShoshiSikaKatan')) {
  const strageData = JSON.parse(sessionStorage.getItem('ShoshiSikaKatan'));
  if (strageData.auth.token) {
      axios.defaults.headers.common['Authorization'] = 'Bearer ' + strageData.auth.token;
  }
}

Vue.use(BootstrapVue);
Vue.use(VueCookies);

import 'bootstrap/dist/css/bootstrap.css' 
import 'bootstrap-vue/dist/bootstrap-vue.css' 
