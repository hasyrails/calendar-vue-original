<template>
  <div>
    <h2>カレンダー{{ currentDate }}</h2>
    <div style="max-width:900px;border-top:5px solid red;">
      <div
        v-for="(week, index) in calendars"
        :key="index"
        style="display:flex;border-left:5px solid green"
      >
        <div
          v-for="(day, index) in week"
          :key="index"
          style="flex:1;min-height:125px;border-right:5px solid blue;border-bottom:5px solid blue"
        >
          {{ day.date }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import moment from "moment";

export default {
  name: 'Calendar',
  data() {
    return {
      currentDate: moment(),
    };
  },
  methods: {
    getStartDate() {
      let date = moment(this.currentDate);
      date.startOf("month");
      const youbiNum = date.day();
      return date.subtract(youbiNum, "days");
    },
    getEndDate() {
      let date = moment(this.currentDate);
      date.endOf("month");
      const youbiNum = date.day();
      return date.add(6 - youbiNum, "days");
    },
    getCalendar() {
      let startDate = this.getStartDate();
      const endDate = this.getEndDate();
      const weekNumber = Math.ceil(endDate.diff(startDate, "days") / 7);

      let calendars = [];
      for (let week = 0; week < weekNumber; week++) {
      let weekRow = [];
      for (let day = 0; day < 7; day++) {
        weekRow.push({
        date: startDate.get("date"),
        });
        startDate.add(1, "days");
      }
      calendars.push(weekRow);
      }
      return calendars;
    },
  },
  computed: {
    calendars() {
      return this.getCalendar();
    },
  },
}
</script>

<style>

</style>
