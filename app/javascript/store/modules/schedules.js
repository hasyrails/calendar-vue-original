import moment from 'moment'
import axios from 'axios'

const schedules = {
  namespaced: true,
    state: {
    // schedules: savedSchedules ? JSON.parse(savedSchedules): [
      schedules: [
        {
          body: '',
          color: '',
          commit: '',
          start: '',
          start_year: '',
          start_month: '',
          start_date: '',
          end: '',
          end_year: '',
          end_month: '',
          end_date: '',
        }
      ],
  },
  mutations: {
    setSchedules(state, {schedules}){
      state.schedules = schedules
    },
    updateSchedule(state, {schedule,updateSchedule}){
      // const index = state.cards.findIndex(card => {
      //   return card.id === updateCard.id
      // })
      //   state.cards.splice(index, 1, updateCard)
      Object.assign(schedule, updateSchedule);
    },
    createSchedule(state, schedule){
      state.schedules.push(schedule)
    },
    deleteSchedule(state, deleteSchedule){
      const index = state.schedules.findIndex(schedule => {
        return schedule.id === deleteSchedule.id
      })
        state.schedules.splice(index, 1, deleteSchedule)

      state.schedules.splice(index, 1);
    },
  },
  actions: {
    async fetchSchedulesAction({ commit }) {
      await axios.get('api/schedules')
          .then((response) => {
          commit('setSchedules', { schedules: response.data })
        })
    },
    async updateScheduleAction ({state, commit}, updateSchedule) {
      // stateからマッチしたtaskを取り出す
      const schedule = state.schedules.find((o) => {
          return o.id === updateSchedule.id;
      });

      if (!schedule) {
          return false;
      }

      return await axios.patch('/api/schedules/' + updateSchedule.id, updateSchedule)
          .then(res => {
              commit('updateSchedule', {schedule, updateSchedule});
              return true;
          }).catch(error => {
              return error;
          });
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
