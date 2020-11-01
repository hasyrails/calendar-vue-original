<template>
  <div class="calendar-header">
    <div class="calendar-header-content">
      <ChevronLeft fillColor="white"  @click="prev" :size="50"></ChevronLeft>
      <div class="calendar-header-date">{{ currentDate }}</div>
      <ChevronRight fillColor="white" @click="next" :size="50"></ChevronRight>
      <div
      class="btn btn-primary btn-sm button-to-ganttchart-of-done"
      style="width:200px;"
      @click="showDone"
      v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0"
      >
        <Paw size="25"></Paw>完遂の軌跡 <Paw size="25"></Paw>
      </div>
      <div>
        <div style="color:blue; font-size:15px;font-weight:bold;margin-left:5px;">{{message}}</div>
        <div
        class="btn btn-primary btn-lg button-to-ganttchart-of-done purun"
        style="width:400px;"
        v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length===0"
        @click="loginInvitationMassage"
        >
          <Key size="50"></Key>完遂の軌跡 <Key size="50"></Key>
        </div>
      </div>
      <div class="datepicker" style="margin-left:100px;" @mouseover="calendarIconBallonDisplay" @mouseleave="calendarIconBallonNonDisplay"
      @click="showDatePicker">
        <div>
          <Calendar :size="40" fillColor="white"></Calendar>
        </div>
        <div class="link-description-ballon"
          v-if="calendarIconBallonFlag">
          選んだ日付へ<br>ジャンプ
        </div>
      </div>
    <router-link to="/" style="text-decoration:none;">
      <div class="home-link-icon"
      style="margin-left:10px;"
      @mouseover="homeIconBallonDisplay" @mouseleave="homeIconBallonNonDisplay">
          <div>
            <Home :size="40" fillColor="white"></Home>
          </div>
          <div class="link-description-ballon"
          v-if="homeIconBallonFlag">
            ホームへ戻る
          </div>
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
import Paw from 'vue-material-design-icons/Paw.vue';
import Key from 'vue-material-design-icons/Key.vue';
import Calendar from 'vue-material-design-icons/Calendar.vue';


export default {
  name: 'CalendarHeader',
  data(){
    return{
      calendarIconBallonFlag: false,
      homeIconBallonFlag: false,
      // datePickerFlag: false
      message: '',
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
    Home,
    Paw,
    Key,
    Calendar,
  },
  methods:{
    showDatePicker(){
      this.$emit('showDatePicker')
    },
    calendarIconBallonDisplay(){
      this.calendarIconBallonFlag = true
    },
    calendarIconBallonNonDisplay(){
      this.calendarIconBallonFlag = false
    },
    homeIconBallonDisplay(){
      this.homeIconBallonFlag = true
    },
    homeIconBallonNonDisplay(){
      this.homeIconBallonFlag = false
    },
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
    },
    showDone(){
      this.$emit('showDoneSchedules')
    },
    loginInvitationMassage(){
      this.message = 'ユーザー登録・ログインすると使えるようになります！'
      setTimeout(() => {
        this.message = ''
        }
      ,3000
      )
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
  align-items: center;
  position:fixed;
  top: 20%;
}
.calendar-header-date {
  color: white;
  font-size: 20px;
}

.datepicker {
  width: 200px;
  display: flex;
}

.home-link-icon {
  width: 400px;
  display: flex;
}


.link-description-ballon {
  position: relative;
  padding: 15px 15px;
  /* min-width: 100px; */
  max-width: 400px;
  color: #555;
  font-size: 10px;
  background: #e0edff;
  border-radius:10px 10px 10px 10px;
  cursor: pointer;
}
/* .link-description-ballon::before{
  content: "";
  position: absolute;
  top: 50%;
  left: -30px;
  margin-top: -15px;
  border: 15px solid transparent;
  border-right: 15px solid #e0edff;
} */

.btn-primary {
  margin-left: 5%;
  background: cyan;
  color: grey;
}
.btn-primary.outline {
    border: 3px solid blue;    
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
