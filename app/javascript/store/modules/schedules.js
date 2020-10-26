import moment from 'moment'
import axios from 'axios'

const schedules = {
  namespaced: true,
    state: {
    // schedules: savedSchedules ? JSON.parse(savedSchedules): [
      schedules: [
        {
          body: '',
          done: '',
          date: '',
          date_year: '',
          date_month: '',
          date_day: '',
          card_id: '',
          user_id: '',
          commit: '',
        }
      ],
      sampleSchedules: [],
  },
  mutations: {
    setSchedules(state, {schedules}){
      state.schedules = schedules
    },
    updateSchedule(state, payload){
      state.schedules = payload.schedules
    },
    createSchedule(state, payload){
      state.schedules.push(payload)
    },
    createSampleScheduleVerFirst(state, payload){
      state.sampleSchedules.push(payload)
    },
    createSampleScheduleVerSecond(state, payload){
      state.sampleSchedules.push(payload)
    },
    createSampleScheduleVerThird(state, payload){
      state.sampleSchedules.push(payload)
    },
    deleteSchedule(state, deleteSchedule){
      const index = state.schedules.findIndex(schedule => {
        return schedule.id === deleteSchedule.id
      })
        state.schedules.splice(index, 1, deleteSchedule)
    },
  },
  actions: {
    async fetchSchedulesAction({ commit }) {
      await axios.get('api/schedules')
          .then((response) => {
          commit('setSchedules', { schedules: response.data })
        })
    },
    async updateScheduleAction ({commit}, payload) {
      await axios.patch('api/schedules/'+payload.id, payload)
        .then(res => {
          commit('updateSchedule')
        })
        .catch(error => console.log(error.response));
    },
    async completeScheduleAction ({commit}, payload) {
      await axios.patch('api/schedules/'+payload.id+'/done', payload)
        .then(res => {
          commit('updateSchedule')
        })
        .catch(error => console.log(error.response));
    },
    async createScheduleAction({ commit }, card){
      const scheduleDate = {
        start: new Date(card.start),
        end: new Date(card.end),
      }      
      var currentDate = scheduleDate.start
      const startDate = scheduleDate.start
      var stopDate = scheduleDate.end
      
      for(let i =1;  i <=Math.floor((new Date(stopDate).getTime()-new Date(startDate).getTime())/86400000)+1; i++) {
        var schedule = {
          body: card.body,
          color: card.color,
          start: scheduleDate.start,
          end: scheduleDate.end,
          date: currentDate,
          date_year: new Date(currentDate).getFullYear(),
          date_month: new Date(currentDate).getMonth()+1,
          date_day: new Date(currentDate).getDate(),
          card_id: card.id,
          user_id: card.user_id
        }

        await axios.post('api/schedules', schedule)
          .then(res => {
            commit('createSchedule', res.data)
          })
          .catch(error => console.log(error.response));
        
        currentDate = new Date(currentDate).setDate(new Date(currentDate).getDate() + 1);
        schedule.date = currentDate
      }
      
      await axios.patch('api/cards/'+card.id, card)
          .then(res => {
            commit('cards/updateCard', res.data)
          })
          .catch(error => console.log(error.response));
    },
    createSampleSchedulesActionVerFirst({ commit }){
      const scheduleFirst = 
        {
          body: 'サンプルです',
          done: '',
          date: moment().format('YYYY/MM/DD'),
          date_year: moment().year(),
          date_month: moment().month()+1,
          date_day: moment().date(),
          start: moment().format('YYYY/MM/DD'),
          end: moment().format('YYYY/MM/DD'),
          card_id: 1,
          user_id: '',
          commit: '',
        }
        commit('createSampleScheduleVerFirst',scheduleFirst)
      },
      createSampleSchedulesActionVerSecond({ commit }){
        const scheduleFirst = 
        {
          body: '服買おう',
          done: '',
          date: moment().add(1, "days").format('YYYY/MM/DD'),
          date_year: moment().add(1, "days").year(),
          date_month: moment().add(1, "days").month()+1,
          date_day: moment().add(1, "days").date(),
          start: moment().add(1, "days").format('YYYY/MM/DD'),
          end: moment().add(3, "days").format('YYYY/MM/DD'),
          card_id: 2,
          user_id: '',
          commit: '',
        }
        const scheduleSecond =
        {
          body: '服買おう',
          done: '',
          date: moment().add(2, "days").format('YYYY/MM/DD'),
          date_year: moment().add(2, "days").year(),
          date_month: moment().add(2, "days").month()+1,
          date_day: moment().add(2, "days").date(),
          start: moment().add(1, "days").format('YYYY/MM/DD'),
          end: moment().add(3, "days").format('YYYY/MM/DD'),
          card_id: 2,
          user_id: '',
          commit: '',
        }
        const scheduleThird =
        {
          body: '服買おう',
          done: '',
          date: moment().add(3, "days").format('YYYY/MM/DD'),
          date_year: moment().add(3, "days").year(),
          date_month: moment().add(3, "days").month()+1,
          date_day: moment().add(3, "days").date(),
          start: moment().add(1, "days").format('YYYY/MM/DD'),
          end: moment().add(3, "days").format('YYYY/MM/DD'),
          card_id: 2,
          user_id: '',
          commit: '',
        }
        commit('createSampleScheduleVerSecond',scheduleFirst)
        commit('createSampleScheduleVerSecond',scheduleSecond)
        commit('createSampleScheduleVerSecond',scheduleThird)
    },
    createSampleSchedulesActionVerThird({ commit }){
      const scheduleFirst = 
        {
          body: '夕食の食材',
          done: '',
          date: moment().add(2, "days").format('YYYY/MM/DD'),
          date_year: moment().add(2, "days").year(),
          date_month: moment().add(2, "days").month()+1,
          date_day: moment().add(2, "days").date(),
          start: moment().add(2, "days").format('YYYY/MM/DD'),
          end: moment().add(3, "days").format('YYYY/MM/DD'),
          card_id: 3,
          user_id: '',
          commit: '',
        }
        const scheduleSecond =
        {
          body: '夕食の食材',
          done: '',
          date: moment().add(3, "days").format('YYYY/MM/DD'),
          date_year: moment().add(3, "days").year(),
          date_month: moment().add(3, "days").month()+1,
          date_day: moment().add(3, "days").date(),
          start: moment().add(2, "days").format('YYYY/MM/DD'),
          end: moment().add(3, "days").format('YYYY/MM/DD'),
          card_id: 3,
          user_id: '',
          commit: '',
        }
      commit('createSampleScheduleVerThird',scheduleFirst)
      commit('createSampleScheduleVerThird',scheduleSecond)
    },
    async deleteScheduleAction ({state, commit}, schedule) {
 
        return await axios.delete('/api/schedules/' + schedule.id)
            .then(res => {
                commit('deleteSchedule', index);
                return true;
            }).catch(error => {
                return error;
            });
    },
  },
  getters: {
    schedules: (state) => state.schedules,
    sampleSchedules: (state) => state.sampleSchedules,
  },
}

export default schedules;
