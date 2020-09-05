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
            v-for="(devidedSchedule, index) in devidedSchedules"
          :key="index"
          style="flex:1;min-height:1px;min-width:1px;max-height:10px;max-width:10px;border-right:1px solid grey;border-bottom:1px solid grey; text-align: center;background-color:blue;"
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
            
            <!-- <div v-for="devidedSchedule in devidedSchedules">
              {{ devidedSchedule.title}}
            <ul>
              <li v-for="date in devidedSchedule.span">
                {{ span.da }}
              </li>
            </ul>
          </div> -->

          <ul v-for="devidedSchedule in devidedSchedules">
            <li v-for="date in devidedSchedule">{{date}}</li>
          </ul>

        </div>
      </div>
    </div>
    <div>
      <!-- <button @click="createDevidedSchedules">ConfirmArray</button> -->
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
      devidedSchedules: [
        [
          {
            title: this.schedules[0].title,
            color: this.schedules[0].color,
            commit: this.schedules[0].commit,
          },
          {
            title: this.schedules[0].title,
            color: this.schedules[0].color,
            commit: this.schedules[0].commit,
          },
          {
            title: this.schedules[0].title,
            color: this.schedules[0].color,
            commit: this.schedules[0].commit,
          },
          {
            title: this.schedules[0].title,
            color: this.schedules[0].color,
            commit: this.schedules[0].commit,
          },
        ],
        [
          {
            title: this.schedules[1].title,
            color: this.schedules[1].color,
            commit: this.schedules[1].commit,
            date: dateArrays[1][0],
          },
          {
            title: this.schedules[1].title,
            color: this.schedules[1].color,
            commit: this.schedules[1].commit,
            date: dateArrays[1][1],
          },
          {
            title: this.schedules[1].title,
            color: this.schedules[1].color,
            commit: this.schedules[1].commit,
            date: dateArrays[1][2],
          },
          {
            title: this.schedules[1].title,
            color: this.schedules[1].color,
            commit: this.schedules[1].commit,
            date: '2020-09-21',
          },
          {
            title: this.schedules[1].title,
            color: this.schedules[1].color,
            commit: this.schedules[1].commit,
            date: dateArrays[1][4],
          },
        ],
        [
          {
            title: this.schedules[2].title,
            color: this.schedules[2].color,
            commit: this.schedules[2].commit,
            date: dateArrays[2][0],
          },
          {
            title: this.schedules[2].title,
            color: this.schedules[2].color,
            commit: this.schedules[2].commit,
            date: dateArrays[2][1],
          },
          {
            title: this.schedules[2].title,
            color: this.schedules[2].color,
            commit: this.schedules[2].commit,
            date: dateArrays[2][2],
          }
        ]
      ]
    };
  },
  components: {
    ChevronLeft,
    ChevronRight
  },
   created() {
    //  this.createDevidedSchedules;
  },
  methods: {
    showDevidedSchedule() {
      console.log(this.schedules.length);
      console.log(devidedSchedules);
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
    // createDevidedSchedules(){
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

    //   var devidedSchedules = [];
    //   devidedSchedules.push(
    //       {
    //         title: this.schedules[0].title,
    //         color: this.schedules[0].color,
    //         commit: this.schedules[0].commit,
    //         span: [
    //           {date: dateArrays[0][0]},
    //           {date: dateArrays[0][1]},
    //           {date: dateArrays[0][2]},
    //           {date: dateArrays[0][3]}
    //         ]
    //       },
    //       {
    //         title: this.schedules[1].title,
    //         color: this.schedules[1].color,
    //         commit: this.schedules[1].commit,
    //         span: [
    //           {date: dateArrays[1][0]},
    //           {date: dateArrays[1][1]},
    //           {date: dateArrays[1][2]},
    //         ]
    //       },
    //       {
    //         title: this.schedules[2].title,
    //         color: this.schedules[2].color,
    //         commit: this.schedules[2].commit,
    //         span: [
    //           {date: dateArrays[2][0]},
    //           {date: dateArrays[2][1]},
    //           {date: dateArrays[2][2]},
    //           ]
    //       },
    //   );
    //   console.log(devidedSchedules);
    //   return devidedSchedules;
    // }
  },
  computed: {
    calendars() {
      return this.getCalendar();
    },
    // devidedSchedules(){
    //   return this.createDevidedSchedules();
    // }
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
