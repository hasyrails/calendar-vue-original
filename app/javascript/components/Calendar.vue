<template>
  <div class="calendar">
    <div class="calendar-header">
      <div class="calendar-header-content flex">
        <ChevronLeft fillColor="white"  @click="prevMonth"></ChevronLeft>
        <div class="calendar-header-date">{{ currentDate }}</div>
        <ChevronRight fillColor="white" @click="nextMonth"></ChevronRight>
      </div>
    </div>

    <div style="max-width:900px;border-top:1px solid grey;">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        style="display:flex;border-left:1px solid grey"
      >
        <div
          v-for="(day, index) in week"
          :key="index"
          style="flex:1;min-height:125px;border-right:1px solid grey;border-bottom:1px solid grey; text-align: center;"
        >
          {{ day.date }}
          <!-- <div
            v-for="(schedule, index) in schedules"
          :key="index"
          style="flex:1;min-height:1px;min-width:1px;max-height:5px;max-width:5px;border-right:1px solid grey;border-bottom:1px solid grey; text-align: center;background-color:blue;"
          > -->
          <!-- <div
            v-for="schedule in schedules"
            v-if="schedule.start_date<=day.date&&day.date<=schedule.end_date&&schedule.commit=='yes'"
            style="flex:1;min-height:1px;min-width:1px;max-height:10px;max-width:10px;text-align: center;border-radius:100px;margin-bottom:10px;"
            :style="'background-color:'+schedule.color+';'"
          >
            {{ schedule.title }}
          </div> -->
          <!-- <div
            v-for="schedule in DevidedSchedule"
            style="flex:1;min-height:1px;min-width:1px;max-height:10px;max-width:10px;text-align: center;border-radius:100px;margin-bottom:10px;"
            :style="'background-color:'+schedule.color+';'"
          >
            {{ schedule }}
          </div> -->
          <div>{{ DevidedSchedule[0][0] }}</div>
        </div>
      </div>
    </div>
    <div>
      <button @click="createDevidedSchedule">Confirm</button>
      <button @click="showDevidedSchedule">ConfirmArray</button>
    </div>
  </div>
</template>

<script>
import moment from "moment";
import ChevronLeft from 'vue-material-design-icons/ChevronLeft.vue';
import ChevronRight from 'vue-material-design-icons/ChevronRight.vue';

