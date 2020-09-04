<template>
  <div id="app">
    <Calendar></Calendar>
  </div>
</template>

<script>
import Calendar from "../javascript/components/Calendar";
import Icon from '@mdi/font'
import { mdiAccount } from '@mdi/js'

export default {
  data: function () {
    return {
      <Icon path={mdiAccount}
        title="User Profile"
        size={1}
        horizontal
        vertical
        rotate={90}
        color="red"
        spin/>
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
