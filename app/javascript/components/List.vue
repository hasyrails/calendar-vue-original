<template>
  <div class="list">
    <div class="listheader">
      <div class="list-title">{{ title }}</div>
       <!-- <div class="list-counter">total: {{ totalCardInList }}</div> -->
      <div class="deletelist" @click="removeList">×</div>
    </div>
    <div class="cards-area">
      <div>
        <CardAdd :listIndex="listIndex"></CardAdd>
      </div>
      <draggable
        :options="options"
        :list="cards"
        @sort="$emit('change')">
        <Card v-for="(item, index) in cards"
              :body="item.body"
              :key="item.id"
              :cardIndex="index"
              :listIndex="listIndex"
        ></Card>
      </draggable>
    </div>
  </div>
</template>

<script>
import CardAdd from '../components/CardAdd'
import Card from '../components/Card'
import draggable from "vuedraggable";

export default {
  data(){
    return{
      options: {
        group: {
          name: 'myGroup',
          pull: 'clone',
          put: 'clone'
        },
        animation: 200
      },
    }
  },
  props: {
    title: {
      type: String,
      required: true
    },
    cards: {
      type: Array,
      required: true
    },
    listIndex: {
      type: Number,
      required: true
    }
  },
  computed: {
    // totalCardInList() {
    //   return this.cards.length
    // }
  },
  components:{
    CardAdd,
    Card,
    draggable
  },
  methods: {
    removeList: function() {
      if(confirm('本当にこのリストを削除しますか？')){
        this.$store.dispatch('removelist', { listIndex: this.listIndex })
      }
    },
  }
}
</script>

<style scoped>
.list-counter {
  color: rgb(0, 140, 255);
  padding: 15px;
  margin-right: 10px;
  margin-top: 10px;
}

.list {
  margin: 0 10px auto;
  margin-bottom: 10px;
  margin-top: 10px;
  position: relative;
  display: inline-block;
  flex-direction: column;
  align-items: flex-start;
  min-width: 290px;
  width: 290px;
  background-color: #D7EEFF;
  border-radius: 8px;
  padding: 15px;
  border: solid #D9E5FF	1px;
  color: gray;
  vertical-align: top;
  z-index:2;
}

.listheader {
  width: 290px;
  display: inline-flex;
  justify-content: center;
}

.list-title {
  background: linear-gradient(transparent 70%, #ff99ab 70%);
  font-size: 25px;
  font-weight: bold;
  padding: 15px;
  margin-bottom: 10px;
}

.deletelist {
  position: absolute;
  top: 6px;
  right: 14px;
  font-size: 28px;
}

</style>
