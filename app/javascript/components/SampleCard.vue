<template>
  <div class="card">
    <div class="card-main">
      <div class="card-icon" v-if="sampleCard.schedulized===true&&sampleCard.done===false"><CalendarImport fillColor="#FFA500" :size="30"></CalendarImport></div>
      <div class="card-icon" v-if="sampleCard.done===true"><Star fillColor="#FFA500" :size="30"></Star></div>
      <div class="body">
        {{ sampleCard.body }}
      </div>
    </div>
    <div class="card-handle-button" >
      <div class="show-sample-detail-button">
        <Cog fillColor="grey" :size="30" @click="openSampleCardSettingModal"></Cog>
      </div>
      <!-- <div class="close-button" @click="deleteCard">
        <TrashCanOutline fillColor="red" :size="30"></TrashCanOutline>
      </div> -->
    </div>
  </div>
</template>

<script>
import Cog from 'vue-material-design-icons/Cog.vue';
import TrashCanOutline from 'vue-material-design-icons/TrashCanOutline.vue';
import CloseCircle from 'vue-material-design-icons/CloseCircle.vue';
import Pencil from 'vue-material-design-icons/Pencil.vue';
import CalendarImport from 'vue-material-design-icons/CalendarImport.vue';
import Star from 'vue-material-design-icons/Star.vue';

export default {
  data(){
    return{
      cardBodyEditFlag: false
    }
  },
  props: {
    sampleCard: {
      type: Object,
      required: true
    },
    // list_id: {
    //   type: Number,
    //   required: true
    // },
    // cardIndex: {
    //   type: Number,
    //   required: true
    // }
  },
  computed:{
    classCard() {
      const classCard = []

      // if (this.schedule.done===false&&this.schedule.commit===false) {
      //   classCard.push('nonDisplay')
      // }
      // cardもscheduleのcomiit状態を連動させたい
      // if (this.schedule.done===false) {
      //   classCard.push('nonDisplay')
      // }
      if (this.card.done===true) {
        classCard.push('finishedToDo')
      }
      if (this.card.deadlined===true) {
        classCard.push('deadlinedCard')
      }
      return classCard
    },
  },
  components:{
    Cog,
    TrashCanOutline,
    CloseCircle,
    Pencil,
    CalendarImport,
    Star,
  },
  methods: {
    deleteCard(card) {
      if(confirm('本当にこのカードを削除しますか？')) {
        this.$store.dispatch('cards/deleteCardAction', this.card)
        this.$router.go({path: this.$router.currentRoute.path, force: true})
      }
    },
    openSampleCardSettingModal(body){
      this.$emit('clickSampleCardSettingButton', this.body)
    },
    cardBodyEdit(){
      this.cardBodyEditFlag = true
      console.log(this.list_id)
    },
    quitCardBodyEdit(){
      this.cardBodyEditFlag = false
    },
    updateCard(){
      this.$emit('cardBodyFormComplete', this.card)
    }
  },
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
.finishedToDo{
  /* visibility:hidden */
  /* background-color :#FFDBC9; */
  color:black;
  opacity:0.8;
}
.deadlinedCard{
  /* visibility:hidden */
  /* background-color :#FFDBC9; */
  color:black;
  opacity:0.3;
}


.card {
  height: 70px;
  width: 250px;
  cursor: pointer;
  display: flex;
}

.card-main{
  display: flex;
}

.card-icon{
  margin-top: 15px;
  margin-left: 15px;
}

.body {
  position: absolute;
  top: 15px;
  /* right: 5px; */
  font-size: 18px;
  margin-left:50px;
  width: 80%;
  word-wrap: break-word;
  margin-bottom :3%;
}

.card-body-editing{
  display: flex;
}

.card-handle-button{
  position: absolute;
  top: 3px;
  right: 3px;
  /* font-size: 22px; */
  cursor: pointer;
  border-radius: 8px;
  /* border-color: red; */
  /* border-style: solid; */
  /* background-color: red; */
  color: white;
  margin: 5px;
  width: 10%;
}
</style>
