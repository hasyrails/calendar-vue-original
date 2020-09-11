<template>
  <div>
    <div
      class="calender-todo"
      v-bind:class="date.todoNumber !== '-' ? 'number' : ''"
    >{{ date.todoNumber }}</div>
  </div>
</template>

<script>
export default {
  props:{
    dates:{
      type: Array
    }
  }
}
</script>

<style scoped>

</style>
