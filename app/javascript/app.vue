<template>
  <div id="app">
    <Calendar></Calendar>
  </div>
</template>

<script>
import Calendar from "../javascript/components/Calendar";

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  components: {
    Calendar
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
