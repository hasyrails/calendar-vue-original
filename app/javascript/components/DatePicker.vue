<template>
  <div id="overlay">
    <div id="content">
      <div>
      <Close class="btn btn-danger" fillColor="white" :size="30" @click="closeDatePicker">
      </Close>
      </div>
  <div class="calendar">
    <div class="calendar-header-area">
      <DatePickerCalendarHeader
      :currentDate="currentDate"
      @prev="prevMonth"
      @next="nextMonth"
      style="background-color:#8EB8FF;height:50px;width:90%;">
      </DatePickerCalendarHeader>
    </div>
    <div style="width:90%;border-top:5px #BAD3FF;background-color:#EEEEEE;">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        style="display:flex;border-left:5px solid #BAD3FF;height:60px;"
      >
        <div
        class="calendar-date"
        v-for="(day, index) in week"
        :key="index"
        :id="'datepicker-'+day.year+'-'+day.month+'-'+day.date"
        style="width:60px;"
        @click="scroll"
        >
          <div v-if="day.month===currentMonth" style="font-weight:200;font-size:30px;">{{day.date}}</div>
          <div v-if="day.month!==currentMonth" style="color:#D3D3D3;font-size:30px;">{{ day.date }}</div>
        </div>
      </div>
    </div>
    </div>
  </div>
  </div>
</template>

<script>
import moment from "moment";
import DatePickerCalendarHeader from "../components/DatePickerCalendarHeader";
import Close from 'vue-material-design-icons/Close.vue';




export default {
  name: 'DatePicker',
  data() {
    return {
      currentDate: moment().format('YYYY/MM'),
      currentMonth: moment().month()+1,
    };
  },
  components: {
    DatePickerCalendarHeader,
    Close
  },
  methods: {
    closeDatePicker(){
      this.$emit('closeDatePicker')
    },
    scroll(){
      let scrollTarget = document.getElementById(event.currentTarget.id.substr(11));
      
      scrollTarget.scrollIntoView({
        behavior: "smooth",
        // block: "値",
        inline: "center"
      });
    },
    getStartDate() {
      let date = moment(this.currentDate);
      const youbiNum = date.day();
      return date.subtract(youbiNum, "days");
    },
    getEndDate() {
      let date = moment(this.currentDate);
      date.endOf("month");
      const youbiNum = date.day();
      return date.add(6 - youbiNum, "days");
    },
    getCalendar() {
      let startDate = this.getStartDate();
      const endDate = this.getEndDate();
      const weekNumber = Math.ceil(endDate.diff(startDate, "days") / 7);

      let calendars = [];

      for (let week = 0; week < weekNumber; week++) {
        let weekRow = [];
        for (let day = 0; day < 7; day++) {
        
          weekRow.push({
            year: startDate.get("year"),
            month: startDate.get("month")+1,
            date: startDate.get("date"),
          });
          startDate.add(1, "days");
        }
          calendars.push(weekRow);
      }

      return calendars;
      console.log(calendars);

    },
    nextMonth() {
      this.currentDate = moment(this.currentDate).add(1, "month").format('YYYY/MM');
      if(this.currentMonth <11){
        this.currentMonth++;
      }else if(this.currentMonth===11){
        this.currentMonth = 12
      }else{
        this.currentMonthReset()
      }
    },
    currentMonthReset(){
      this.currentMonth = 1
    },
    prevMonth() {
      this.currentDate = moment(this.currentDate).subtract(1, "month").format('YYYY/MM');
      
      if(this.currentMonth <=12 && this.currentMonth > 1){
        this.currentMonth--;
      }else if(this.currentMonth===1){
        this.currentMonth = 12
      }
      this.getCalendar();
    },
  },
  computed: {
    calendars() {
      return this.getCalendar();
    },
  },
}
</script>

<style scoped>
#overlay{
  /*　要素を重ねた時の順番　*/
  z-index:100;

  /*　画面全体を覆う設定　*/
  position:relative;
  top:-100px;
  left:100px;
  width:500px;
  height:500px;
  background-color:rgba(219,231,255,0.3);

  /*　画面の中央に要素を表示させる設定　*/
  display: flex;
  align-items: center;
  justify-content: center;
}

.calendar {
  /* margin-top:5%; */
  margin-left: 15%;
  /* margin-right: 15%; */
  /* margin-right: 10%; */
  /* position: fixed; */
  width:80%;
  z-index:101;
}

.calendar-header-area {
  /* height:200px; */
}

.calendar-date{
  flex:1;
  /* min-height:150px; */
  border-right:5px solid #BAD3FF;
  border-bottom:5px solid #BAD3FF;
  text-align: center;
  font-size:25px;
}

.calendar-date:hover {
  background-color: silver;
  border-radius: 4px;
}

</style>
