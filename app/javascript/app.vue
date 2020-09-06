<template>
  <div id="app">
    <div class="app-area">
      <div class="todo-area">
        <Board></Board>
      </div>
      <div class="calendar-area">
        <Calendar></Calendar>
      </div> 
    </div>
  </div>
</template>

<script>
import Calendar from "../javascript/components/Calendar";
// import ListAdd from "../javascript/components/ListAdd"
import Board from "../javascript/components/Board"

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  components: {
    Calendar,
    Board
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
  width:80%;
}
</style>
