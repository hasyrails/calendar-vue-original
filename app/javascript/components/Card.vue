<template>
  <div class="card">
    <div class="card-main">
      <div class="card-icon" v-if="card.schedulized===true"><CalendarImport fillColor="#FFA500" :size="30"></CalendarImport></div>
      <div class="body" v-if="!cardBodyEditFlag" @click="cardBodyEdit">
        {{ card.body }}
      </div>
    </div>
    <div class="body" v-if="!cardBodyEditFlag&&card.body.length===0" @click="cardBodyEdit">
      <Pencil :size="40"></Pencil>
    </div>
    <div class="card-body-editng" v-if="cardBodyEditFlag">
      <form  class="body" @submit.prevent="updateCard" style="-moz-box-shadow: inset 0 0 4px rgba(0,0,0,0.2);
      -webkit-box-shadow: inset 0 0 4px rgba(0, 0, 0, 0.2);
      box-shadow: inner 0 0 4px rgba(150, 180, 200, 0.2);">
        <input v-model="card.body"
        type="text" 
        style="outline:blue;"></input>
      </form>
      <div @click="quitCardBodyEdit">
        <CloseCircle :size="30"></CloseCircle>
      </div>
    </div>
    <div class="card-handle-button" >
      <div class="show-detail-button" v-show="!cardBodyEditFlag">
        <Cog fillColor="grey" :size="30" @click="openCardSettingModal"></Cog>
      </div>
      <div class="close-button" @click="deleteCard" v-show="!cardBodyEditFlag">
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
    cardIndex: {
      type: Number,
      required: true
    }
  },
  components:{
    Cog,
    TrashCanOutline,
    CloseCircle,
    Pencil,
    CalendarImport,
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
