<template>
<div class="user-info-graph">
  <div class="record">
    <div>{{ sixDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneCards">
      <WeightLifter size="100"></WeightLifter>
      {{ doneCard.body }}
      {{ doneCard.done_at }}
    </div>
  </div>
  
  <div class="record">
    <div>{{ fiveDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneCards">
      <WeightLifter size="100"></WeightLifter>
      {{ doneCard.body }}
      {{ doneCard.done_at }}
    </div>
  </div>
  
  <div class="record">
    <div>{{ fourDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneCards">
      <WeightLifter size="100"></WeightLifter>
      {{ doneCard.body }}
      {{ doneCard.done_at }}
    </div>
  </div>
  
  <div class="record">
    <div>{{ threeDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneCards">
      <WeightLifter size="100"></WeightLifter>
      {{ doneCard.body }}
      {{ doneCard.done_at }}
    </div>
  </div>
  
  <div class="record">
    <div>{{ twoDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneCards">
      <WeightLifter size="100"></WeightLifter>
      {{ doneCard.body }}
      {{ doneCard.done_at }}
    </div>
  </div>
  
  <div class="record">
    <div>{{ oneDaysAgoYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneAtOneDaysAgoCards">
      <WeightLifter size="100"></WeightLifter>
      {{ doneCard.body }}
      {{ doneCard.done_at }}
    </div>
  </div>
  
  <div class="record">
    <div>{{ currentYYMMDD }}</div>
    <div class="tumiage" v-for="doneCard in doneAtTodayCards">
      <WeightLifter size="100"></WeightLifter>
      {{ doneCard.body }}
      {{ doneCard.done_at }}
    </div>
  </div>

  <div @click="confirmCurrentHyphenedCurrentYYMMDD"><button>confirmCurrentHyphenedCurrentYYMMDD</button></div>
  
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
</style>
