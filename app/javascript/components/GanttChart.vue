<template>
  <div class="calendar">
    <div class="calendar-header-area">
      <GanttChartHeader
      :currentDate="currentDate"
      @prev="prevMonth"
      @next="nextMonth"
      @showDatePicker="$listeners['showDatePicker']"
      style="background-color:#8EB8FF;height:200px;">
      </GanttChartHeader>
    </div>
    <div style="min-width:100px;width:100%;border-top:5px #BAD3FF;background-color:#EEEEEE;">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        style="display:flex;border-left:5px solid #BAD3FF;height:600px;"
      >
        <div
        class="calendar-date"
        v-for="(day, index) in week"
        :key="index"
        style="width:250px;"
        :id="day.year+'-'+day.month+'-'+day.date"
        >
        <div v-if="day.month===currentMonth" style="font-weight:200;font-size:50px;">{{day.date}}</div>
        <div v-if="day.month!==currentMonth" style="color:#D3D3D3;font-size:50px;">{{ day.date }}</div>
        <draggable
        v-model="devidedSchedule"
       >
          <Schedule 
          :devidedSchedule="devidedSchedule"
          v-for="devidedSchedule in devidedSchedules"
          :key="devidedSchedule.id"
          v-if="devidedSchedule.date==day.date&&devidedSchedule.month==day.month&&devidedSchedule.year==day.year"
          style="flex:1;min-height:1px;min-width:1px;max-width:230px;text-align: center;margin-bottom:10px;"
          @clickScheduleSettingButton="openScheduleSettingModal"
          >
          </Schedule>
        </draggable>
      </div>
    </div>
  </div>
  <div>
    <ScheduleSettingModal
    :devidedSchedule="scheduleDetail"
    v-for="devidedSchedule in devidedSchedules"
    :key="devidedSchedule.id"
    v-if="scheduleSettingModalFlag"
    @clickCloseButton="closeScheduleSettingModal"
    @clickScheduleEditButton="openScheduleEditModal(scheduleDetail)"
    ></ScheduleSettingModal>
  </div>
  <div>
    <ScheduleEditModal
    v-for="devidedSchedule in devidedSchedules"
    :devidedSchedule="editSchedule"
    :key="devidedSchedule.id"
    v-if="scheduleEditModalFlag"
    @clickScheduleUpdateButton="updateSchedule"
    @clickScheduleEditModalCloseButton="closeScheduleEditModal"
    ></ScheduleEditModal>
  </div>
  <div>
    <button class="btn btn-primary" @click="confirmCurrentDate">CofirmCurrentDate</button>
    <button class="btn btn-primary" @click="confirmCalendar">CofirmCalendar</button>
    <button class="btn btn-primary" @click="confirmCurrentMonth">CofirmCurrentMonth</button>
    <button class="btn btn-primary" @click="showDevidedSchedule">showDevidedSchedule</button>
    <button class="btn btn-primary" @click="confirmStartDate">confirmStartDate</button>
    <button class="btn btn-primary" @click="openScheduleSettingModal">setting</button>
  </div>
</div>
</template>

<script>
import moment from "moment";
import draggable from 'vuedraggable'

import GanttChartHeader from "../components/GanttChartHeader";
import Schedule from "../components/Schedule"
import { mapState } from 'vuex'
import ScheduleSettingModal from "../components/ScheduleSettingModal"
import ScheduleEditModal from "../components/ScheduleEditModal"

export default {
  name: 'Calendar',
  data() {
    return {
      // count: 0,
      scheduleSettingModalFlag: false,
      scheduleEditModalFlag: false,
      // devidedSchedules:[],
      options: {
        group: {
          name: 'myGroup',
          filter: '.schedule-card',
        },
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
      // currentDate: moment().format('YYYY/MM'),
      // currentYYMMDD: moment().format('YYYY/MM/DD'),
      // currentMonth: moment().month()+1,
      // currentYear: moment().year(),
    };
  },
  components: {
    draggable,
    GanttChartHeader,
    Schedule,
    ScheduleSettingModal,
    ScheduleEditModal,
  },
  mounted: function(){
  },
  methods: {
    openScheduleSettingModal(schedule){
      this.scheduleSettingModalFlag = true
      this.scheduleDetail = schedule
    },
    closeScheduleSettingModal(){
      this.scheduleSettingModalFlag = false
    },
    openScheduleEditModal(schedule){
      this.closeScheduleSettingModal()
      this.scheduleEditModalFlag = true
      this.editSchedule = schedule
    },
    closeScheduleEditModal(){
      this.scheduleEditModalFlag = false
    },
    updateSchedule(schedule){
      // const index = this.devidedSchedules.findIndex(devidedSchedule => {
      //   return devidedSchedule.id == schedule.id
      // })
      // this.devidedSchedules.splice(index, 1, schedule)
      // return this.devidedSchedules
      // console.log(schedule)
      // console.log(this.devidedSchedules)
      // this.scheduleEditModalFlag = false

      // this.devidedSchedules.splice(1)
      // this.$store.state.schedules.splice(2)
      this.schedules.splice(2)
    },
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
    confirmCurrentDate(){
      console.log(this.currentDate);
    },
    createDevidedSchedules() {
      this.$store.dispatch('schedules/createDevidedSchedulesAction')
    },
    showDevidedSchedule() {
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
    getCalendar() {
      let startDate = this.getStartDate();
      const endDate = this.getEndDate();
      const weekNumber = Math.ceil(endDate.diff(startDate, "days") / 7);

      let calendars = [];
      this.createDevidedSchedules();

      for (let week = 0; week < 1; week++) {
        let weekRow = [];
        for (let day = 0; day < moment(this.currentMonth).daysInMonth(); day++) {
          let scheduleNum = 0;
          for (let k=0; k < this.devidedSchedules.length; k++) {
          //todoListの情報をカレンダーパネルに追加
            if (this.devidedSchedules[k].date === startDate.get("date")&&this.devidedSchedules[k].commit===true) {
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
    scheduleNum() {
      return this.calendar.scheduleNum;
    },
    ...mapState('schedules',{
      schedules: 'schedules',
      devidedSchedules: 'devidedSchedules',
    }),
    ...mapState('date',{
      currentDate: 'currentDate',
      currentMonth: 'currentMonth',
      currentYear: 'currentYear'
    }),
  },
  created(){
    console.log(currentDate);
    // return this.createDevidedSchedules();
    // this.displayScheduleNum();
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
  margin-top:3%;
  margin-left: 10%;
  margin-right: 0.5%;
  /* position: fixed; */
  width:125%;
  /* z-index:1; */
  display: flex;
  flex-direction: column;
}

.calendar-header-area {
  height:200px;
}

.calendar-date{
  flex:1;
  min-height:125px;
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
