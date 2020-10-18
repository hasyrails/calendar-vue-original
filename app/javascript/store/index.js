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
      paths: ['auth.headers'],
      storage: window.sessionStorage
  })]
})

// store.subscribe((mutation, state) => {
//   localStorage.setItem('trello-lists', JSON.stringify(state.lists))
// })

export default store
