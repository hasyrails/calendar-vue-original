<template>
<div>
  <div class="card schedule-card"
  :style="'background-color:'+schedule.color+';'"
  :class="classButton" 
  :id="'schedule-card-'+schedule.id"
  >
    <div v-if="schedule.date_year===new Date().getFullYear()&&schedule.date_month===new Date().getMonth()+1&&schedule.date_day===new Date().getDate()&&schedule.end===formatDate(new Date())&&schedule.done===false">
      <CountDownTimer :schedule="schedule"></CountDownTimer>
    </div>
    

    <div class="body" style="display:flex; justify-content:center; padding-top:1px;font-size:20px;" @click="displayChange">
      <div class="schedule-done-icon" v-if="schedule.done">
        <CheckBold fillColor="orange" :size="30"></CheckBold>
      </div>
      <div class="schedule-title" style="margin-left:10px;margin-top:1px;">
        {{schedule.body}}
      </div>
    </div>
    <div class="card-handle-button"
    >
      <div @click="openScheduleSettingModal" v-if="!schedule.deadlined">
        <ScheduleSettingButton style="margin-left:1px;"></ScheduleSettingButton>
      </div>
      <!-- <div>
        <TrashCanOutline
        fillColor="red"
        :size="30"
        style="margin-left:10px;margin-bottom:40px;"
        @click="deleteSchedule"
        ></TrashCanOutline>
      </div> -->
    </div>
  </div>
</div>
</template>


<script>
import ScheduleSettingButton from '../components/ScheduleSettingButton'
import ScheduleDeleteButton from '../components/ScheduleDeleteButton'
import CountDownTimer from '../components/CountDownTimer'
import TrashCanOutline from 'vue-material-design-icons/TrashCanOutline.vue';
import CheckBold from 'vue-material-design-icons/CheckBold.vue';


export default {
  name: 'Schedule',
  data(){
    return{
      icon: 0,
      nonDisplay:false,
    }
  },
  props: {
    schedule:{
      type: Object,
    }
  },
  components:{
    ScheduleSettingButton,
    ScheduleDeleteButton,
    TrashCanOutline,
    CheckBold,
    CountDownTimer,
  },
  methods: {
    deleteSchedule(){
      if(confirm('本当にこのスケジュールカードを削除しますか？')) {
        this.$store.dispatch('schedules/deleteScheduleAction', this.schedule)
        this.$router.go({path: this.$router.currentRoute.path, force: true})
      }
    },
    displayChange(){
      this.nonDisplay = !this.nonDisplay;
      this.commitChange();
      this.$emit('commitChange', this.schedule)
    },
    commitChange(){
      this.schedule.commit = !this.schedule.commit
    },
    openScheduleSettingModal(schedule){
      this.$emit('clickScheduleSettingButton', this.schedule)
    },
    formatDate(dt) {
      var y = dt.getFullYear();
      var m = ('00' + (dt.getMonth()+1)).slice(-2);
      var d = ('00' + dt.getDate()).slice(-2);
      return (y + '-' + m + '-' + d);
    }
  },
  computed:{
    classButton() {
      const classButton = []

      if (this.schedule.done===false&&this.schedule.commit===false&&schedule.deadlined===false) {
        classButton.push('nonDisplay')
      }
      if (this.schedule.done===true) {
        classButton.push('finishedSchedule')
      }
      if (this.schedule.deadlined===true) {
        classButton.push('deadlinedSchedule')
      }
      return classButton
    },
    displayNum(){
      return this.displayNum
    }
  }
}
</script>

<style scoped>
.nonDisplay{
  /* visibility:hidden */
  outline: dashed thin;
  background-color :white;
  color:white;
  opacity:0.3;
}
.finishedSchedule{
  /* visibility:hidden */
  /* background-color :#FFDBC9; */
  color:black;
  opacity:0.8;
}
.deadlinedSchedule{
  /* visibility:hidden */
  /* background-color :#FFDBC9; */
  color:black;
  opacity:0.3;
}

.card {
  height: 80px;
  width: 250px;
  cursor: pointer;
  display: flex;
}

.body {
  position: absolute;
  top: 20px;
  right: 10px;
  font-size: 18px;
  width: 90%;
  word-wrap: break-word;
  margin-bottom :3%;
}

.card-body-editing{
  display: flex;
}

.card-handle-button{
  position: absolute;
  top: 1px;
  right: 10px;
  cursor: pointer;
  border-radius: 8px;
  color: white;
  width: 10%;
}

.schedule-done-icon{
  position: absolute;
  top: 1px;
  left: 10px;
}

</style>

