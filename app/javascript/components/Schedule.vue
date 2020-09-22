<template>
<div>
  <div class="card schedule-card"
  :style="'background-color:'+devidedSchedule.color+';'"
  :class="classButton" 
  :id="'schedule-card-'+devidedSchedule.id"
  >
    <div class="schedule-handle-button">
      <div @click="openScheduleSettingModal">
        <ScheduleSettingButton style="margin-left:10px;"></ScheduleSettingButton>
      </div>
      <!-- <div>
        <ScheduleDeleteButton style="margin-left:10px;"></ScheduleDeleteButton>
      </div> -->
    </div>
    
    <div class="body" style="display:flex; justify-content:center; padding-top:1px;font-size:20px;" @click="displayChange">
      <div class="schedule-title" style="margin-left:10px;margin-top:1px;">
        {{devidedSchedule.title}}
      </div>
    </div>
  </div>
  <!-- <div>
    <ScheduleSettingModal
    v-if="scheduleSettingModalFlag"></ScheduleSettingModal>
  </div> -->
</div>
</template>


<script>
import ScheduleSettingButton from '../components/ScheduleSettingButton'
import ScheduleDeleteButton from '../components/ScheduleDeleteButton'

// import ScheduleSettingModal from '../components/ScheduleSettingModal';

export default {
  name: 'Schedule',
  data(){
    return{
      // scheduleSettingModalFlag: false,
      // devidedSchedule: {},
      displayNum: '',
      icon: 0,
      nonDisplay:false
    }
  },
  props: {
    devidedSchedule:{
      type: Object,
    }
  },
  components:{
    ScheduleSettingButton,
    ScheduleDeleteButton,
    // ScheduleSettingModal
  },
  methods: {
  //   iconChange(){
  //     if(this.icon <6){
  //       this.icon = this.icon + 1;
  //     }else{
  //       this.iconReset()
  //     }
  //   },
  //   iconReset(){
  //     this.icon = 0
  //   }
  // }
    displayChange(){
      this.nonDisplay = !this.nonDisplay;
      this.commitChange();
      this.$emit('commitChange')
    },
    commitChange(){
      // this.devidedSchedule.commit = !this.devidedSchedule.commit
    },
    openScheduleSettingModal(devidedSchedule){
      // this.scheduleSettingModalFlag = true
      this.$emit('clickScheduleSettingButton', this.devidedSchedule)
      // this.$emit('clickScheduleSettingButton', devidedSchedule)
    },
  },
  computed:{
    classButton() {
      const classButton = ['tryButton']

      if (this.nonDisplay) {
        classButton.push('nonDisplay')
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

.card {
  margin-top: 10px;
  margin-bottom: 10px;
  position: relative;
  display: flex;
  padding: 30px 15px 40px;
  background-color: #fff;
  border-radius: 8px;
  height: 30px;
  width: 270px;
  z-index:1;
}

.schedule-title{
  cursor: pointer;
}

/* .schedule-handle-button{
  display: flex;
} */

.show-detail-button {
  position: absolute;
  top: 6px;
  right: 10px;
  /* font-size: 22px; */
  cursor: pointer;
  border-radius: 8px;
  /* border-color: red; */
  /* border-style: solid; */
  /* background-color: red; */
  color: white;
  margin: 5px;
}

.body {
  font-size: 18px;
  width: 100%;
  word-wrap: break-word;
  margin-bottom :3%;
}
</style>
