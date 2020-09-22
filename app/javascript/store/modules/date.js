import moment from 'moment'

const date = {
  namespaced: true,
  state: {
    currentDate: moment().format('YYYY/MM'),
    currentMonth: moment().month()+1,
    currentYear: moment().year(),
    startDate : '',
    endDate : ''
  },
  mutations: {
    getStartDate(state, payload) {
      let date = moment(state.currentDate);
      const youbiNum = date.day();
      state.startDate =  date.subtract(youbiNum, "days");
      return state.startDate
    },
    getEndDate(state, payload){
      let date = moment(state.currentDate);
      date.endOf("month");
      const youbiNum = date.day();
      state.endDate = date.add(6 - youbiNum, "days");
      return state.endDate
    },
  },
  actions: {
    getStartDateAction(context, payload){
      context.commit('getStartDate')
    },
    getEndDateAction(context, paylo){
      context.commit('getEndDate')
    }
  },
  getters: {
  },
}
export default date;
