<template>
  <div class="calendar-header">
    <div class="calendar-header-content">
      <ChevronLeft fillColor="white"  @click="prev" :size="100"></ChevronLeft>
      <div class="calendar-header-date">{{ currentDate }}</div>
      <ChevronRight fillColor="white" @click="next" :size="100"></ChevronRight>
      <div>
        <div>
          <Calendar @click="scroll" :size="80"></Calendar>
        </div>
        <div>
          日付へジャンプ
        </div>
      </div>
      <router-link to="/">
        <div>
          <Home :size="80"></Home>
        </div>
        <div>
          ホームへ戻る
        </div>
      </router-link>
    </div>
  </div>
</template>

<script>
// import 'vue-material-design-icons/styles.css';
import ChevronLeft from 'vue-material-design-icons/ChevronLeft.vue';
import ChevronRight from 'vue-material-design-icons/ChevronRight.vue';
import Home from 'vue-material-design-icons/Home.vue';
import Calendar from 'vue-material-design-icons/Calendar.vue';


export default {
  name: 'CalendarHeader',
  props:{
    currentDate: {
      type: String,
      required: true
    }
  },
  components:{
    ChevronLeft,
    ChevronRight,
    Home,
    Calendar
  },
  methods:{
    scroll(){
      let element = document.getElementById('2020-9-28');

      element.scrollIntoView({
        behavior: "smooth",
        // block: "値",
        inline: "center"
      });
    },
    prev(){
      this.$emit('prev')
    },
    next(){
      this.$emit('next')
    }
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
  /* justify-content: center; */
  align-items: center;
  position:fixed;
  
  bottom:1300px;
  margin-left:1%;
}
.calendar-header-date {
  color: white;
  font-size: 50px;
  margin-left: 5%;
  margin-right: 5%;
}
</style>
