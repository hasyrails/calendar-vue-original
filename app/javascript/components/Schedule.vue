<template>
  <!-- <div class="card"
  style="flex:1;min-height:10px;width:300px;height:30px;text-align: center;margin-left:15px;"
  :style="'background-color:'+devidedSchedule.color+';'"
  :class="classButton" @click="displayChange"
  > -->
  <!-- <div 
  style="flex:1;min-height:10px;width:20px;height:20px;text-align: center;margin-left:30px;border-radius: 10px 10px 10px 10px"
  :style="'background-color:'+devidedSchedule.color+';'"
  @click="iconChange"
  > -->
    <!-- <div class="card-body" style="display:flex; justify-content:center; padding-top:2px;font-size:20px;"> -->
      <!-- <div class="schedule-title" style="margin-left:10px;"> -->
        <!-- {{devidedSchedule.title}} -->
      <!-- </div> -->
    <!-- </div> -->
    <!-- <div> -->
      <!-- <div ><button>Vanish?</button></div> -->
    <!-- </div> -->
  <!-- </div> -->

  <div class="card"
  :style="'background-color:'+devidedSchedule.color+';'"
  :class="classButton" @click="displayChange"
  >
    <button class="close-button">
      ?
    </button>
    <div class="body" style="display:flex; justify-content:center; padding-top:1px;font-size:20px;">
      <div class="schedule-title" style="margin-left:10px;margin-top:1px;">
        {{devidedSchedule.title}}
      </div>
    </div>
  </div>
</template>


<script>
export default {
  name: 'Schedule',
  data(){
    return{
      icon: 0,
      nonDisplay:false
    }
  },
  props: {
    devidedSchedule:{
      type: Object
    }
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
      this.nonDisplay = !this.nonDisplay
    }
  },
  computed:{
    classButton() {
      const classButton = ['tryButton']

      if (this.nonDisplay) {
        classButton.push('nonDisplay')
      }
      return classButton
    },
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
  width: 230px;
  cursor: pointer;
}

.close-button {
  position: absolute;
  top: 6px;
  right: 15px;
  font-size: 22px;
  cursor: pointer;
  border-radius: 8px;
  border-color: red;
  border-style: solid;
  background-color: red;
  color: white;
  margin: 5px;
}

.body {
  font-size: 18px;
  width: 100%;
  word-wrap: break-word;
}
</style>
