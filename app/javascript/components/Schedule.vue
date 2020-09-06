<template>
  <div class="card" 
  style="flex:1;min-height:10px;width:300px;height:50px;text-align: center;margin-left:15px;"
  :style="'background-color:'+devidedSchedule.color+';'"
  @click="iconChange"
  >
    <div class="card-body" style="display:flex; justify-content:center; padding-top:2px;font-size:20px;">
      <div>
        <p v-if="icon===1"><font-awesome-icon icon="coffee"  size="sm" /></p>
        <p v-else-if="icon===2"><font-awesome-icon icon="credit-card"  size="sm" /></p>
        <p v-else-if="icon===3"><font-awesome-icon icon="birthday-cake" size="sm"/></p>
        <p v-else-if="icon===4"><font-awesome-icon icon="cut" size="sm"/></p>
        <p v-else-if="icon===5"><font-awesome-icon icon="envelope" size="sm"/></p>
        <p v-else></p>
      </div>
      <div class="schedule-title" style="margin-left:10px;">
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
      icon: 0
    }
  },
  props: {
    devidedSchedule:{
      type: Object
    }
  },
  methods: {
    iconChange(){
      if(this.icon <6){
        this.icon = this.icon + 1;
      }else{
        this.iconReset()
      }
    },
    iconReset(){
      this.icon = 0
    }
  }
}
</script>

<style scoped>

</style>
