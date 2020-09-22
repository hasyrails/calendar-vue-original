import moment from 'moment'

const savedSchedules = localStorage.getItem('schedules')

const schedules = {
  namespaced: true,
    state: {
    // schedules: savedSchedules ? JSON.parse(savedSchedules): [
      schedules: [
        {
          title: 'Rails',
          start: moment('2020-09-07'),
          end: moment('2020-09-010').format('YYYY-MM-DD'),
          color: '#FFD5EC',
          // icon: 0,
          commit: true
        },
        {
          title: 'ポートフォリオ',
          start: moment('2020-09-07').format('YYYY-MM-DD'),
          end: moment('2020-09-10').format('YYYY-MM-DD'),
          color: '#CBFFD3',
          // icon: 0,
          commit: true
        },
        {
          title: 'Docker制覇',
          start: moment('2020-09-07').format('YYYY-MM-DD'),
          end: moment('2020-09-10').format('YYYY-MM-DD'),
          color: '#CCFFFF',
          // icon: 0,
          commit: true
        },
    ],
    devidedSchedules: [],
  },
  mutations: {
    createDevidedSchedules(state, devidedSchedule){
      let i = 0;
      let j = 0;
      let k = 0;
      var dateArrays = [];
      var currentDates = [];
      var stopDates = [];
      while(dateArrays.length <= state.schedules.length-1){
        dateArrays.push([]);
      }
      while(i <= state.schedules.length-1){
        currentDates.push(moment(state.schedules[i].start));
        i = i + 1;
      }
      while(j <= state.schedules.length-1){
        stopDates.push(moment(state.schedules[j].end));
        j = j + 1;
      }
      
      while(k <= state.schedules.length -1){
        while (currentDates[k] <= stopDates[k]) {
          dateArrays[k].push( moment(currentDates[k]).format('YYYY-MM-DD') )
          currentDates[k] = moment(currentDates[k]).add(1, 'days');
        }
        k = k + 1; 
      }
      
      let m = 0;
      let n = 0;
      let idNum = 0;
      while(m <= dateArrays.length -1){
        while(n <= dateArrays[m].length -1){
          idNum = idNum + 1;
          devidedSchedules.push({
            id: idNum,
            title: state.schedules[m].title,
            color: state.schedules[m].color,
            icon: state.schedules[m].icon,
            commit: state.schedules[m].commit,
            yyyymm: moment(dateArrays[m][n]).format('YYYY/MM'),
            year: moment(dateArrays[m][n]).year(),
            month: moment(dateArrays[m][n]).month()+1,
            date: moment(dateArrays[m][n]).date(),
          });
          n = n + 1;
        }
        idNum = idNum +1;
        n = 0;
        m = m + 1;
      }
      state.devidedSchedules =  devidedSchedules;
    },
  },
  actions: {
    createDevidedSchedulesAction({ commit }) {
      // commit('createDevidedSchedules', { devideSchedules: state.devidedSchedules })
      commit('createDevidedSchedules')
    },
  },
  getters: {
  },
}

export default schedules;
