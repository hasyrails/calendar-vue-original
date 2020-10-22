  <template>
  <div class="calendar-header">
    <div class="calendar-header-content">
      <ChevronLeft fillColor="white"  @click="prev" :size="100"></ChevronLeft>
      <div class="calendar-header-date">{{ currentDate }}</div>
      <ChevronRight fillColor="white" @click="next" :size="100"></ChevronRight>
      <div
      class="btn btn-warning btn-lg button-to-ganttchart-of-done"
      style="width:400px;"
      @click="showSchedules">
        <TableCheck size="50"></TableCheck>予定を表示する<TableCheck size="50"></TableCheck>
      </div>
      <div class="datepicker" style="margin-left:100px;" @mouseover="calendarIconBallonDisplay" @mouseleave="calendarIconBallonNonDisplay"
      @click="showDatePicker">
        <div>
          <Calendar :size="80" fillColor="white"></Calendar>
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
            <Home :size="80" fillColor="white"></Home>
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
import TableCheck from 'vue-material-design-icons/TableCheck.vue';
import Calendar from 'vue-material-design-icons/Calendar.vue';


export default {
  name: 'CalendarHeader',
  data(){
    return{
      calendarIconBallonFlag: false,
      homeIconBallonFlag: false,
      // datePickerFlag: false
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
    TableCheck,
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
    showSchedules(){
      this.$emit('showSchedules')
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
  
  top: 18%;
  margin-left:1%;
}
.calendar-header-date {
  color: white;
  font-size: 50px;
  margin-left: 5%;
  margin-right: 5%;
}

.datepicker {
  width: 400px;
  display: flex;
}

.home-link-icon {
  width: 400px;
  display: flex;
}


.link-description-ballon {
  position: relative;
  margin: 1.5em 0 1.5em 30px;
  padding: 15px 15px;
  /* min-width: 100px; */
  max-width: 400px;
  color: black;
  font-size: 16px;
  background: orange;
  border-radius:10px 10px 10px 10px;
}
.link-description-ballon::before{
  content: "";
  position: absolute;
  top: 50%;
  left: -30px;
  margin-top: -15px;
  border: 15px solid transparent;
  border-right: 15px solid orange;
}
.btn-warning {
    background: #FFCC00;
    border: 3px solid orange;    
    color: grey;
}
.btn-warning.outline {
    border: 3px solid orange;    
}
</style>
