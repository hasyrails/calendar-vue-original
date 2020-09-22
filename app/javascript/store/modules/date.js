import moment from 'moment'

const date = {
  namespaced: true,
  state: {
    currentDate: moment().format('YYYY/MM'),
    currentMonth: moment().month()+1,
    currentYear: moment().year(),
  },
  mutations: {
  },
  actions: {
  },
  getters: {
  },
}

export default date;
