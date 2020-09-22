<template>
  <div class="card">
    <div class="body">
      {{ body }}
    </div>
    <div class="card-handle-button">
      <div class="show-detail-button">
        <Cog fillColor="grey" :size="30"></Cog>
      </div>
      <div class="close-button" @click="removeCardFromList">
        <Close fillColor="red" :size="30"></Close>
      </div>
    </div>
  </div>
</template>

<script>
import Cog from 'vue-material-design-icons/Cog.vue';
import Close from 'vue-material-design-icons/Close.vue';

export default {
  props: {
    body: {
      type: String,
      required: true
    },
    listIndex: {
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
    Close
  },
  methods: {
    removeCardFromList() {
      if(confirm('本当にこのカードを削除しますか？')) {
        this.$store.dispatch('lists/removeCardFromList', { cardIndex: this.cardIndex, listIndex: this.listIndex })
      }
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

.body {
  position: absolute;
  top: 15px;
  right: 10px;
  font-size: 18px;
  width: 90%;
  word-wrap: break-word;
  margin-bottom :3%;
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
