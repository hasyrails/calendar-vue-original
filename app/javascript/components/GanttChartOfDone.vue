<template>
  <div class="calendar">
    <div class="calendar-header-area">
      <GanttChartOfDoneHeader
      :currentDate="currentDate"
      @prev="prevMonth"
      @next="nextMonth"
      @showDatePicker="$listeners['showDatePicker']"
      @showSchedules="$listeners['showSchedules']"
      style="background-color:#FFCC99;height:200px;">
      </GanttChartOfDoneHeader>
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
          v-for="schedule in ownSchedulesOfDone"
          v-if="
          schedule.date_day === day.date
          &&schedule.date_month === day.month
          &&schedule.date_year === day.year&&schedule.done===true
          "
          :key="schedule.id"
          class="purun schedule"
          @clickScheduleSettingButton="openScheduleSettingModal"
          @commitChange="commitChange(schedule)"
          >
          </Schedule>
        </draggable>
      </div>
    </div>
  </div>
  <div>
    <ScheduleOfDoneSettingModal
    :schedule="scheduleDetail"
    v-if="scheduleSettingModalFlag"
    @clickCloseButton="closeScheduleSettingModal"
    @clickScheduleEditButton="openScheduleEditModal(scheduleDetail)"
    @updateSchedule="updateSchedule(scheduleDetail)"
    @completeSchedule="completeSchedule(scheduleDetail)"
    @clickScheduleSettingModalCloseButton="closeScheduleSettingModal"
    ></ScheduleOfDoneSettingModal>
  </div>
  <div>
    <ScheduleEditModal
    v-if="scheduleEditModalFlag"
    :schedule="editSchedule"
    @clickScheduleUpdateButton="updateSchedule"
    @clickScheduleEditModalCloseButton="closeScheduleEditModal"
    @formValueInputting="scheduleEditFormInputting"
    >
    </ScheduleEditModal>
  </div>
</div>
</template>

<script>
import moment from "moment";
import axios from 'axios';
import draggable from 'vuedraggable'

import GanttChartOfDoneHeader from "../components/GanttChartOfDoneHeader";
import Schedule from "../components/Schedule"
import { mapState, mapGetters } from 'vuex'
import ScheduleOfDoneSettingModal from "../components/ScheduleOfDoneSettingModal"
import ScheduleEditModal from "../components/ScheduleEditModal"

export default {
  name: 'Calendar',
  data() {
    return {
      currentDate: moment().format('YYYY/MM'),
      currentMonth: moment().month()+1,
      currentYear: moment().year(),
      scheduleSettingModalFlag: false,
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
    GanttChartOfDoneHeader,
    Schedule,
    ScheduleOfDoneSettingModal,
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
      'schedules'
    ]
    ),
    ownSchedulesOfDone() {
       return this.$store.getters['schedules/schedules'].filter(schedule=>schedule.user_id===this.$store.state.auth.user.id&&schedule.done)
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
  width:150%;
  display: flex;
  flex-direction: column;
}

.calendar-header-area {
  height:100px;
}

.calendar-date-parts{
  min-width:100px;
  border-top:5px #FFDBC9;
  background-color:#EEEEEE;
}

.week{
  display:flex;
  border-left:5px solid #FFDBC9;
  height:290px;
}

.calendar-date{
  flex:1;
  min-height:50px;
  border-right:5px solid  #FFDBC9;
  border-bottom:5px solid  #FFDBC9;
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
