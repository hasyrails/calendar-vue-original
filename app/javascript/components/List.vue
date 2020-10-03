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
        @sort="$emit('change')"
      >
        <Card v-for="card in cards"
          :key="card.id"
          :card="card"
          :cardIndex="index"
          :listIndex="listIndex"
          @clickCardSettingButton="openCardSettingModal(card)"
          v-if="id===card.list_id"
          @cardBodyFormComplete="updateCard"
        ></Card>
      </draggable>
    </div>
    <div>
      <CardSettingModal 
      :card="cardDetail"
      :list="list"
      v-if="cardSettingModalFlag"
      @clickCardSettingModalCloseButton="closeCardSettingModal"
      @clickCardEditOpenButton="openCardEditModal(cardDetail)"
      @updateCard="updateCard"
      @clickedCardDeleteButton="deleteCard"
      @selectedValueScheduled="openCardToGanttChartModal"
      ></CardSettingModal>
    </div>
    <div>
      <CardToGanttChartModal
      :card="cardEdit"
      :list="list"
      v-if="cardToGanttChartModalFlag"
      @clickCardEditModalCloseButton="closeCardEditModal(cardEdit)"
      @clickCardUpdateButton="updateCard"
      ></CardToGanttChartModal>
    </div>
  </div>
</template>

<script>
import CardAdd from '../components/CardAdd'
import Card from '../components/Card'
import CardSettingModal from '../components/CardSettingModal'
import CardToGanttChartModal from '../components/CardToGanttChartModal'

import draggable from "vuedraggable";

import { mapState, mapActions } from 'vuex'

export default {
  data(){
    return{
      options: {
        group: {
          name: 'myGroup',
          // pull: 'clone',
          // put: 'clone'
        },
        animation: 200
      },
      cardSettingModalFlag: false,
      cardEditModalFlag: false,
      cardToGanttChartModalFlag: false,
    }
  },
  props: {
    id: {
      type: Number,
      required: true
    },
    title: {
      type: String,
      required: true
    },
    list: {
      type: Object,
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
    ...mapState('cards',{
      cards: 'cards'
    }),
    // ...mapState('lists',{
    //   lists: 'lists'
    // }),
  },
  mounted(){
    this.$store.dispatch('cards/fetchCardsAction')
  },
  components:{
    CardAdd,
    Card,
    CardSettingModal,
    // CardEditModal,
    CardToGanttChartModal,
    draggable
  },
  methods: {
    openCardToGanttChartModal(card){
      this.cardSettingModalFlag = false
      this.cardToGanttChartModalFlag = true
      this.cardEdit = card
    },
    ...mapActions('cards',[
      'updateCardAction',
      'deleteCardAction',
    ]),
    removeList: function() {
      if(confirm('本当にこのリストを削除しますか？')){
        this.$store.dispatch('lists/removelist', { listIndex: this.listIndex })
      }
    },
    openCardSettingModal(card){
      this.cardDetail = card
      this.cardSettingModalFlag = true
      this.cardEdit = card
    },
    openCardEditModal(card){
      this.closeCardSettingModal()
      this.cardEditModalFlag = true
      this.cardEdit = card
    },
    closeCardSettingModal(){
      this.cardSettingModalFlag = false
    },
    closeCardEditModal(){
      this.cardEditModalFlag = false
    },
    async updateCard(card){
      await this.updateCardAction(card)
      // this.$router.go({path: this.$router.currentRoute.path, force: true})
      // this.closeCardEditModal()
      // this.closeCardSettingModal()
    },
    async deleteCard(card){
      if(confirm('本当にこのカードを削除しますか？')) {
        await this.deleteCardAction(card)
      }
      this.cardSettingModalFlag = false
      // this.$router.go({path: this.$router.currentRoute.path, force: true})
      // this.closeCardEditModal()
      // this.closeCardSettingModal()
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
  width: 100%;
  display: inline-flex;
  justify-content: center;
}

.list-title {
  background: linear-gradient(transparent 70%, #ff99ab 70%);
  font-size: 25px;
  font-weight: bold;
  padding: 15px;
  margin-bottom: 10px;
  text-align: center;
}

.deletelist {
  position: absolute;
  top: 6px;
  right: 14px;
  font-size: 28px;
}

</style>
