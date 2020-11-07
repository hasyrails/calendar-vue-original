<template>
  <div class="calendar">
    <div>
      <CalendarHeader
      :currentDate="currentDate"
      @prev="prevMonth"
      @next="nextMonth"
      style="background-color:#8EB8FF;">
      </CalendarHeader>
    </div>
    <div 
    v-if="$store.state.auth.user.length===0&&$store.state.auth.headers.length===0"
    @click="loginInvitationMassage">
      <div
        v-for="(week, index) in calendars"
        class="week"
        :key="index"
      >
        <div
        class="calendar-date"
        v-for="(day, index) in week"
        :key="index"
        style="width:50px;"
        > 
          <div v-if="day.month===currentMonth" 
          class="day-current-month"
          >{{day.date}}</div>
          <div v-if="day.month!==currentMonth"
          class="day-other-month"
          >{{ day.date }}</div>
          <div v-if="day.date===new Date().getDate()&&day.month===new Date().getMonth()+1&&day.year===new Date().getFullYear()"
          class="today" style="position:relative;top:-30px;left:1px;">
          {{day.date}}</div>
            <div v-if="day.date===new Date().getDate()&&day.month===new Date().getMonth()+1&&day.year===new Date().getFullYear()&&day.scheduleNum!==0">
              <CountDownTimer></CountDownTimer>
            </div>
          <div style="margin-left:40px;width:50px;height:50px;border-radius:25px 25px 25px 25px;background-color:#2C7CFF;" v-if="day.scheduleNum!==0&&day.month===new Date().getMonth()+1&&day.year===new Date().getFullYear()" class="schedule-num-display">
            <div style="color:white; font-size:20px;margin-top:1px;margin-left:12px;">{{day.scheduleNum}}</div>
            <div style="margin-left:10px;"><CardBulletedOutline fillColor="grey" :size="100"></CardBulletedOutline></div>
          </div>
        </div>
      </div>
      <div class="message">{{message}}</div>
    </div>
    <div
    v-if="$store.state.auth.user.length===0&&$store.state.auth.headers.length!==0"
    @click="loginInvitationMassage">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        class="week" 
      >
        <div
        class="calendar-date"
        v-for="(day, index) in week"
        :key="index"
        style="width:150px;"
        > 
          <div v-if="day.month===currentMonth" 
          class="day-current-month"
          >{{day.date}}</div>
          <div v-if="day.month!==currentMonth"
          class="day-other-month">{{ day.date }}</div>
          <div v-if="day.date===new Date().getDate()&&day.month===new Date().getMonth()+1&&day.year===new Date().getFullYear()"
          class="today"
          style="position:relative;top:-30px;right:1px;"
          >
          {{day.date}}</div>
            <div v-if="day.date===new Date().getDate()&&day.month===new Date().getMonth()+1&&day.year===new Date().getFullYear()&&day.scheduleNum!==0">
              <CountDownTimer></CountDownTimer>
            </div>
          <div style="margin-left:40px;width:50px;height:50px;border-radius:25px 25px 25px 25px;background-color:#2C7CFF;" v-if="day.scheduleNum!==0&&day.month===new Date().getMonth()+1&&day.year===new Date().getFullYear()" class="schedule-num-display">
            <div style="color:white; font-size:35px;margin-top:1px;margin-left:12px;">{{day.scheduleNum}}</div>
            <div style="margin-left:10px;margin-top:30px;"><CardBulletedOutline fillColor="grey" :size="100"></CardBulletedOutline></div>
          </div>
        </div>
      </div>
      <div class="message">{{message}}</div>
    </div>
    <div 
    v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        class="week"
      >
        <div
        class="calendar-date"
        v-for="(day, index) in week"
        :key="index"
        style="width:150px;"
        > 
        <div style="display:flex;">
          <div v-if="day.month===currentMonth"
          class="day-current-month"
          >{{day.date}}</div>
          <div v-if="day.month!==currentMonth" 
          class="day-other-month"
          >{{ day.date }}</div>
          <div v-if="day.date===new Date().getDate()&&day.month===new Date().getMonth()+1&&day.year===new Date().getFullYear()"
          class="today"
          >
          {{day.date}}</div>
        </div>
          <div v-if="day.scheduleNum!==0&&day.month===new Date().getMonth()+1&&day.year===new Date().getFullYear()" class="schedule-num-display">
            <div style="color:white; font-size:15px;margin-top:0px;margin-left:6px;">{{day.scheduleNum}}</div>
            <div style="margin-left:10px;margin-top:5px;"><CardBulletedOutline fillColor="grey" :size="60"></CardBulletedOutline></div>
          <div v-if="day.date===new Date().getDate()&&day.month===new Date().getMonth()+1&&day.year===new Date().getFullYear()&&day.scheduleNum!==0" style="position:relative;top:3px;">
            <CountDownTimer></CountDownTimer>
          </div>
          </div>
        </div>
      </div>
    </div>
    <div 
    v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length===0"
    @click="loginInvitationMassage">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        class="week"
      >
        <div
        class="calendar-date"
        v-for="(day, index) in week"
        :key="index"
        style="width:150px;"
        > 
          <div 
          v-if="day.month===currentMonth"
          class="day-current-month"
          >
            {{day.date}}
          </div>
          <div v-if="day.month!==currentMonth"
          class="day-other-month"
          >
            {{ day.date }}
          </div>
          <div v-if="day.date===new Date().getDate()&&day.month===new Date().getMonth()+1&&day.year===new Date().getFullYear()"
          class="today"
          style="position:relative;top:-30px;right:1px;"
          >
          {{day.date}}</div>
        </div>
      </div>
    </div>
    <div class="message">{{message}}</div>
  </div>
