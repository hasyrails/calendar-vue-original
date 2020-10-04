import moment from 'moment'
import axios from 'axios'

const schedules = {
  namespaced: true,
    state: {
    // schedules: savedSchedules ? JSON.parse(savedSchedules): [
      schedules: [
        {
          body: '',
          start: '',
          start_year: '',
          start_month: '',
          start_date: '',
          end: '',
          end_year: '',
          end_month: '',
          end_date: '',
        }
        // {
        //   title: 'Rails',
        //   start: moment('2020-09-07'),
        //   start_yyyymmdd: moment('2020-09-07').format('YYYY/MM/DD'),
        //   start_year: moment('2020-09-07').year(),
        //   start_month: moment('2020-09-07').month()+1,
        //   start_date: moment('2020-09-07').date(),
        //   end: moment('2020-09-010'),
        //   end_yyyymmdd: moment('2020-09-010').format('YYYY/MM/DD'),
        //   end_year: moment('2020-09-010').year(),
        //   end_month: moment('2020-09-010').month()+1,
        //   end_date: moment('2020-09-010').date(),
        //   color: '#FFD5EC',
        //   // icon: 0,
        //   commit: true
        // },
        // {
        //   title: 'ポートフォリオ',
        //   start: moment('2020-09-07'),
        //   start_yyyymmdd: moment('2020-09-07').format('YYYY/MM/DD'),
        //   start_year: moment('2020-09-07').year(),
        //   start_month: moment('2020-09-07').month()+1,
        //   start_date: moment('2020-09-07').date(),
        //   end: moment('2020-09-10'),
        //   end_yyyymmdd: moment('2020-09-010').format('YYYY/MM/DD'),
        //   end_year: moment('2020-09-010').year(),
        //   end_month: moment('2020-09-010').month()+1,
        //   end_date: moment('2020-09-010').date(),
        //   color: '#CBFFD3',
        //   // icon: 0,
        //   commit: true
        // },
        // {
        //   title: 'Docker制覇',
        //   start: moment('2020-09-07'),
        //   start_yyyymmdd: moment('2020-09-07').format('YYYY/MM/DD'),
        //   start_year: moment('2020-09-07').year(),
        //   start_month: moment('2020-09-07').month()+1,
        //   start_date: moment('2020-09-07').date(),
        //   end: moment('2020-09-10'),
        //   end_yyyymmdd: moment('2020-09-010').format('YYYY/MM/DD'),
        //   end_year: moment('2020-09-010').year(),
        //   end_month: moment('2020-09-010').month()+1,
        //   end_date: moment('2020-09-010').date(),
        //   color: '#CCFFFF',
        //   // icon: 0,
        //   commit: true　
        // },
      ],
    devidedSchedules:[
      {
        id: '',
        title: ''
      }
    ]
  },
  mutations: {
    setSchedules(state, {schedules}){
      state.schedules = schedules
    },
    // createDevidedSchedules(state){
    //   let i = 0;
    //   let j = 0;
    //   let k = 0;
    //   var dateArrays = [];
    //   var currentDates = [];
    //   var stopDates = [];
    //   while(dateArrays.length <= state.schedules.length-1){
    //     dateArrays.push([]);
    //   }
    //   while(i <= state.schedules.length-1){
    //     currentDates.push(moment(state.schedules[i].start));
    //     i = i + 1;
    //   }
    //   while(j <= state.schedules.length-1){
    //     stopDates.push(moment(state.schedules[j].end));
    //     j = j + 1;
    //   }
      
    //   while(k <= state.schedules.length -1){
    //     while (currentDates[k] <= stopDates[k]) {
    //       dateArrays[k].push( moment(currentDates[k]).format('YYYY-MM-DD') )
    //       currentDates[k] = moment(currentDates[k]).add(1, 'days');
    //     }
    //     k = k + 1; 
    //   }
    //   let m = 0;
    //   let n = 0;
    //   let idNum = 0;
    //   while(m <= dateArrays.length -1){
    //     while(n <= dateArrays[m].length -1){
    //       idNum = idNum + 1;
    //       state.devidedSchedules.push({
    //         id: idNum,
    //         scheduleNum: state.schedules[m].id,
    //         title: state.schedules[m].title,
    //         start: state.schedules[m].start,
    //         end: state.schedules[m].end,
    //         color: state.schedules[m].color,
    //         icon: state.schedules[m].icon,
    //         commit: state.schedules[m].commit,
    //         yyyymmdd: moment(dateArrays[m][n]).format('YYYY/MM/DD'),
    //         year: moment(dateArrays[m][n]).year(),
    //         month: moment(dateArrays[m][n]).month()+1,
    //         date: moment(dateArrays[m][n]).date(),
    //       });
    //       n = n + 1;
    //     }
    //     idNum = idNum +1;
    //     n = 0;
    //     m = m + 1;
    //   }
    // },
    updateSchedule(state, updateSchedule){
      const index = state.devidedSchedules.findIndex(devidedSchedule => {
        return devidedSchedule.id == updateSchedule.id
      })
      state.devidedSchedules.splice(index, 1, updateSchedule)
    },
    createSchedule(state, schedule){
      state.schedules.push(schedule)
    },
  },
  actions: {
    async fetchSchedulesAction({ commit }) {
      await axios.get('api/schedules')
          .then((response) => {
          commit('setSchedules', { schedules: response.data })
        })
    },
    createDevidedSchedulesAction(context){
        context.commit('createDevidedSchedules')
    },
    updateScheduleAction(context, devidedSchedule){
      context.commit('updateSchedule', devidedSchedule)
    },
    async createScheduleAction({ comiit }, card){
      const schedule = {
        body: card.body,
        start: card.start,
        start_year: new Date(card.start).getFullYear(),
        start_month: new Date(card.start).getMonth()+1,
        start_date: new Date(card.start).getDate(),
        end: card.end,
        end_year: new Date(card.end).getFullYear(),
        end_month: new Date(card.end).getMonth()+1,
        end_date: new Date(card.end).getDate(),
        card_id: card.id
      }
      await axios.post('api/schedules', schedule)
        .then(res => {
          commit('createSchedule', res.data)
        })
        .catch(error => console.log(error.response));
    }
  },
  getters: {
    schedules: (state) => state.schedules,
  },
}

export default schedules;
