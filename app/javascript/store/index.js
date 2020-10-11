import Vue from 'vue'
import Vuex from 'vuex'

import lists from '../store/modules/lists'
import cards from '../store/modules/cards'
import schedules from '../store/modules/schedules'
import devidedschedules from '../store/modules/devidedschedules'
import date from '../store/modules/date'
import auth from '../store/modules/auth'

Vue.use(Vuex)


const store =  new Vuex.Store({
  modules: {
    lists,
    cards,
    schedules,
    // devidedschedules,
    date,
    auth,
  }
})

// store.subscribe((mutation, state) => {
//   localStorage.setItem('trello-lists', JSON.stringify(state.lists))
// })

export default store