</template>

<script>
import store from '../store'

import moment from "moment";
import draggable from 'vuedraggable'

import CardBulletedOutline from 'vue-material-design-icons/CardBulletedOutline.vue';
import Key from 'vue-material-design-icons/Key.vue';

import CalendarHeader from "../components/CalendarHeader";
import Schedule from "../components/Schedule"
import DatePicker from '../components/DatePicker'
import CountDownTimer from '../components/CountDownTimer'

import {mapState, mapGetters} from 'vuex'


export default {
  name: 'Calendar',
  data() {
    return {
      message: '',
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
    };
  },
  components: {
    draggable,
    CalendarHeader,
    Schedule,
    DatePicker,
    CardBulletedOutline,
    CountDownTimer,
    Key,
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
            if (this.$store.getters['schedules/schedules'][k].date_day === startDate.get("date")&&this.$store.getters['schedules/schedules'][k].date_month === this.currentMonth&&this.$store.getters['schedules/schedules'][k].date_year === this.currentYear&&this.$store.getters['schedules/schedules'][k].commit===true&&this.$store.getters['schedules/schedules'][k].deadlined===false&&this.$store.getters['schedules/schedules'][k].done===false&&this.$store.getters['schedules/schedules'][k].user_id===this.$store.state.auth.user.id) {
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
    loginInvitationMassage(){
      this.message = 'ユーザー登録・ログインするとカレンダーに予定の数が表示されます！'
      setTimeout(() => {
        this.message = ''
        }
      ,3000
      )
    }
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
    ...mapGetters('schedules',[
      'schedules'
    ])
  },
  created(){
    console.log(currentDate);
    return this.createDevidedSchedules();
  },
  mounted(){
    this.$store.dispatch('schedules/fetchSchedulesAction')
  },
  watch:{
  }
}
</script>

<style scoped>
.calendar {
  width:80%;
  margin-top:10%;
}

.calendar-header-area {
  height:100px;
}

.week{
  min-width:50px;
  border-top:5px #BAD3FF;background-color:#EEEEEE;
  display:flex;
  border-left:5px solid #BAD3FF;height:100px;
}

.day-current-month{
  font-size:20px;
  font-weight:100;
}

.day-other-month{
  color:#D3D3D3;
  font-size:20px;
  font-weight:300;
}

.today{
  color:red;
  font-size:20px;
  position:relative;
  /* top:-30px; */
  right:11px;
  font-weight:900;
}

.calendar-date{
  flex:1;
  min-height:50px;
  border-right:5px solid #BAD3FF;
  border-bottom:5px solid #BAD3FF;
  text-align: center;
  font-size:25px;
}

.schedule-num-display{
  display: flex;
  margin-left:40px;
  width:20px;
  height:20px;
  border-radius:10px 10px 10px 10px;
  background-color:#2C7CFF;
  position: relative;
  left: -10px;
  /* top: -35px; */
}

.message{
  z-index:100;
  position:fixed;
  top:50%;
  left:29%;
  font-size:20px;
  color:blue;
  font-weight:bold;
  background-color:#DDFFFF;
}


/* .calendar-date:hover {
  background-color: silver;
  border-radius: 4px;
} */

</style>
  