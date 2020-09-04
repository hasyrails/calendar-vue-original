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
            v-if="schedule.start<=day.date&&day.date<=schedule.end"
            style="flex:1;min-height:1px;min-width:1px;max-height:10px;max-width:10px;text-align: center;border-radius:100px;margin-bottom:10px;"
            :style="'background-color:'+schedule.color+';'"
          >
            {{ schedule.name }}
          </div> -->
          <div
            v-for="commitSchedule in commitSchedules"
            style="flex:1;min-height:1px;min-width:1px;max-height:10px;max-width:10px;text-align: center;border-radius:100px;margin-bottom:10px;"
            :style="'background-color:'+commitSchedule.color+';'"
          >
            {{ commitSchedule.name }}
          </div>
        </div>
      </div>
    </div>z
    <div>
      <button @click="confirmMoment">Confirm</button>
    </div>
  </div>
</template>

<script>
import moment from "moment";
import ChevronLeft from 'vue-material-design-icons/ChevronLeft.vue';
import ChevronRight from 'vue-material-design-icons/ChevronRight.vue';

  const schedules =  [
    {
      name: 'hoge',
      start: moment('2020-09-07'),
      end: moment('2020-09-010'),
      color: 'red',
    },
    {
      name: 'fuga',
      start: moment('2020-09-08'),
      end: moment('2020-09-012'),
      color: 'blue',
    },
  ];
  // function getDateRangeArray_0(startDate_0, stopDate_0) {
  //   var dateRangeArray_0 = [];
  //   var startDate_0 = schedules[0].start;
  //   var stopDate_0 = schedules[0].end;
  //   while (startDate_0 <= stopDate_0) {
  //       dateRangeArray_0.Push( moment(startDate_0).format('YYYY-MM-DD') )
  //       startDate_0 = moment(startDate_0).add(1, 'days');
  //   }
  //   return dateRangeArray_0;
  // };
  // getStartDate() {
    //   let date = moment(this.currentDate);
  //   date.startOf("month");
  //   const youbiNum = date.day();
  //   return date.subtract(youbiNum, "days");
  // },
  // getEndDate() {
  //   let date = moment(this.currentDate);
  //   date.endOf("month");
  //   const youbiNum = date.day();
  //   return date.add(6 - youbiNum, "days");
  // },

  // function getDateRangeArray_0() {
  //   // let startDate = this.getStartDate();
  //   let startDate_0 = schedules[0].start;
  //   // const endDate = this.getEndDate();
  //   const endDate_0 = schedules[0].end;
  //   const DateRange_0 = endDate_0.diff(startDate_0, 'days')+1; 
  
  //   let calendars = [];
  //   for (let week = 0; week < weekNumber; week++) {
  //     let weekRow = [];
  //     for (let day = 0; day < 7; day++) {
  //       weekRow.push({
  //         date: startDate.get("date"),
  //       });
  //       startDate.add(1, "days");
  //     }
  //     calendars.push(weekRow);
  //   }
  //   return calendars;
  // };


export default {
  name: 'Calendar',
  data() {
    return {
      currentDate: moment().format('YYYY/MM'),
      commitSchedules: [
        {
          name: [...schedules]['0'].name,
          color: [...schedules]['0'].color
        },
        {
          name: [...schedules]['1'].name,
          color: [...schedules]['1'].color
        },
      ]
    };
  },
  components: {
    ChevronLeft,
    ChevronRight
  },
  methods: {
    confirmMoment(){
      // console.log(moment('2020-09-010').diff(moment('2020-09-07'), 'days'))
      // console.log(dateRangeArray_0)
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
      for (let day = 0; day <script 7; day++) {
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
