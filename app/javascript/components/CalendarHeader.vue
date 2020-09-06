<template>
  <div class="calendar-header">
    <div class="calendar-header-content flex">
      <ChevronLeft fillColor="white"  @click="prev" size="lg"></ChevronLeft>
      <div class="calendar-header-date">{{ currentDate }}</div>
      <ChevronRight fillColor="white" @click="next" size="lg"></ChevronRight>
    </div>
  </div>
</template>

<script>
import ChevronLeft from 'vue-material-design-icons/ChevronLeft.vue';
import ChevronRight from 'vue-material-design-icons/ChevronRight.vue';


export default {
  name: 'CalendarHeader',
  props:{
    currentDate: {
      type: String,
      required: true
    }
  },
  components:{
    ChevronLeft,
    ChevronRight
  },
  methods:{
    prev(){
      this.$emit('prev')
    },
    next(){
      this.$emit('next')
    }
  }
}
</script>

<style scoped>
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
