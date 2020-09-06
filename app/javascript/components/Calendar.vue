<template>
  <div class="calendar" >
    <div class="calendar-header">
      <div class="calendar-header-content flex">
        <ChevronLeft fillColor="white"  @click="prevMonth" size="lg"></ChevronLeft>
        <div class="calendar-header-date">{{ currentDate }}</div>
        <ChevronRight fillColor="white" @click="nextMonth" size="lg"></ChevronRight>
      </div>
    </div>

    <div style="min-width:100px;width:1225px;border-top:1px solid grey;background-color:#EEEEEE;">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        style="display:flex;border-left:1px solid grey;height:150px;"
      >
        <div
          v-for="(day, index) in week"
          :key="index"
          style="flex:1;min-height:125px;border-right:1px solid grey;border-bottom:1px solid grey; text-align: center;font-size:25px;"
        >
          {{ day.date }}
  
        <draggable  v-model="devidedSchedule" group="myGroup" @start="drag=true" @end="drag=false" :options="options">
          <div 
          v-for="devidedSchedule in devidedSchedules"
          v-if="devidedSchedule.date==day.date&&devidedSchedule.yyyymm==currentDate"
          style="flex:1;min-height:1px;min-width:1px;max-height:100px;max-width:50px;text-align: center;margin-bottom:10px;"
          >
            <div class="card" 
              style="flex:1;min-height:10px;width:100px;height:30px;max-width:100px;text-align: center;margin-left:15px;"
              :style="'background-color:'+devidedSchedule.color+';'"
              @click="iconChange"
              >
              <div class="card-body" style="display:flex; justify-content:center; padding-top:2px;font-size:20px;">
                <div>
                  <p v-if="devidedSchedule.icon===1"><font-awesome-icon icon="coffee"  size="sm" /></p>
                  <p v-else-if="devidedSchedule.icon===2"><font-awesome-icon icon="bath"  size="sm" /></p>
                  <p v-else-if="devidedSchedule.icon===3"><font-awesome-icon icon="birthday-cake" size="sm"/></p>
                  <p v-else></p>
                </div>
                  {{devidedSchedule.title}}
                <div class="schedule-title" style="margin-left:10px;">
                </div>
              </div>
            </div>
          </div>
        </draggable>

        </div>
      </div>
    </div>

    <div>
      <h3>タスクカード(仮)</h3>
      <draggable v-model="itemsB" group="myGroup" @start="drag=true" @end="drag=false" :options="options">
        <div class="item" v-for="item in itemsB" :key="item.id">
          <div class="card">
            <div class="card-body">
              {{item.title}}
            </div>
          </div>

        </div>
      </draggable>
    </div>
  </div>
</template>

<script>
import moment from "moment";
import draggable from 'vuedraggable'
import ChevronLeft from 'vue-material-design-icons/ChevronLeft.vue';
import ChevronRight from 'vue-material-design-icons/ChevronRight.vue';

