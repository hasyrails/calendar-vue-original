<template>
  <div class="app-area">
    <transition name="component-fade">
      <UserLoginMessage></UserLoginMessage>
    </transition>
    <div class="calendar-area">
      <Calendar></Calendar>
    </div>
    <!-- <div class="footer-area">
      <footer>(C)footer</footer>
    </div> -->
  </div>
</template>

<script>
import Board from '../components/Board'
import Calendar from '../components/Calendar'

import UserLoginMessage from '../components/UserLoginMessage'

export default {
  name: 'Top',
  components: {
    Board,
    Calendar,
    UserLoginMessage,
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
  height: 100%;
  /* background: #EEFFFF; */
}

.calendar-area{
  width: 100%;
  height: 100%;
  /* overflow-x: scroll; */
  /* margin-top: 30%; */
  margin-left: 10%;
  margin-right : 10%;
}

footer{
  position: fixed;
	bottom: 0px;             
}

.component-fade-enter-active,
.component-fade-leave-active {
  transition: opacity 3s ease;
}
.component-fade-enter,
.component-fade-leave-to {
    opacity: 0;
}
</style>
