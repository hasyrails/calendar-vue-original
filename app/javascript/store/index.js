import Vue from 'vue'
import Vuex from 'vuex'

import lists from '../store/modules/lists'
import schedules from '../store/modules/schedules'
// import calendar from '../store/modules/calendar'
import ganttchart from '../store/modules/ganttchart'
import date from '../store/modules/date'

Vue.use(Vuex)


const store =  new Vuex.Store({
  modules: {
    lists,
    schedules,
    // calendar
    ganttchart,
    date
  }
})

// store.subscribe((mutation, state) => {
//   localStorage.setItem('trello-lists', JSON.stringify(state.lists))
// })

export default store
