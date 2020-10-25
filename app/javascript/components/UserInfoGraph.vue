<template>
<div class="user-info-graph">
  <div class="record">
    <div class="record-date">{{ sixDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneAtSixDaysAgoCards">
      <div><WeightLifter :size="60" fillColor="orange"></WeightLifter></div>
      <div class="done-card-body">{{ doneCard.body }}</div>
    </div>
  </div>
  
  <div class="record">
    <div class="record-date">{{ fiveDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneAtFiveDaysAgoCards">
      <div><WeightLifter :size="60" fillColor="orange"></WeightLifter></div>
      <div class="done-card-body">{{ doneCard.body }}</div>
    </div>
  </div>
  
  <div class="record">
    <div class="record-date">{{ fourDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneAtFourDaysAgoCards">
      <div><WeightLifter :size="60" fillColor="orange"></WeightLifter></div>
      <div class="done-card-body">{{ doneCard.body }}</div>
    </div>
  </div>
  
  <div class="record">
    <div class="record-date">{{ threeDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneAtThreeDaysAgoCards">
      <div><WeightLifter :size="60" fillColor="orange"></WeightLifter></div>
      <div class="done-card-body">{{ doneCard.body }}</div>
    </div>
  </div>
  
  <div class="record">
    <div class="record-date">{{ twoDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneAtTwoDaysAgoCards">
      <div><WeightLifter :size="60" fillColor="orange"></WeightLifter></div>
      <div class="done-card-body">{{ doneCard.body }}</div>
    </div>
  </div>
  
  <div class="record">
    <div class="record-date">{{ oneDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneAtOneDaysAgoCards">
      <div><WeightLifter :size="60" fillColor="orange"></WeightLifter></div>
      <div class="done-card-body">{{ doneCard.body }}</div>
    </div>
  </div>
  
  <div class="record">
    <div class="record-date">{{ currentYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneAtTodayCards">
      <div><WeightLifter :size="60" fillColor="orange"></WeightLifter></div>
      <div class="done-card-body">{{ doneCard.body }}</div>
    </div>
  </div>

</div>
</template>

<script>
import WeightLifter from 'vue-material-design-icons/WeightLifter.vue';
import moment from "moment";

export default{
  data(){
    return{
      now: new Date(),
      sixDaysAgoYYMMDD: moment().subtract(6,"days").format('YYYY/MM/DD'),
      hyphenedSixDaysAgoYYMMDD: moment().subtract(6,"days").format('YYYY-MM-DD'),
      fiveDaysAgoYYMMDD: moment().subtract(5,"days").format('YYYY/MM/DD'),
      hyphenedFiveDaysAgoYYMMDD: moment().subtract(5,"days").format('YYYY-MM-DD'),
      fourDaysAgoYYMMDD: moment().subtract(4,"days").format('YYYY/MM/DD'),
      hyphenedFourDaysAgoYYMMDD: moment().subtract(4,"days").format('YYYY-MM-DD'),
      threeDaysAgoYYMMDD: moment().subtract(3,"days").format('YYYY/MM/DD'),
      hyphenedThreeDaysAgoYYMMDD: moment().subtract(3,"days").format('YYYY-MM-DD'),
      twoDaysAgoYYMMDD: moment().subtract(2,"days").format('YYYY/MM/DD'),
      hyphenedTwoDaysAgoYYMMDD: moment().subtract(2,"days").format('YYYY-MM-DD'),
      oneDaysAgoYYMMDD: moment().subtract(1,"days").format('YYYY/MM/DD'),
      hyphenedOneDaysAgoYYMMDD: moment().subtract(1,"days").format('YYYY-MM-DD'),
      currentYYMMDD: moment().format('YYYY/MM/DD'),
      hyphenedCurrentYYMMDD: moment().format('YYYY-MM-DD'),
    }
  },
  components:{
    WeightLifter
  },
  methods:{
    confirmCurrentHyphenedCurrentYYMMDD(){
      console.log(this.hyphenedCurrentYYMMDD)
    }
  },
  computed:{
    doneAtTodayCards() {
       return this.$store.getters['cards/doneCards'].filter(card=>card.done_at===this.hyphenedCurrentYYMMDD)
    },
    doneAtOneDaysAgoCards() {
       return this.$store.getters['cards/doneCards'].filter(card=>card.done_at===this.hyphenedOneDaysAgoYYMMDD)
    },
    doneAtTwoDaysAgoCards() {
       return this.$store.getters['cards/doneCards'].filter(card=>card.done_at===this.hyphenedTwoDaysAgoYYMMDD)
    },
    doneAtThreeDaysAgoCards() {
       return this.$store.getters['cards/doneCards'].filter(card=>card.done_at===this.hyphenedThreeDaysAgoYYMMDD)
    },
    doneAtFourDaysAgoCards() {
       return this.$store.getters['cards/doneCards'].filter(card=>card.done_at===this.hyphenedFourDaysAgoYYMMDD)
    },
    doneAtFiveDaysAgoCards() {
       return this.$store.getters['cards/doneCards'].filter(card=>card.done_at===this.hyphenedFiveDaysAgoYYMMDD)
    },
    doneAtSixDaysAgoCards() {
       return this.$store.getters['cards/doneCards'].filter(card=>card.done_at===this.hyphenedSixDaysAgoYYMMDD)
    },
  },
}
</script>

<style scoped>
.user-info-graph{
  width: 100vw;
  height: 50vh;
}

.record{
  margin-left: 20%;
  display: flex;
}
.record-date{
  margin-top: 1%;
}
.tumiage{
  margin-top: 1%;
  margin-left: 1%;
}
.done-card-body{
  font-size: 20px;
}
</style>
