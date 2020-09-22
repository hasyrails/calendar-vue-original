import moment from 'moment'

const schedules = {
  namespaced: true,
    state: {
    // schedules: savedSchedules ? JSON.parse(savedSchedules): [
      schedules: [
        {
          title: 'Rails',
          start_yyyymmdd: moment('2020-09-07'),
          start_date: moment('2020-09-07').date(),
          end_yyyymmdd: moment('2020-09-10'),
          end_date: moment('2020-09-010').date(),
          color: '#FFD5EC',
          // icon: 0,
          commit: true
        },
        {
          title: 'ポートフォリオ',
          start_yyyymmdd: moment('2020-09-07'),
          start_date: moment('2020-09-07').date(),
          end_yyyymmdd: moment('2020-09-10'),
          end_date: moment('2020-09-10').date(),
          color: '#CBFFD3',
          // icon: 0,
          commit: true
        },
        {
          title: 'Docker制覇',
          start_yyyymmdd: moment('2020-09-07'),
          start_date: moment('2020-09-07').date(),
          end_yyyymmdd: moment('2020-09-10'),
          end_date: moment('2020-09-10').date(),
          color: '#CCFFFF',
          // icon: 0,
          commit: true　
        },
    ],
  },
  mutations: {
  },
  actions: {
  },
  getters: {
  },
}

export default schedules;
