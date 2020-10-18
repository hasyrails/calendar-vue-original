import moment from 'moment'
import axios from 'axios'

const schedules = {
  namespaced: true,
    state: {
    // schedules: savedSchedules ? JSON.parse(savedSchedules): [
      schedules: [
        {
          body: '',
          date: '',
          date_year: '',
          date_month: '',
          date_day: '',
          card_id: '',
          commit: '',
        }
      ],
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
    deleteSchedule(state, deleteSchedule){
      const index = state.schedules.findIndex(schedule => {
        return schedule.id === deleteSchedule.id
      })
        state.schedules.splice(index, 1, deleteSchedule)

      // state.schedules.splice(index, 1);
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
          start: scheduleDate.start,
          end: scheduleDate.end,
          date: currentDate,
          date_year: new Date(currentDate).getFullYear(),
          date_month: new Date(currentDate).getMonth()+1,
          date_day: new Date(currentDate).getDate(),
          card_id: card.id
        }

        await axios.post('api/schedules', schedule)
          .then(res => {
            commit('createSchedule', res.data)
          })
          .catch(error => console.log(error.response));
        
        currentDate = new Date(currentDate).setDate(new Date(currentDate).getDate() + 1);
        schedule.date = currentDate
      }

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
  },
}

export default schedules;