export default {
  name: 'Calendar',
  data() {
    return {
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
          icon: 0,
          commit: 'yes'
        },
      ],
      currentDate: moment().format('YYYY/MM'),
      schedules: [
        {
          title: 'hoge',
          start_yyyymmdd: moment('2020-09-07'),
          start_date: moment('2020-09-07').date(),
          end_yyyymmdd: moment('2020-09-10'),
          end_date: moment('2020-09-010').date(),
          color: '#FFD5EC',
          icon: 0,
          commit: 'yes'
        },
        {
          title: 'fuga',
          start_yyyymmdd: moment('2020-09-08'),
          start_date: moment('2020-09-08').date(),
          end_yyyymmdd: moment('2020-09-12'),
          end_date: moment('2020-09-12').date(),
          color: '#BAD3FF',
          icon: 0,
          commit: 'no'
        },
        {
          title: 'yagi',
          start_yyyymmdd: moment('2020-09-01'),
          start_date: moment('2020-09-01').date(),
          end_yyyymmdd: moment('2020-09-03'),
          end_date: moment('2020-09-03').date(),
          color: '#CBFFD3',
          icon: 0,
          commit: 'no'
        }
      ],
    };
  },
  components: {
    ChevronLeft,
    ChevronRight,
    draggable
  },
  mounted: function(){
  },
  methods: {
    iconChange(){
      switch(this.schedules[0].icon){
        case 0:
          this.schedules[0].icon = 1
          // this.createDevidedSchedules();
          break;
          this.schedules[0].icon = 2
          // this.createDevidedSchedules();
            case 1:
          break;
        case 2:
          this.schedules[0].icon = 3
          // this.createDevidedSchedules();
          break;
        case 3:
          this.schedules[0].icon = 0
          // this.createDevidedSchedules();
          break;
      }
    },
    // iconChange(){
    //   if(this.schedules[0].icon = 0){
    //     this.schedules[0].icon = 1;
    //     this.createDevidedSchedules();
    //   }else if(this.schedule[0].icon =1){
    //     this.schedules = [];
    //     this.schedules[0].icon = 2;
    //     this.createDevidedSchedules();
    //   }else{
    //     console.log('else')
    //   }
    // },
    confirmIconNum(){
      console.log(this.schedules[0].icon);
    },
    confirmCurrentDate(){
      console.log(this.confirmCurrentDate);
    },
    createDevidedSchedules() {
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
      
      var devidedSchedules = [];
      let m = 0;
      let n = 0;
      while(m <= dateArrays.length -1){
        while(n <= dateArrays[m].length -1){
          devidedSchedules.push({
            title: this.schedules[m].title,
            color: this.schedules[m].color,
            icon: this.schedules[m].icon,
            commit: this.schedules[m].commit,
            yyyymm: moment(dateArrays[m][n]).format('YYYY/MM'),
            date: moment(dateArrays[m][n]).date(),
          });
          n = n + 1;
        }
        n = 0;
        m = m + 1;
      }

      console.log(devidedSchedules);
      return devidedSchedules;
    },
    showDevidedSchedule() {
      console.log(devidedSchedules);
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

      for (let s = 0; s <= 6; s++){
        if(JSON.stringify(calendars[0][s]) != JSON.stringify({date:moment(this.currentDate).startOf("month").date()})){
          calendars[0].splice(s,1);
          calendars[0].splice(s,0,'');
        }
        else{
          break;
        }
      }
      
      if(calendars.length = 5){
        for(let s=0; s<=6; s++){
          let finalWeek = JSON.stringify(calendars[4][s]);
  
          switch(finalWeek){
            case JSON.stringify({date:moment(this.currentDate).startOf("month").date()}):
              calendars[4].splice(s,1);
              calendars[4].splice(s,0,'');
              break;
            case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+1}):
              calendars[4].splice(s,1);
              calendars[4].splice(s,0,'');
              break;
            case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+2}):
              calendars[4].splice(s,1);
              calendars[4].splice(s,0,'');
              break;
            case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+3}):
              calendars[4].splice(s,1);
              calendars[4].splice(s,0,'');
              break;
            case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+4}):
              calendars[4].splice(s,1);
              calendars[4].splice(s,0,'');
              break;
            case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+5}):
              calendars[4].splice(s,1);
              calendars[4].splice(s,0,'');
              break;
            case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+6}):
              calendars[4].splice(s,1);
              calendars[4].splice(s,0,'');
              break;
          }
        }
      }else if (calendars.length>5){
        
        let finalWeek = JSON.stringify(calendars[5][s]);

        switch(finalWeek){
          case JSON.stringify({date:moment(this.currentDate).startOf("month").date()}):
            calendars[5].splice(s,1);
            calendars[5].splice(s,0,'');
            break;
          case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+1}):
            calendars[5].splice(s,1);
            calendars[5].splice(s,0,'');
            break;
          case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+2}):
            calendars[5].splice(s,1);
            calendars[5].splice(s,0,'');
            break;
          case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+3}):
            calendars[5].splice(s,1);
            calendars[5].splice(s,0,'');
            break;
          case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+4}):
            calendars[5].splice(s,1);
            calendars[5].splice(s,0,'');
            break;
          case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+5}):
            calendars[5].splice(s,1);
            calendars[5].splice(s,0,'');
            break;
          case JSON.stringify({date:moment(this.currentDate).startOf("month").date()+6}):
            calendars[5].splice(s,1);
            calendars[5].splice(s,0,'');
            break;
        }
      }

      let weekRow5 = calendars[4]
      let finalDateEl = calendars[4][6]
      let finalDate = Object.values(finalDateEl).[0]
      let finalDateObject = {date: moment(this.currentDate).endOf("month").date()};
      function beforeFinalDateObject(n) {
        return  {date: moment(this.currentDate).endOf("month").date() -n};
      }

      if(weekRow5.some(wR => wR.date === finalDateObject.date)){
        console.log('最終日あり');
      }else{
        console.log('最終日なし')
        switch(finalDate){
          case moment(this.currentDate).endOf("month").date()-1:
            calendars.push([finalDateObject,'','','','','','']);
            break;
          case moment(this.currentDate).endOf("month").date()-2:
            calendars.push([beforeFinalDateObject(1),finalDateObject,'','','','','']);
            break;
          case moment(this.currentDate).endOf("month").date()-3:
            calendars.push([beforeFinalDateObject(2),beforeFinalDateObject(1),finalDateObject,'','','','']);
            break;
          case moment(this.currentDate).endOf("month").date()-4:
            calendars.push([beforeFinalDateObject(3),beforeFinalDateObject(2),beforeFinalDateObject(1),finalDateObject,'','','']);
            break
        }
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
    devidedSchedules() {
      return this.createDevidedSchedules();
    },
  },
  created(){
    return this.createDevidedSchedules();
  }
  }
</script>

<style scoped>
.calendar {
  margin-left: 10%;
  margin-right: 10%;
}
.calendar-header {
  width:1225px;
  height:100px;
  background-color: #75A9FF;
}

.calendar-header-content {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom:100px;
}
.calendar-header-date {
  color: white;
  font-size: 32px;
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
