<template>
  <div>
    <div class="app-area">
      <div class="calendar-area">
        <GanttChart  @showDatePicker="showDatePicker"
        ></GanttChart>
      </div>
      <div class="date-picker">
        <DatePicker
         v-if="datePickerFlag" @closeDatePicker="closeDatePicker"></DatePicker>
        <!-- <DatePicker></DatePicker> -->
      </div>
      <div class="todo-area">
        <Board></Board>
      </div>
      <div class="footer-area">
        <footer>(C)footer</footer>
      </div>
    </div>
  </div>
</template>

<script>
import Board from '../components/Board'
import GanttChart from '../components/GanttChart'
import DatePicker from '../components/DatePicker'

export default {
  name: 'Top',
  data(){
    return{
      datePickerFlag: false
    }
  },
  components: {
    Board,
    GanttChart,
    DatePicker
  },
  methods: {
    showDatePicker(){
      this.datePickerFlag = true
    },
    closeDatePicker(){
      this.datePickerFlag = false
    }
  }
  // scrollTry(){
  //     var target = document.getElementById('calendar-area');
	//     target.scrollLeft += 50;
  // },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

.app-area{
  width: 125%;
  display:flex;
  flex-direction: column;
  align-items: center;
}

.calendar-area{
  width:125%;
  height:70%;
  overflow-x: scroll;
}

.date-picker{
  width: 100%;
  height: 100%;
  position: fixed;
  top: 30%;
  bottom: 30%;
  left: 10%;
}

.todo-area{
  width:200%;
  /* overflow-x: auto; */
  height: 30%;
  position: fixed;
	bottom: 0px;
}

footer{
  position: fixed;
	bottom: 0px;             
}
</style>
