<template>
  <div>
    <div class="app-area">
      <div class="calendar-area">
        <Calendar></Calendar>
      </div>
      <div class="footer-area">
        <footer>(C)footer</footer>
      </div>
    </div>
  </div>
</template>

<script>
import Board from '../components/Board'
import Calendar from '../components/Calendar'

export default {
  name: 'Top',
  components: {
    Board,
    Calendar
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

.app-area{
  width: 100%;
  display:flex;
  flex-direction: column;
  align-items: center;
  overflow-y: scroll;
}

.calendar-area{
  width:100%;
  height:70%;
  /* overflow-x: scroll; */
  margin-left: 10%;
  margin-right : 10%;
}

footer{
  position: fixed;
	bottom: 0px;             
}
</style>
