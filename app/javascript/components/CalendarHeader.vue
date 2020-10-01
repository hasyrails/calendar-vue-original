<template>
  <div class="calendar-header">
    <div class="calendar-header-content">
      <div>
        <ChevronLeft fillColor="white"  @click="prev" :size="100"></ChevronLeft>
      </div>
      <div class="calendar-header-date">{{ currentDate }}</div>
      <div>
        <ChevronRight fillColor="white" @click="next" :size="100"></ChevronRight>
      </div>
    </div>
    <router-link to="/schedules" style="text-decoration:none;">
      <div class="link-to-ganttchart-page"
      @mouseover="ballonDisplay" @mouseleave="ballonNonDisplay">
          <div>
            <Pencil :size="80"></Pencil>
          </div>
          <div class="link-description-ballon"
          v-if="ballonFlag">
            スケジュールを<br>立てましょう！
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
  font-size: 75px;
  margin-left: 10%;
  margin-right: 10%;
}
.link-to-ganttchart-page{
  text-align: right;
  margin-bottom: 15%;
  margin-left: 85%;
  display: flex;
}

.link-description-ballon {
  position: relative;
  margin: 1.5em 0 1.5em 30px;
  padding: 15px 15px;
  /* min-width: 100px; */
  max-width: 250px;
  color: #555;
  font-size: 16px;
  background: #e0edff;
  border-radius:10px 10px 10px 10px;
}
.link-description-ballon::before{
  content: "";
  position: absolute;
  top: 50%;
  left: -30px;
  margin-top: -15px;
  border: 15px solid transparent;
  border-right: 15px solid #e0edff;
}
</style>
