import Vue from 'vue'
import Vuex from 'vuex'

import lists from '../store/modules/lists'
import cards from '../store/modules/cards'
import schedules from '../store/modules/schedules'
import devidedschedules from '../store/modules/devidedschedules'
import date from '../store/modules/date'
import auth from '../store/modules/auth'
import messages from '../store/modules/messages'

import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex)


const store =  new Vuex.Store({
  state: {
    showDone: false,
    srcFlag :true,
    alternativeUserIconFlag :true
  },
  mutations: {
    showDones(state){
      state.showDone = true
    },
    showSchedules(state){
      state.showDone = false
    },
    showSrc(state){
      state.srcFlag = true
    },
    hideSrc(state){
      state.srcFlag = false
    },
    hideAlternativeUserIcon(state){
      state.alternativeUserIconFlag = false
    },
  },
  actions:{
    showDonesAction({commit}){
      commit('showDones')
    },
    showSchedulesAction({commit}){
      commit('showSchedules')
    },
    showSrcAction({commit}){
      commit('showSrc')
    },
    hideSrcAction({commit}){
      commit('hideSrc')
    },
    hideAlternativeUserIconAction({commit}){
      commit('hideAlternativeUserIcon')
    },
  },
  getters:{
    alternativeUserIconFlag: (state) => state.alternativeUserIconFlag
  },
  modules: {
    lists,
    cards,
    schedules,
    // devidedschedules,
    date,
    auth,
    messages,
  },
  strict: true,
  plugins: [createPersistedState({
      key: 'ShoshiSikaKatan',
      paths: ['auth'],
      storage: window.sessionStorage
  })]
})

// store.subscribe((mutation, state) => {
//   localStorage.setItem('trello-lists', JSON.stringify(state.lists))
// })

export default store
