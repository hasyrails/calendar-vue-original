<template>
  <div class="card" :class="classCard"
  :style="'background-color:'+card.color+';'">
    <div class="card-main">
      <div class="card-icon" v-if="card.schedulized===true&&card.done===false"><CalendarImport fillColor="#FFA500" :size="30"></CalendarImport></div>
      <div class="card-icon" v-if="card.done===true"><Star fillColor="#FFA500" :size="30"></Star></div>
      <div class="body card-body" v-if="!cardBodyEditFlag" @click="cardBodyEdit">
        {{ card.body }}
      </div>
    </div>
    <div class="body card-body" v-if="!cardBodyEditFlag&&card.body.length===0" @click="cardBodyEdit">
      <Pencil :size="40"></Pencil>
    </div>
    <div class="card-body-editng" v-if="cardBodyEditFlag&&card.deadlined===false">
      <form  class="body" @submit.prevent="updateCard" style="-moz-box-shadow: inset 0 0 4px rgba(0,0,0,0.2);
      -webkit-box-shadow: inset 0 0 4px rgba(0, 0, 0, 0.2);
      box-shadow: inner 0 0 4px rgba(150, 180, 200, 0.2);">
        <input v-model="card.body"
        type="text"
        style="outline:blue;"
        class="card-body-form"
        ></input>
      </form>
      <div @click="quitCardBodyEdit">
        <CloseCircle :size="30"></CloseCircle>
      </div>
    </div>
    <div class="card-handle-button" >
      <div class="show-detail-button" v-show="!cardBodyEditFlag&&card.deadlined===false">
        <Cog fillColor="grey" :size="30" @click="openCardSettingModal"></Cog>
      </div>
      <div class="delete-card-button" @click="deleteCard" v-show="!cardBodyEditFlag&&card.deadlined===false">
        <TrashCanOutline fillColor="red" :size="30"></TrashCanOutline>
      </div>
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
    card: {
      type: Object,
      required: true
    },
    list_id: {
      type: Number,
      required: true
    },
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
    openCardSettingModal(body){
      this.$emit('clickCardSettingButton', this.body)
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
  height: 50px;
  width: 250px;
  cursor: pointer;
  display: flex;
  margin-top: 5px;
  margin-bottom: 5px;
}

.card-main{
  display: flex;
}

.card-icon{
  margin-top: 10px;
  margin-left: 15px;
}

.body {
  position: absolute;
  top: -10px;
  /* right: 5px; */
  font-size: 18px;
  margin-left:50px;
  width: 80%;
  word-wrap: break-word;
  margin-bottom :3%;
}

.card-body-form{
  position: absolute;
  top: 10px;
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
.show-detail-button{
  /* position: absolute; */
  position: relative;
  right: 40px;
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
.delete-card-button{
  /* position: absolute; */
  position: relative;
  bottom: 35px;
  right:3px;
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
