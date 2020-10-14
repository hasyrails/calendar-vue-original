<template>
  <div>
    <div class="app-area">
      <div class="calendar-area">
        <Calendar></Calendar>
      </div>
      <!-- <div class="footer-area">
        <footer>(C)footer</footer>
      </div> -->
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
  width: 100vw;
  height: 100vh;
  background: #EEFFFF;
  /* width: 150%; */
  /* display:flex;
  flex-direction: column;
  width: 100vw;
  align-items: center; */
  /* overflow-y: scroll; */
}

.calendar-area{
  width: 100vw;
  height: 100vh;
  /* overflow-x: scroll; */
  /* margin-top: 30%; */
  margin-left: 10%;
  margin-right : 10%;
}

footer{
  position: fixed;
	bottom: 0px;             
}
</style>
