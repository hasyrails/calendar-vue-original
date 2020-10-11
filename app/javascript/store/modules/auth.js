import axios from 'axios'


const auth = {
  namespaced: true,
  state: {
    user: [],
    auth: {}
  },
  getters: {
    user: state => state.user,
    auth: state => state.auth
  },
  mutations: {
    user (state, value) {
      state.user = value
    },
    auth (state, value) {
      state.auth = value
    }
  },
  actions:{
  },
  getters: {
  },
}

export default auth;
