<template>
  <form :class="classList" @submit.prevent="addList">
    <input v-model="list.title"
           type="text"
           class="text-input"
           placeholder="Add new list"
           @focusin="startEditing"
           @focusout="finishEditing"
    >
    <button type="submit"
            class="add-button"
            v-if="isEditing || titleExists">
      Add
    </button>
  </form>
</template>

<script>
import { mapState } from 'vuex'

export default {
  data: function() {
    return {
      isEditing: false,
      list: {
        title: '',
        user_id: this.$store.getters['auth/user'].id
      },
    }
  },
  computed: {
    classList() {
      const classList = ['addlist']

      if (this.isEditing) {
        classList.push('active')
      }
      if (this.titleExists) {
        classList.push('addable')
      }
      return classList
    },
    titleExists() {
      return this.list.title.length > 0
    },
    // ...mapState('lists',{
    //   lists: 'lists',
    // }),
    ...mapState('auth',{
      user: 'user'
    }),
  },
  methods: {
    addList() {
      this.$store.dispatch('lists/createListAction', this.list)
      this.title = ''
    },
    startEditing() {
      this.isEditing = true
    },
    finishEditing() {
      this.isEditing = false
    },

  }
}
</script>

<style scoped>
.text-input {
  margin-left: 15px;
  padding: 20px 15px;
  width: 200px;
  background-color: #ccc;
  border-radius: 8px;
  cursor: pointer;
  border: none;
  font-family: "Noto Sans Japanese", "Noto Sans", 'system-ui', sans-serif;
  font-weight: 700;
  font-size: 24px;
  color: #242424;
  cursor: pointer;
  overflow: overlay;
  /* position: fixed; */
}

.text-input:focus {
  outline: 0;
  cursor: initial;
}

.add-button {
  margin-top: 15px;
  padding: 15px 18px;
  background-color: #999;
  border: none;
  border-radius: 8px;
  font-family: "Noto Sans Japanese", "Noto Sans", 'system-ui', sans-serif;
  font-weight: 700;
  font-size: 18px;
  color: #fff;
}

.add-button:hover {
  opacity: 0.8;
  cursor: pointer;
}

.active .text-input {
  background-color: #fff;
}
.addable .add-button {
  background-color: #00d78f;
  pointer-events: auto;
  cursor: pointer;
}

.add-button:active {
  background-color: #00d78f;
}
</style>
