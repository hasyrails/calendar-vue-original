<template>
  <div class="list">
    <div class="listheader">
      <div class="list-title">{{ title }}</div>
        <div class="list-counter" v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0">
          total: {{ totalCardInList }}
        </div>
      <div class="delete-list-button" @click="deleteList" v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0">×</div>
    </div>
    <div class="cards-area">
      <div v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0">
        <CardAdd :list_id="list_id" :list="list"></CardAdd>
      </div>
      <div v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0">
        <draggable
          :options="options"
          :list="cards"
          @sort="$emit('change')"
        >
          <Card v-for="card in ownCards"
            :key="card.id"
            :card="card"
            :list_id="list_id"
            @clickCardSettingButton="openCardSettingModal(card)"
            v-if="list_id===card.list_id&&card.done===false"
            @cardBodyFormComplete="updateCard"
          ></Card>
        </draggable>
      </div>
      <div v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length===0">
        <draggable
          :options="options"
          :list="cards"
          @sort="$emit('change')"
        >
          <SampleCard v-for="sampleCard in sampleCards"
            style="margin-top: 5px;"
            :key="sampleCard.id"
            :sampleCard="sampleCard"
            @clickSampleCardSettingButton="openSampleCardSettingModal(sampleCard)"
            v-if="sampleListId===sampleCard.sampleListId"
            @cardBodyFormComplete="updateCard"
          ></SampleCard>
        </draggable>

      </div>
    </div>
    <div v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length!==0">
      <CardSettingModal 
      :card="cardDetail"
      :list="list"
      v-if="cardSettingModalFlag"
      @clickCardSettingModalCloseButton="closeCardSettingModal"
      @clickCardEditOpenButton="openCardEditModal(cardDetail)"
      @updateCard="updateCard"
      @clickedCardDeleteButton="deleteCard"
      @selectedValueScheduled="openCardToGanttChartModal"
      @clickedCreateScheduleFromCardButton="createSchedulesFromCard"
      ></CardSettingModal>
    </div>
    <div v-if="$store.state.auth.user.length!==0&&$store.state.auth.headers.length===0">
      <SampleCardSettingModal 
      :card="sampleCardDetail"
      :list="list"
      v-if="sampleCardModalFlag"
      @clickSampleCardSettingModalCloseButton="closeSampleCardSettingModal"
      @updateCard="updateCard"
      @clickedCardDeleteButton="deleteCard"
      @selectedValueScheduled="openCardToGanttChartModal"
      @clickedCreateScheduleFromCardButton="createSchedulesFromCard"
      ></SampleCardSettingModal>
    </div>
  </div>
</template>

<script>

import CardAdd from '../components/CardAdd'
import Card from '../components/Card'
import SampleCard from '../components/SampleCard'
import CardSettingModal from '../components/CardSettingModal'
import SampleCardSettingModal from '../components/SampleCardSettingModal'
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
      sampleCardModalFlag: false,
    }
  },
  props: {
    // id: {
    //   type: Number,
    //   required: true
    // },
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
    },
    sampleListId: {
      type: Number,
      required: true
    }
  },
  computed: {
    totalCardInList() {
      return this.$store.getters['cards/cards'].filter(card=>card.list_id===this.list.id&&!card.done).length
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
    ownCards() {
       return this.$store.getters['cards/cards'].filter(card=>card.user_id===this.$store.state.auth.user.id)
    },
    sampleCards() {
       return this.$store.getters['cards/sampleCards']
    },
  },
  mounted(){
    this.$store.dispatch('cards/fetchCardsAction')
  },
  components:{
    CardAdd,
    Card,
    SampleCard,
    CardSettingModal,
    SampleCardSettingModal,
    // CardEditModal,
    CardToGanttChartModal,
    draggable,
  },
  methods: {
    createSchedulesFromCard(card){
      if(confirm('一度決めた「いつから」「いつまで」は変更できません！よろしいですか？')){
        this.cardDetail = card
        this.closeCardSettingModal()
        this.updateCardAction(card)
        this.$store.dispatch('schedules/createScheduleAction', card)
        // this.$router.go({path: this.$router.currentRoute.path, force: true})
      }
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
    },
    openSampleCardSettingModal(card){
      this.sampleCardDetail = card
      this.sampleCardModalFlag = true
    },
    openCardEditModal(card){
      this.closeCardSettingModal()
      this.cardEditModalFlag = true
      this.cardEdit = card
    },
    closeCardSettingModal(){
      this.cardSettingModalFlag = false
    },
    closeSampleCardSettingModal(){
      this.sampleCardModalFlag = false
    },
    closeCardToGanttChartModal(){
      this.cardToGanttChartModalFlag = false
    },
    async updateCard(card){
      await this.updateCardAction(card)
      this.$router.go({path: this.$router.currentRoute.path, force: true})
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
  /* margin-top: 10px; */
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
  z-index:100;
}

.listheader {
  width: 100%;
  display: inline-flex;
  justify-content: center;
  height:50px;
}

.list-title {
  background: linear-gradient(transparent 70%, #ff99ab 70%);
  font-size: 25px;
  font-weight: bold;
  height:40px;
  /* margin-bottom: 10px; */
  text-align: center;
}

.delete-list-button {
  position: absolute;
  top: 1px;
  right: 14px;
  font-size: 25px;
  cursor: pointer;
}

</style>
