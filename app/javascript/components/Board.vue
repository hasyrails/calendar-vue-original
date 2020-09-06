<template>
  <div>
    <!-- <header>
      TODO List
    </header> -->
    <main>
      <p class="info-line">All: 0 tasks</p>
      <ListAdd></ListAdd>
    </main>
  </div>
</template>

<script>
import ListAdd from './ListAdd'

export default {
  components: {
    ListAdd
  },
}
</script>
