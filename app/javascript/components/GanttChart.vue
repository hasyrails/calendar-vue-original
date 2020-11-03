<template>
  <div class="calendar">
    <div class="calendar-header-area">
      <GanttChartHeader
      :currentDate="currentDate"
      @prev="prevMonth"
      @next="nextMonth"
      @showDatePicker="$listeners['showDatePicker']"
      @showDoneSchedules="$listeners['showDoneSchedules']"
      style="background-color:#8EB8FF;height:200px;">
      </GanttChartHeader>
    </div>
    <div class="calendar-date-parts">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        class="week"
      >
        <div
        class="calendar-date"
        v-for="(day, index) in week"
        :key="index"
        :id="day.year+'-'+day.month+'-'+day.date"
        >
          <div v-if="day.month===currentMonth" class="current-month-dates">{{day.date}}</div>
          <div v-if="day.month!==currentMonth&&day.date!==new Date().getDate()" style="color:#D3D3D3;font-size:30px;">{{ day.date }}</div>
        <draggable
        v-model="schedule"
       >
          <Schedule 
          :schedule="schedule"
          v-for="schedule in ownSchedules"
          v-if="
          schedule.date_day === day.date
          &&schedule.date_month === day.month
          &&schedule.date_year === day.year&&schedule.done===false&&$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0"
          :key="schedule.id"
          class="schedule"
          @clickScheduleSettingButton="openScheduleSettingModal(schedule)"
          @commitChange="commitChange(schedule)"
          >
          </Schedule>
          <SampleSchedule 
          :sampleSchedule="sampleSchedule"
          v-for="sampleSchedule in sampleSchedules"
          v-if="
          sampleSchedule.date_day===day.date
          &&sampleSchedule.date_month === day.month
          &&sampleSchedule.date_year === day.year&&$store.state.auth.user.length!==0&&$store.state.auth.headers.length===0"
          :key="sampleSchedule.id"
          class="schedule"
          @clickSampleScheduleSettingButton="openSampleScheduleSettingModal(sampleSchedule)"
          @commitChange="commitChange(sampleSchedule)"
          >
          </SampleSchedule>
        </draggable>
      </div>
    </div>
  </div>
  <div>
    <ScheduleSettingModal
    :schedule="scheduleDetail"
    v-if="scheduleSettingModalFlag"
    @clickCloseButton="closeScheduleSettingModal"
    @clickScheduleEditButton="openScheduleEditModal(scheduleDetail)"
    @updateSchedule="updateSchedule(scheduleDetail)"
    @completeSchedule="completeSchedule(scheduleDetail)"
    @clickScheduleSettingModalCloseButton="closeScheduleSettingModal"
    ></ScheduleSettingModal>
    <SampleScheduleSettingModal
    :sampleSchedule="sampleScheduleDetail"
    v-if="sampleScheduleSettingModalFlag"
    @clickCloseButton="closeScheduleSettingModal"
    @clickSampleScheduleSettingModalCloseButton="closeSampleScheduleSettingModal"
    ></SampleScheduleSettingModal>
  </div>
  <!-- <div class="form-group">
    <label for="title">{{hoge}}</label>
    <input
    v-model="hoge"
    type="text"
    class="form-control"
    >
  </div> -->
  <!-- <div style="margin-top:1%;">
    <button class="btn btn-primary btn-lg" @click="confirmCurrentDate">CofirmCurrentDate</button>
    <button class="btn btn-primary btn-lg" @click="confirmCalendar">CofirmCalendar</button>
    <button class="btn btn-primary btn-lg" @click="confirmCurrentMonth">CofirmCurrentMonth</button>
    <button class="btn btn-primary btn-lg" @click="showDevidedSchedule">showDevidedSchedule</button>
    <button class="btn btn-primary btn-lg" @click="confirmStartDate">confirmStartDate</button>
    <button class="btn btn-primary btn-lg" @click="openScheduleSettingModal">setting</button>
    <button  class="btn btn-primary btn-lg" @click="confirmIdToMoent">Id to Moment</button>
    <button  class="btn btn-primary btn-lg" @click="confirmSchedules">confirmSchedules</button>
    <button  class="btn btn-primary btn-lg" @click="confirmMoment">confirmSchedules</button>
  </div> -->
</div>
</template>

<script>
import moment from "moment";
import axios from 'axios';
import draggable from 'vuedraggable'

import GanttChartHeader from "../components/GanttChartHeader";
import Schedule from "../components/Schedule"
import SampleSchedule from "../components/SampleSchedule"
import { mapState, mapGetters } from 'vuex'
import ScheduleSettingModal from "../components/ScheduleSettingModal"
import SampleScheduleSettingModal from "../components/SampleScheduleSettingModal"
import ScheduleEditModal from "../components/ScheduleEditModal"

