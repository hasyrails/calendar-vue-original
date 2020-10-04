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
    <div style="min-width:100px;border-top:5px #BAD3FF;background-color:#EEEEEE;">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        style="display:flex;border-left:5px solid #BAD3FF;height:700px;"
      >
        <div
        class="calendar-date"
        v-for="(day, index) in week"
        :key="index"
        :id="day.year+'-'+day.month+'-'+day.date"
        >
        <div v-if="day.month===currentMonth" style="font-weight:200;font-size:50px;">{{day.date}}</div>
        <div v-if="day.month!==currentMonth" style="color:#D3D3D3;font-size:50px;">{{ day.date }}</div>
        <draggable
        v-model="schedule"
       >
          <Schedule 
          :schedule="schedule"
          v-for="schedule in schedules"
          v-if="
          new Date(schedule.start).getDate() <= day.date
          &&new Date(schedule.end).getDate() >= day.date
          &&new Date(schedule.start).getMonth()+1 === day.month
          "
          :key="schedule.id"
          style="flex:1;min-height:1px;min-width:1px;max-width:230px;text-align: center;margin-bottom:10px;"
          @clickScheduleSettingButton="openScheduleSettingModal"
          >
          </Schedule>
          <DevidedSchedule 
          v-for="devidedschedule in devidedschedules"
          :key="devidedschedule.id"
          v-if="devidedschedule.date===day.date&&devidedschedule.month===day.month&&devidedschedule.year===day.year"
          :devidedschedule="devidedschedule"
          >
          </DevidedSchedule>
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
    @clickScheduleSettingModalCloseButton="closeScheduleSettingModal"
    ></ScheduleSettingModal>
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
  <!-- <div class="form-group">
    <label for="title">{{hoge}}</label>
    <input
    v-model="hoge"
    type="text"
    class="form-control"
    >
  </div> -->
  <div>
    <button class="btn btn-primary" @click="confirmCurrentDate">CofirmCurrentDate</button>
    <button class="btn btn-primary" @click="confirmCalendar">CofirmCalendar</button>
    <button class="btn btn-primary" @click="confirmCurrentMonth">CofirmCurrentMonth</button>
    <button class="btn btn-primary" @click="showDevidedSchedule">showDevidedSchedule</button>
    <button class="btn btn-primary" @click="confirmStartDate">confirmStartDate</button>
    <button class="btn btn-primary" @click="openScheduleSettingModal">setting</button>
    <button  class="btn btn-primary" @click="confirmIdToMoent">Id to Moment</button>
    <button  class="btn btn-primary" @click="confirmSchedules">confirmSchedules</button>
    <button  class="btn btn-primary" @click="confirmMoment">confirmSchedules</button>
  </div>
</div>
</template>

<script>
import moment from "moment";
import axios from 'axios';
import draggable from 'vuedraggable'

import GanttChartHeader from "../components/GanttChartHeader";
import Schedule from "../components/Schedule"
// import DevidedSchedule from "../components/DevidedSchedule"
import { mapState, mapGetters } from 'vuex'
import ScheduleSettingModal from "../components/ScheduleSettingModal"
import ScheduleEditModal from "../components/ScheduleEditModal"

export default {
  name: 'Calendar',
  data() {
    return {
      // count: 0,
      // hoge: '',
      currentDate: moment().format('YYYY/MM'),
      currentMonth: moment().month()+1,
      currentYear: moment().year(),
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
    };
  },
  components: {
    draggable,
    GanttChartHeader,
    Schedule,
    // DevidedSchedule,
    ScheduleSettingModal,
    ScheduleEditModal,
  },
  mounted () {
    this.$store.dispatch('schedules/fetchSchedulesAction')
    // this.$store.commit('devidedschedules/createDevidedSchedules')
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
      this.$store.dispatch('devidedschedules/createDevidedSchedulesAction')
    },
    commitChange(){
      // let selectedCardId = Number(event.currentTarget.id.substr(14));
      // this.devidedSchedules[selectedCardId].commit = !this.devidedSchedules[selectedCardId].commit;
      // return this.devidedSchedules;
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

      // for (let week = 0; week < 1; week++) {
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
      // }
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
  },
  created(){
    // return this.createDevidedSchedules();
    // this.displayScheduleNum();
    this.$store.commit('devidedschedules/createDevidedSchedules')
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
  width:170%;
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
