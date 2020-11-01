<template>
  <div>
    <div class="app-area">
      <div class="calendar-area" id="calendar-area">
        <GanttChart v-if="!showDone"
        @showDatePicker="showDatePicker"
        @showDoneSchedules="showDoneSchedules"
        ></GanttChart>
        <GanttChartOfDone v-if="showDone"
        @showDatePicker="showDatePicker"
        @showSchedules="showSchedules"
        ></GanttChartOfDone>
      </div>
      <div class="date-picker">
        <DatePicker
         v-if="datePickerFlag" @closeDatePicker="closeDatePicker"></DatePicker>
      </div>
      <div class="todo-area">
        <Board v-if="!showDone"></Board>
        <BoardOfDone v-if="showDone"></BoardOfDone>
      </div>
      <div class="footer-area">
        <footer>(C)footer</footer>
      </div>
    </div>
  </div>
</template>

<script>
import Board from '../components/Board'
import BoardOfDone from '../components/BoardOfDone'
import GanttChart from '../components/GanttChart'
import GanttChartOfDone from '../components/GanttChartOfDone'
import DatePicker from '../components/DatePicker'

import {mapState} from 'vuex'

export default {
  name: 'Top',
  data(){
    return{
      datePickerFlag: false,
      scheduleSettingModalFlag: false,
      // showDone: false,
    }
  },
  components: {
    Board,
    BoardOfDone,
    GanttChart,
    GanttChartOfDone,
    DatePicker,
  },
  computed:{
    ...mapState([
      'showDone'
    ]),
  },
  methods: {
    showDatePicker(){
      this.datePickerFlag = true
    },
    closeDatePicker(){
      this.datePickerFlag = false
    },
    showDoneSchedules(){
      // this.showDone = true
      this.$store.dispatch('showDonesAction')
    },
    showSchedules(){
      // this.showDone = false
      this.$store.dispatch('showSchedulesAction')
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

.app-area{
  width: 250vw;
  height: 100vh;
  /* background: #EEFFFF; */
  display:flex;
  flex-direction: column;
  align-items: center;
}

.calendar-area{
  width: 250vw;
  height:70%;
  /* overflow-x: scroll; */
}

.date-picker{
  width: 30%;
  height: 30%;
  /* position: relative; */
  /* position: absolute; */
  position: fixed;
  top: 30%;
  bottom: 30%;
  left: 10%;
  z-index:150;
}

.todo-area{
  width: 250vw;
  /* overflow-x: auto; */
  overflow-x: scroll;
  height: 30%;
  position: fixed;
	bottom: 0px;
}

footer{
  position: fixed;
	bottom: 0px;             
}
</style>
