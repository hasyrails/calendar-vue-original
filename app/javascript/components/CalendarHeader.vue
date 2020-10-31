<template>
  <div class="calendar-header">
    <div class="calendar-header-content">
      <div class="prev-month-button">
        <ChevronLeft fillColor="white"  @click="prev" :size="40"></ChevronLeft>
      </div>
      <div class="calendar-header-date">{{ currentDate }}</div>
      <div class="next-month-button">
        <ChevronRight fillColor="white" @click="next" :size="40"></ChevronRight>
      </div>
    </div>
    <router-link to="/schedules" style="text-decoration:none;">
      <div class="linkicon-to-ganttchart-page"
      @mouseover="ballonDisplay" @mouseleave="ballonNonDisplay">
          <div class="purun">
            <Pencil :size="40"></Pencil>
          </div>
          <div class="link-description-ballon"
          v-if="ballonFlag">
            スケジュールを立てましょう！
          </div>
      </div>
    </router-link>
  </div>
</template>

<script>
// import 'vue-material-design-icons/styles.css';
import ChevronLeft from 'vue-material-design-icons/ChevronLeft.vue';
import ChevronRight from 'vue-material-design-icons/ChevronRight.vue';
import Pencil from 'vue-material-design-icons/Pencil.vue';


export default {
  name: 'CalendarHeader',
  data(){
    return{
      ballonFlag: false,
    }
  },
  props:{
    currentDate: {
      type: String,
      required: true
    }
  },
  components:{
    ChevronLeft,
    ChevronRight,
    Pencil
  },
  methods:{
    prev(){
      this.$emit('prev')
    },
    next(){
      this.$emit('next')
    },
    ballonDisplay(){
      this.ballonFlag = true
    },
    ballonNonDisplay(){
      this.ballonFlag = false
    },
  }
}
</script>

<style scoped>
.calender-header {
  /* background-color: #75A9FF; */
  /* height:1px; */
  /* display: flex; */
  /* justify-content: space-between; */
  width:50%;
}
.calendar-header-content {
  display: flex;
  justify-content: center;
  align-items:space-between;
  /* position:fixed; */
  bottom:1200px;
  margin-left:1%;
}
.calendar-header-date {
  color: white;
  font-size: 30px;
  margin-left: 10%;
  margin-right: 10%;
}
.linkicon-to-ganttchart-page{
  margin-left: 75%;
  display: flex;
}

.link-description-ballon {
  margin-bottom:15px;
  max-width: 250px;
  color: #555;
  font-size: 15px;
  background: #e0edff;
  border-radius:10px 10px 10px 10px;
}
.link-description-ballon::before{
  content: "";
  position: absolute;
  left: -30px;
  border: 15px solid transparent;
  border-right: 15px solid #e0edff;
}
.purun {
  animation: purun 0.8s linear 0s 1;
}

@keyframes purun {
  0%   { transform: scale(1.0, 1.0) translate(0%, 0%); }
  15%  { transform: scale(0.9, 0.9) translate(0%, 5%); }
  30%  { transform: scale(1.3, 0.8) translate(0%, 10%); }
  50%  { transform: scale(0.8, 1.3) translate(0%, -10%); }
  70%  { transform: scale(1.1, 0.9) translate(0%, 5%); }
  100% { transform: scale(1.0, 1.0) translate(0%, 0%); }
}
</style>
