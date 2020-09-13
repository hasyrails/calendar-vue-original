<template>
  <div>
    <div class="app-area">
      <div class="calendar-area">
        <GanttChart></GanttChart>
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

export default {
  name: 'Top',
  components: {
    Board,
    GanttChart
  }
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


.todo-area{
  width:200%;
  /* overflow-x: auto; */
  height: 30%;
  position: fixed;
	bottom: 0px;   
}
.calendar-area{
  width:125%;
  height:70%;
  overflow-x: scroll;
}

footer{
  position: fixed;
	bottom: 0px;             
}
</style>
