<template>
  <div class="calendar">
    <div class="calendar-header-area">
      <CalendarHeader
      :currentDate="currentDate"
      @prev="prevMonth"
      @next="nextMonth"
      style="background-color:#8EB8FF;height:200px;">
      </CalendarHeader>
    </div>
    <div style="min-width:100px;width:100%;border-top:5px #BAD3FF;background-color:#EEEEEE;">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        style="display:flex;border-left:5px solid #BAD3FF;height:200px;"
      >
        <div
        class="calendar-date"
        v-for="(day, index) in week"
        :key="index"
        style="width:150px;"
        >
          <div v-if="day.month===currentMonth" style="font-weight:200;font-size:50px;">{{day.date}}</div>
          <div v-if="day.month!==currentMonth" style="color:#D3D3D3;font-size:50px;">{{ day.date }}</div>
          <div>{{day.scheduleNum}}</div>
        </div>
      </div>
    </div>
    <div>
      <button class="btn btn-primary" @click="confirmCalendar">CofirmCalendar</button>
      <button class="btn btn-primary" @click="confirmCurrentMonth">CofirmCurrentMonth</button>
      <button class="btn btn-primary" @click="showDevidedSchedule">showDevidedSchedule</button>
      <button class="btn btn-primary" @click="confirmStateSchedule">confirmStateSchedule</button>
    </div>
  </div>
</template>

<script>
import store from '../store'

import moment from "moment";
import draggable from 'vuedraggable'

import CalendarHeader from "../components/CalendarHeader";
import Schedule from "../components/Schedule"

import DatePicker from '../components/DatePicker'

import {mapState, mapGetters} from 'vuex'


