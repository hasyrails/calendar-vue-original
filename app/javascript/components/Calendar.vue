<template>
   <div class="calender">
    <div class="calender-component">
      <CalendarHeader
      :dateLabel="dateLabel"
      @prev="changeMonth(0)"
      @next="changeMonth(1)"
      style="background-color: #D7EEFF;">
      </CalendarHeader>
      <div class="calender-body">
        <ul class="calender-panel-list">
          <li class="calender-panel_weekday" v-for="weekDay in weekDays" style="height:30px;width:100px;margin-left:10px;margin-right:10px;font-size:20px;text-align:center;">
            {{ weekDay }}
          </li>
          <li class="calender-panel_space" v-for="space in spaces" style="height:100px;width:100px;margin-left:10px;margin-right:10px;"></li>
            <CalendarDate
            class="calender-panel"
            v-on:click="selectDate"
            v-for="date in dates"
            :id="date.date"
            v-bind:class="selectedDate === date.date ? 'selected' : ''"
            style="border-radius:15px 15px 15px 15px;height:100px;width:100px; margin-bottom:30px;margin-left:10px;margin-right:10px;border:solid 1px;border-color: #EEEEEE;"
            >
              <div class="calender-date">{{ date.dateNumber }}</div>
            </CalendarDate>
        </ul>
      </div>
      <div class="calender-footer">
        <div
          class="calender-footer_todo"
          v-for="todo in todoList"
          v-show="todo.date === selectedDate"
        >
          <div class="calender-footer_todo-time">{{ todo.time }}</div>
          <div class="calender-footer_todo-title">{{ todo.title }}</div>
          <div class="calender-footer_todo-description">{{ todo.description }}</div>
        </div>
      </div>
    </div>
    <div><button @click="confirmMoment">confirmMoment</button></div>
    <div><button @click="confirmToDoList">confirmToDoList</button></div>
    <div><button @click="confirmFormat">confirmFormat</button></div>
    <div><button @click="confirmTrueFalse">confirmTrueFalse</button></div>
  </div>
</template>

<script>
import moment from 'moment'
import CalendarHeader from '../components/CalendarHeader'

export default {
  data(){
    return{
      todoList: [
        {
          id: 1,
          title: "起床",
          description: "きっとねむい",
          date: "2020-09-01",
          time: "09:00",
        },
        {
          id: 2,
          title: "出勤",
          description: "まだねむい",
          date: "2020-09-05",
          time: "10:00",
        },
        {
          id: 3,
          title: "打ち合わせ",
          description: "",
          date: "2020-09-20",
          time: "11:00",
        },
      ],
      dates: [], //カレンダーの日付
      spaces: [], //その月の最初日が始まる場所
      // backSpaces: [], //その月の最初日が始まる場所
      dateLabel: "", //フォーマット="2019年7月"
      selectedMonth: null, //今選択している月
      selectedDate: null, //今選択している日付
      weekDays: ['日','月','火','水','木','金','土'] //今選択している日付
    }
  },
  components:{
    CalendarHeader
  },
  methods: {
    confirmMoment(){
      console.log(moment().format("YYYY-MM-DD"));
    },
    confirmToDoList(){
      console.log(this.todoList[0].date);
    },
    confirmFormat(){
      console.log(moment()
          .startOf("month")
          .add(11, "day")
          .format("YYYY-MM-DD"));
    },
    confirmTrueFalse(){
      console.log(moment()
          .startOf("month")
          .add(11, "day")
          .format("YYYY-MM-DD")===this.todoList[0].date);
    },
    selectDate(event) {
      //日付を選択する
      this.selectedDate = event.currentTarget.id;
    },
    changeMonth(num) {
      //月を変更
      if (num === 0) {
        this.selectedMonth = moment(this.selectedMonth).subtract(1, "months");
      } else {
        this.selectedMonth = moment(this.selectedMonth).add(1, "months");
      }
    }
  },
  created() {
    //画面表示時に今日の日付と月を設定。
    this.selectedDate = moment().format("YYYY-MM-DD");
    this.selectedMonth = moment();
  },
  watch: {
    selectedMonth: function() {
      //選択している月の変更時の処理、画面表示時も動きます
      this.dateLabel = moment(this.selectedMonth).format("YYYY年MM月"); //月ラベルを更新
      this.spaces = []; //スペースを初期化
      for (
        let i = 0;
        i <
        moment(this.selectedMonth)
          .startOf("month")
          .day();
        i++
      ) {
        //スペースを更新
        this.spaces[i] = i;
      }

      this.dates = []; //カレンダーパネルを初期化
      for (let i = 0; i < moment(this.selectedMonth).daysInMonth(); i++) {
        //カレンダーパネルを更新
        
        // todoNumber
        // let todoNumber = "-";
        
        this.dates[i] = {
          date: moment(this.selectedMonth)
            .startOf("month")
            .add(i, "day")
            .format("YYYY-MM-DD"),
          dateNumber: i + 1,
          // todoNumber: todoNumber
        };
      }
    }
  }
}
</script>

<style scoped>
.calender {
  width: 1000px;
  margin-left:100px;
  margin-top:500px;
}

.calender-component {
  min-height: 320px;
  border: solid 1px gray;
  padding: 24px;
  box-sizing: border-box;
}

.arrow {
  font-size: 16px;
  /* color: gray; */
  user-select: none;
  cursor: pointer;
  text-align: center;
  width: 24px;
  height: 24px;
}

.arrow:hover {
  background-color: silver;
  border-radius: 4px;
}

.current-date {
  color: gray;
  user-select: none;
}

.calender-body {
  margin-top: 24px;
}

.calender-panel-list {
  display: flex;
  flex-wrap: wrap;
  padding: 0;
  justify-content: left;
}

.calender-panel {
  padding: 8px 0px;
  width: 118px;
  text-align: center;
  color: gray;
  font-size: 25px;
  user-select: none;
  list-style: none;
}

.calender-panel:hover {
  background-color: #DDFFFF;
  border-radius: 4px;
}

.calender-date {
  cursor: pointer;
  font-size:20px;
}

.selected {
  background-color: silver;
  border-radius: 4px;
}

.calender-todo {
  cursor: pointer;
  text-align:center;
  margin: 0px 8px;
  line-height: 25px;
}

.calender-panel_weekday {
  width: 118px;
  list-style: none;
}

.calender-panel_space {
  width: 118px;
  list-style: none;
}

.calender-footer_todo {
  border-top: 1px gray solid;
  padding-top: 12px;
  margin-top: 8px;
}

.calender-footer_todo-time {
  font-size: 18px;
  color: gray;
  word-break: break-word;
  text-decoration: underline;
}

.calender-footer_todo-title {
  font-size: 20px;
  color: gray;
  word-break: break-word;
}

.calender-footer_todo-description {
  font-size: 14px;
  color: gray;
  word-break: break-word;
}

.number {
  text-decoration: underline;
}

</style>

