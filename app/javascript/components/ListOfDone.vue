<template>
  <div class="list purun">
    <div class="listheader">
      <div class="list-title">{{ title }}</div>
       <div class="list-counter">total: {{ totalCardInList }}</div>
      <div class="deletelist" @click="deleteList">×</div>
    </div>
    <div class="cards-area">
      <draggable
        :options="options"
        :list="cards"
        @sort="$emit('change')"
      >
        <CardOfDone v-for="card in cards"
          :key="card.id"
          :card="card"
          :list_id="list_id"
          @clickCardSettingButton="openCardOfDoneModal(card)"
          v-if="list_id===card.list_id&&card.done===true"
          @cardBodyFormComplete="updateCard"
        ></CardOfDone>
      </draggable>
    </div>
    <div>
      <CardOfDoneModal 
      :card="cardDetail"
      :list="list"
      v-if="cardOfDoneModalFlag"
      @clickCardOfDoneModalCloseButton="closeCardOfDoneModal"
      @clickCardEditOpenButton="openCardEditModal(cardDetail)"
      @updateCard="updateCard"
      @clickedCardDeleteButton="deleteCard"
      @selectedValueScheduled="openCardToGanttChartModal"
      @clickedCreateScheduleFromCardButton="createSchedulesFromCard"
      ></CardOfDoneModal>
    </div>
  </div>
</template>

<script>
import CardAdd from '../components/CardAdd'
import CardOfDone from '../components/CardOfDone'
import CardOfDoneModal from '../components/CardOfDoneModal'
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
      cardOfDoneModalFlag: false,
    }
  },
  props: {
    title: {
      type: String,
      required: true
    },
    list: {
      type: Object,
      required: true
    },
    list_id: {
      type: Number,
      required: true
    }
  },
  computed: {
    totalCardInList() {
      return this.cards.length
    },
    ...mapState('cards',{
      cards: 'cards'
    }),
    ...mapState('schedules',{
      schedules: 'schedules'
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
    CardOfDone,
    CardOfDoneModal,
    // CardEditModal,
    CardToGanttChartModal,
    draggable
  },
  methods: {
    async createSchedulesFromCard(card){
      if(confirm('一度決めた「いつから」「いつまで」は変更できません！よろしいですか？')){
        this.cardDetail = card
        this.closeCardSettingModal()
        await this.updateCardAction(card)
        await this.$store.dispatch('schedules/createScheduleAction', card)
      }
      // this.$router.go({path: this.$router.currentRoute.path, force: true})
      // this.$store.dispatch('devidedschedules/createDevidedSchedulesAction')
    },
    openCardToGanttChartModal(card){
      this.cardSettingModalFlag = false
      this.cardToGanttChartModalFlag = true
      this.cardEdit = card
    },
    ...mapActions('cards',[
      'updateCardAction',
      'deleteCardAction',
    ]),
    // ...mapActions('schedules',[
    //   'createScheduleAction'
    // ]),
    deleteList() {
      if(confirm('本当にこのリストを削除しますか？')){
        this.$store.dispatch('lists/deleteListAction', this.list)
      }
      this.$router.go({path: this.$router.currentRoute.path, force: true})
    },
    openCardSettingModal(card){
      this.cardDetail = card
      this.cardSettingModalFlag = true
      this.cardEdit = card
    },
    openCardOfDoneModal(card){
      this.cardDetail = card
      this.cardOfDoneModalFlag = true
      this.cardEdit = card
    },
    openCardEditModal(card){
      this.closeCardSettingModal()
      this.cardEditModalFlag = true
      this.cardEdit = card
    },
    closeCardOfDoneModal(){
      this.cardOfDoneModalFlag = false
    },
    closeCardToGanttChartModal(){
      this.cardToGanttChartModalFlag = false
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
  background-color: #FFFFDD;
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

.purun {
  animation: purun 0.8s linear 0s 1;
}

@keyframes purun {
  0%   { transform: scale(1.0, 1.0) translate(0%, 0%); }
  15%  { transform: scale(0.9, 0.9) translate(0%, 5%); }
  30%  { transform: scale(1.3, 0.8) translate(0%, 10%); }
  50%  { transform: scale(0.8, 1.3) translate(0%, -10%); }
  70%  { transform: scale(1.1, 0.9) translate(0%, 5%); }
  100% { transform: scale(1.0, 1.0) translate(0%, 0%); }
}
</style>