export default {
  name: 'Calendar',
  data() {
    return {
      // count: 0,
      devidedSchedules:[],
      options: {
        group: "myGroup",
        animation: 200
      },
      itemsB: [
         {
          title: 'hoge',
          start_yyyymmdd: moment('2020-09-07'),
          start_date: moment('2020-09-07').date(),
          end_yyyymmdd: moment('2020-09-10'),
          end_date: moment('2020-09-010').date(),
          color: '#FFD5EC',
          // icon: 0,
          commit: true
        },
      ],
      currentDate: moment().format('YYYY/MM'),
      currentYYMMDD: moment().format('YYYY/MM/DD'),
      currentMonth: moment().month()+1,
      currentYear: moment().year(),
      // schedules: [
      //   {
      //     title: 'Rails',
      //     start: moment('2020-09-07').format('YYYY-MM-DD'),
      //     end: moment('2020-09-010').format('YYYY-MM-DD'),
      //     color: '#FFD5EC',
      //     // icon: 0,
      //     commit: true
      //   },
      //   {
      //     title: 'ポートフォリオ',
      //     start: moment('2020-09-07').format('YYYY-MM-DD'),
      //     end: moment('2020-09-10').format('YYYY-MM-DD'),
      //     color: '#CBFFD3',
      //     // icon: 0,
      //     commit: true
      //   },
      //   {
      //     title: 'Docker制覇',
      //     start: moment('2020-09-07').format('YYYY-MM-DD'),
      //     end: moment('2020-09-10').format('YYYY-MM-DD'),
      //     color: '#CCFFFF',
      //     // icon: 0,
      //     commit: true　
      //   },
      // ],
    };
  },
  components: {
    draggable,
    CalendarHeader,
    Schedule,
    DatePicker
  },
  methods: {
    commitChange(){
      let selectedCardId = Number(event.currentTarget.id.substr(14));
      this.devidedSchedules[selectedCardId].commit = !this.devidedSchedules[selectedCardId].commit;
      return this.devidedSchedules;
    },
    confirmStartDate(){
      let date = moment(this.currentDate);
      const youbiNum = date.day();
      let startDate = date.subtract(youbiNum, "days");
      console.log(startDate);
      return startDate;
    },
    confirmCurrentMonth(){
      console.log(this.currentMonth);
    },
    confirmCalendar(){
      console.log(this.calendars);
    },
    confirmIconNum(){
      console.log(this.schedules[0].icon);
    },
    confirmStateSchedule(){
      console.log(this.$store.getters['schedules/schedules']);
      console.log(this.$store.getters['schedules/schedules'][0]);
      console.log(this.$store.getters['schedules/schedules'][0].start);
      console.log(this.$store.getters['schedules/schedules'][1]);
      console.log(this.$store.getters['schedules/schedules'].length);
    },
    // createDateArray(){
    //   // this.$store.dispatch('schedules/fetchSchedulesAction')
    //   let i = 0;
    //   let j = 0;
    //   let k = 0;
    //   var dateArrays = [];
    //   var currentDates = [];
    //   var stopDates = [];
    //   while(dateArrays.length <= this.$store.getters['schedules/schedules'].length){
    //     dateArrays.push([]);
    //   }
    //   while(i <= this.$store.getters['schedules/schedules'].length-1){
    //     currentDates.push(this.$store.getters['schedules/schedules'][i].start);
    //     i = i + 1;
    //   }
    //   while(j <= this.$store.getters['schedules/schedules'].length-1){
    //     stopDates.push(this.$store.getters['schedules/schedules'][j].end);
    //     j = j + 1;
    //   }
      
    //   while(k <= this.$store.getters['schedules/schedules'].length-1){
    //     while (currentDates[k] <= stopDates[k]) {
    //       dateArrays[k].push(currentDates[k])
    //       currentDates[k] = new Date(currentDates[k]).setDate(new Date().getDate() + 1);
    //     }
    //     k = k + 1; 
    //   }
    //   return currentDates;
    //   return stopDates;
    //   return dateArrays;
    //   console.log(currentDates)
    //   console.log(stopDates)
    //   console.log(dateArrays)
    // },
    createDevidedSchedules() {
      let i = 0;
      let j = 0;
      let k = 0;
      var dateArrays = [];
      var currentDates = [];
      var stopDates = [];
      while(dateArrays.length <= this.$store.getters['schedules/schedules'].length-1){
        dateArrays.push([]);
      }
      while(i <= this.$store.getters['schedules/schedules'].length-1){
        currentDates.push(moment(this.$store.getters['schedules/schedules'][i].start));
        i = i + 1;
      }
      while(j <= this.$store.getters['schedules/schedules'].length-1){
        stopDates.push(moment(this.$store.getters['schedules/schedules'][j].end));
        j = j + 1;
      }
      
      while(k <= this.$store.getters['schedules/schedules'].length -1){
        while (currentDates[k] <= stopDates[k]) {
          dateArrays[k].push( moment(currentDates[k]).format('YYYY-MM-DD') )
          currentDates[k] = moment(currentDates[k]).add(1, 'days');
        }
        k = k + 1; 
      }
      
      var devidedSchedules = [];

      //  for (let i = 0; i < moment(this.currentMonth).daysInMonth(); i++) {
      //   //カレンダーパネルを更新
      //   let todoNumber = 0;
      //   for (let k of Object.keys(this.todoList)) {
      //     //todoListの情報をカレンダーパネルに追加
      //     if (this.dates[i]) {
      //       if (this.todoList[k].date === this.dates[i].date) {
      //         todoNumber++;
      //       }
      //     }
      //   }

      let m = 0;
      let n = 0;
      let idNum = 0;
      while(m <= dateArrays.length -1){
        while(n <= dateArrays[m].length -1){
          idNum = idNum + 1;
          devidedSchedules.push({
            id: idNum,
            title: this.$store.state.schedules.schedules[m].title,
            color: this.$store.state.schedules.schedules[m].color,
            // icon: this.$store.state.schedules.schedules[m].icon,
            commit: this.$store.state.schedules.schedules[m].commit,
            yyyymm: moment(dateArrays[m][n]).format('YYYY/MM'),
            year: moment(dateArrays[m][n]).year(),
            month: moment(dateArrays[m][n]).month()+1,
            date: moment(dateArrays[m][n]).date(),
          });
          n = n + 1;
        }
        idNum = idNum +1;
        n = 0;
        m = m + 1;
      }
      
      this.devidedSchedules =  devidedSchedules;
      console.log(this.devidedSchedules)
      
    },
    showDevidedSchedule() {
      this.createDevidedSchedules();
      console.log(this.devidedSchedules);
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
    confirmMoment(){
      console.log(this.calendars);
      console.log(this.calendars[4][6]);
      console.log(moment(this.currentDate).endOf("month").date()-1);
    },
    // getCalendar() {
    //   let startDate = this.getStartDate();
    //   const endDate = this.getEndDate();
    //   const weekNumber = Math.ceil(endDate.diff(startDate, "days") / 7);

    //   let calendars = [];
    //   this.createDevidedSchedules();

    //   for (let week = 0; week < weekNumber; week++) {
    //     let weekRow = [];
    //     for (let day = 0; day < 7; day++) {
    //       let scheduleNum = 0;
    //       for (let k=0; k < this.devidedSchedules.length; k++) {
    //       //todoListの情報をカレンダーパネルに追加
    //         if (this.devidedSchedules[k].date === startDate.get("date")&&this.devidedSchedules[k].commit===true) {
    //           scheduleNum++;
    //         }
    //       }

    //       weekRow.push({
    //         year: startDate.get("year"),
    //         month: startDate.get("month")+1,
    //         date: startDate.get("date"),
    //         scheduleNum: scheduleNum
    //       });
    //       startDate.add(1, "days");
    //     }
    //       calendars.push(weekRow);
    //   }

    //   return calendars;
    //   console.log(calendars);

    // },
    getCalendar() {
      let startDate = this.getStartDate();
      const endDate = this.getEndDate();
      const weekNumber = Math.ceil(endDate.diff(startDate, "days") / 7);

      let calendars = [];

      for (let week = 0; week < weekNumber; week++) {
        let weekRow = [];
        for (let day = 0; day < 7; day++) {
          let scheduleNum = 0;
          for (let k=0; k < this.$store.getters['schedules/schedules'].length; k++) {
          //todoListの情報をカレンダーパネルに追加
            if (this.$store.getters['schedules/schedules'][k].date_day === startDate.get("date")&&this.$store.getters['schedules/schedules'][k].commit===true) {
              scheduleNum++;
            }
          }

          weekRow.push({
            year: startDate.get("year"),
            month: startDate.get("month")+1,
            date: startDate.get("date"),
            scheduleNum: scheduleNum
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
    // displayScheduleNum(){
    // this.calendars = []; //カレンダーパネルを初期化
    //   for (let i = 0; i < moment(this.currentMonth).daysInMonth(); i++) {
    //     //カレンダーパネルを更新
    //     let todoNumber = "-";
    //     for (let k of Object.keys(this.devidedSchedules)) {
    //       //todoListの情報をカレンダーパネルに追加
    //       if (this.calendars[i]) {
    //         if (this.devidedSchedules[k].date === this.calendars[i].date) {
    //           todoNumber++;
    //         }
    //       }
    //     }
    //     this.calendars[i] = {
    //       date: moment(this.currentMonth)
    //         .startOf("month")
    //         .add(i, "day")
    //         .format("YYYY-MM-DD"),
    //       dateNumber: i + 1,
    //       todoNumber: todoNumber
    //     };
    // }
  },
  computed: {
    calendars() {
      return this.getCalendar();
    },
    // devidedSchedules() {
    //   return this.createDevidedSchedules();
    // },
    scheduleNum() {
      return this.calendar.scheduleNum;
    },
    ...mapState('schedules',{
      schedules: 'schedules',
    }),
    ...mapGetters('schedules',[
      'schedules'
    ])
  },
  created(){
    console.log(currentDate);
    return this.createDevidedSchedules();
    // this.displayScheduleNum();
  },
  mounted(){
    // this.$store.dispatch('schedules/fetchSchedulesAction')
  },
  watch:{
    // devidedSchedules(){
    //   this.createDevidedSchedules();
    //   this.getCalendar();
    // },
    // calendar(){
    //   this.getCalendar();
    // }
    // getCalendar() {
    //   let startDate = this.getStartDate();
    //   const endDate = this.getEndDate();
    //   const weekNumber = Math.ceil(endDate.diff(startDate, "days") / 7);

    //   let calendars = [];
    //   this.createDevidedSchedules();

    //   for (let week = 0; week < 1; week++) {
    //     let weekRow = [];
    //     for (let day = 0; day < moment(this.currentMonth).daysInMonth(); day++) {
    //       let scheduleNum = 0;
    //       for (let k=0; k < this.devidedSchedules.length; k++) {
    //       //todoListの情報をカレンダーパネルに追加
    //         if (this.devidedSchedules[k].date === startDate.get("date")&&this.devidedSchedules[k].commit===true) {
    //           scheduleNum++;
    //         }
    //       }

    //       weekRow.push({
    //         year: startDate.get("year"),
    //         month: startDate.get("month")+1,
    //         date: startDate.get("date"),
    //         scheduleNum: scheduleNum
    //       });
    //       startDate.add(1, "days");
    //     }
    //       this.calendars.push(weekRow);
    //   }

    //   return this.calendars;
    //   console.log(this.calendars);

    // },
  }
}
</script>

<style scoped>
.calendar {
  padding-top:5%;
  margin-left: 15%;
  margin-right: 15%;
  /* margin-right: 10%; */
  /* position: fixed; */
  width:40%;
  /* z-index:1; */
}

.calendar-header-area {
  height:200px;
}

.calendar-date{
  flex:1;
  min-height:150px;
  border-right:5px solid #BAD3FF;
  border-bottom:5px solid #BAD3FF;
  text-align: center;
  font-size:25px;
}

/* .calendar-date:hover {
  background-color: silver;
  border-radius: 4px;
} */

</style>