export default {
  name: 'Calendar',
  data() {
    return {
      currentDate: moment().format('YYYY/MM'),
      schedules: [
        {
          title: 'hoge',
          start_yyyymmdd: moment('2020-09-07'),
          start_date: moment('2020-09-07').date(),
          end_yyyymmdd: moment('2020-09-10'),
          end_date: moment('2020-09-010').date(),
          color: 'red',
          commit: 'yes'
        },
        {
          title: 'fuga',
          start_yyyymmdd: moment('2020-09-08'),
          start_date: moment('2020-09-08').date(),
          end_yyyymmdd: moment('2020-09-12'),
          end_date: moment('2020-09-12').date(),
          color: 'blue',
          commit: 'no'
        },
        {
          title: 'yagi',
          start_yyyymmdd: moment('2020-09-01'),
          start_date: moment('2020-09-01').date(),
          end_yyyymmdd: moment('2020-09-03'),
          end_date: moment('2020-09-03').date(),
          color: 'blue',
          commit: 'no'
        }
      ],
    };
  },
  components: {
    ChevronLeft,
    ChevronRight
  },
  mounted: function(){
      let i = 0;
      let j = 0;
      let k = 0;
      var dateArrays = [];
      var currentDates = [];
      var stopDates = [];
      while(dateArrays.length <= this.schedules.length-1){
        dateArrays.push([]);
      }
      while(i <= this.schedules.length-1){
        currentDates.push(moment(this.schedules[i].start_yyyymmdd));
        i = i + 1;
      }
      while(j <= this.schedules.length-1){
        stopDates.push(moment(this.schedules[j].end_yyyymmdd));
        j = j + 1;
      }
      
      while(k <= this.schedules.length -1){
        while (currentDates[k] <= stopDates[k]) {
          dateArrays[k].push( moment(currentDates[k]).format('YYYY-MM-DD') )
          currentDates[k] = moment(currentDates[k]).add(1, 'days');
        }
        k = k + 1; 
      }
      // console.log(dateArrays);
      
      var emptyArray = [];
      var DevidedSchedule = [];
      let N = 0;
      while(N <= this.schedules.length -1){
        DevidedSchedule.push([]);
        N = N + 1;
      }


      // let m = 0;
      //   while(m <= DevidedSchedule.length-1){
      //     DevidedSchedule[m].push({
      //       title: this.schedules[m].title,
      //       color: this.schedules[m].color,
      //       commit: this.schedules[m].commit,
      //       date: dateArrays[m][0],
      //     });
      //     m = m + 1;
      //   }

      let m = 0;
      let n = 0;
      while(m <= dateArrays.length -1){
        while(n <= dateArrays[m].length -1){
          DevidedSchedule[m].push({
            title: this.schedules[m].title,
            color: this.schedules[m].color,
            commit: this.schedules[m].commit,
            date: dateArrays[m][n],
          });
          n = n + 1;
        }
        n = 0;
        m = m + 1;
      }

      console.log(this.schedules.length);
      console.log(DevidedSchedule);
      console.log(dateArrays);
      console.log(dateArrays[0][0]);
      console.log(dateArrays[0].length-1);
  },
  methods: {
    // getArray() {
    //   let i = 0;
    //   let j = 0;
    //   let k = 0;
    //   var dateArrays = [];
    //   var currentDates = [];
    //   var stopDates = [];
    //   while(dateArrays.length <= this.schedules.length-1){
    //     dateArrays.push([]);
    //   }
    //   while(i <= this.schedules.length-1){
    //     currentDates.push(moment(this.schedules[i].start_yyyymmdd));
    //     i = i + 1;
    //   }
    //   while(j <= this.schedules.length-1){
    //     stopDates.push(moment(this.schedules[j].end_yyyymmdd));
    //     j = j + 1;
    //   }
      
    //   while(k <= this.schedules.length -1){
    //     while (currentDates[k] <= stopDates[k]) {
    //       dateArrays[k].push( moment(currentDates[k]).format('YYYY-MM-DD') )
    //       currentDates[k] = moment(currentDates[k]).add(1, 'days');
    //     }
    //     k = k + 1; 
    //   }
    //   // console.log(dateArrays);
      
    //   var emptyArray = [];
    //   var DevidedSchedule = [];
    //   let N = 0;
    //   while(N <= this.schedules.length -1){
    //     DevidedSchedule.push([]);
    //     N = N + 1;
    //   }


    //   // let m = 0;
    //   //   while(m <= DevidedSchedule.length-1){
    //   //     DevidedSchedule[m].push({
    //   //       title: this.schedules[m].title,
    //   //       color: this.schedules[m].color,
    //   //       commit: this.schedules[m].commit,
    //   //       date: dateArrays[m][0],
    //   //     });
    //   //     m = m + 1;
    //   //   }

    //   let m = 0;
    //   let n = 0;
    //   while(m <= dateArrays.length -1){
    //     while(n <= dateArrays[m].length -1){
    //       DevidedSchedule[m].push({
    //         title: this.schedules[m].title,
    //         color: this.schedules[m].color,
    //         commit: this.schedules[m].commit,
    //         date: dateArrays[m][n],
    //       });
    //       n = n + 1;
    //     }
    //     n = 0;
    //     m = m + 1;
    //   }

    //   console.log(this.schedules.length);
    //   console.log(DevidedSchedule);
    //   console.log(dateArrays);
    //   console.log(dateArrays[0][0]);
    //   console.log(dateArrays[0].length-1);
    // },
    showDevidedSchedule() {
      console.log(this.schedules.length);
      console.log(DevidedSchedule);
      console.log(dateArrays);
      console.log(dateArrays[0][0]);
      console.log(dateArrays[0].length-1);
    },
    confirmMoment(){
      // this.getDates();
      // console.log(dateArray);
    },
    // getSchedules(){
    //   let schedules = [];
    //   schedules.push({name: 'hoge'});
    //   return schedules;
    // },
    getStartDate() {
      let date = moment(this.currentDate);
      date.startOf("month");
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
        date: startDate.get("date"),
        });
        startDate.add(1, "days");
      }
      calendars.push(weekRow);
      }
      return calendars;
    },
    nextMonth() {
      this.currentDate = moment(this.currentDate).add(1, "month").format('YYYY/MM');
      this.getCalendar();
    },
    prevMonth() {
      this.currentDate = moment(this.currentDate).subtract(1, "month").format('YYYY/MM');
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
.calendar {
  margin-left: 30%;
  margin-right: 30%;
}
.calendar-header {
  max-width:900px;
  background-color: #3366FF;
}
.calendar-header-date {
  color: white;
}
.flex{
  padding: 2.5% 0;
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;
}
.flex > *{
  width: 8%;
  text-align: center;
}
</style>
