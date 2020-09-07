<template>
  <div>
    <header>Header</header>
    <div class="app-area">
      <div class="todo-area">
        <Board></Board>
      </div>
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
  display:flex;
}

.todo-area{
  width:20%;
}
.calendar-area{
  width:75%;
}

footer{
  position: fixed;
	bottom: 0px;             
}
</style>