export default {
  name: 'Calendar',
  data() {
    return {
      currentDate: moment().format('YYYY/MM'),
      currentMonth: moment().month()+1,
      currentYear: moment().year(),
      scheduleSettingModalFlag: false,
      sampleScheduleSettingModalFlag: false,
      scheduleEditModalFlag: false,
      options: {
        group: {
          name: 'myGroup',
          filter: '.schedule-card',
        },
        animation: 200
      },
    };
  },
  components: {
    draggable,
    GanttChartHeader,
    Schedule,
    SampleSchedule,
    ScheduleSettingModal,
    SampleScheduleSettingModal,
    ScheduleEditModal,
  },
  mounted () {
    this.$store.dispatch('schedules/fetchSchedulesAction')
  },
  methods: {
    confirmSchedules(){
      console.log(this.schedules)
    },
    scheduleEditFormInputting(content){
       this.schedule = this.content
    },
    confirmIdToMoent(){
      console.log(moment('2020-09-01').month())
    },
    openScheduleSettingModal(schedule){
      this.scheduleSettingModalFlag = true
      this.scheduleDetail = schedule
    },
    openSampleScheduleSettingModal(schedule){
      this.sampleScheduleSettingModalFlag = true
      this.sampleScheduleDetail = schedule
    },
    closeScheduleSettingModal(){
      this.scheduleSettingModalFlag = false
    },
    closeSampleScheduleSettingModal(){
      this.sampleScheduleSettingModalFlag = false
    },
    openScheduleEditModal(schedule){
      this.closeScheduleSettingModal()
      this.scheduleEditModalFlag = true
      this.editSchedule = schedule
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
      this.$store.dispatch('schedules/updateScheduleAction', schedule)
    },
    completeSchedule(schedule){
      this.$store.dispatch('schedules/completeScheduleAction', schedule)
    },
    commitChange(schedule){
      this.$store.dispatch('schedules/updateScheduleAction', schedule)
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
      this.$store.dispatch('devidedschedules/createDevidedSchedulesAction')
      console.log(this.devidedschedules);
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
      console.log(new Date('2020-10-11').getFullYear())
    },
    getCalendar() {
      let startDate = this.getStartDate();
      const endDate = this.getEndDate();
      const weekNumber = Math.ceil(endDate.diff(startDate, "days") / 7);

      let calendars = [];

        let weekRow = [];
        for (let day = 0; day < 42; day++) {
          weekRow.push({
            year: startDate.get("year"),
            month: startDate.get("month")+1,
            date: startDate.get("date"),
          });
          startDate.add(1, "days");
        }
          calendars.push(weekRow);
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
    scheduleNum() {
      return this.calendar.scheduleNum;
    },
    ...mapState('schedules',{
      schedules: 'schedules',
    }),
    ...mapState('devidedschedules',{
      devidedschedules: 'devidedschedules',
    }),
    ...mapState('date',{
      currentDate: 'currentDate',
      currentMonth: 'currentMonth',
      currentYear: 'currentYear'
    }),
    ...mapGetters('schedules',[
      'schedules',
      'sampleSchedules'
    ]
    ),
    ownSchedules() {
       return this.$store.getters['schedules/schedules'].filter(schedule=>schedule.user_id===this.$store.state.auth.user.id)
    },
  },
  created(){
    this.$store.commit('devidedschedules/createDevidedSchedules')
  },
  watch:{
  }
}
</script>

<style scoped>
.calendar {
  margin-top:2%;
  margin-left: 20%;
  margin-right: 0.5%;
  /* position: fixed; */
  width:150%;
  /* z-index:1; */
  display: flex;
  flex-direction: column;
}

.calendar-header-area {
  height:100px;
}

.calendar-date-parts{
  min-width:100px;
  border-top:5px #BAD3FF;
  background-color:#EEEEEE;
}

.week{
  display:flex;
  border-left:5px solid #BAD3FF;
  height:300px;
}

.calendar-date{
  flex:1;
  min-height:50px;
  border-right:5px solid #BAD3FF;
  border-bottom:5px solid #BAD3FF;
  text-align: center;
  font-size:25px;
}

.current-month-dates{
  font-weight:200;
  font-size:30px;
}

.calendar-date:hover {
  background-color: silver;
  border-radius: 4px;
}

.schedule{
  flex:1;
  min-height:1px;
  min-width:1px;
  width:200px;
  max-width:200px;
  text-align: center;
  margin-bottom:5px;
}
</style>
