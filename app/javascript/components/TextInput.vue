<template>
  <div>
    <label :for="id">{{label}}</label>
    <input
      :id="id"
      :name="id"
      :type="type ? type : 'text'"
      :value="value"
      @input="handleInput"
      v-bind="$attrs"
      v-on="getListeners"
    >
  </div>
</template>

<script>
export default {
  name: "TextInput",
  inheritAttrs: false,
  props: {
    id: String,
    value: String,
    label: String,
    type: String
  },
  computed: {
    getListeners() {
      const { input, ...others } = this.$listeners;
      return { ...others };
    }
  },
  methods: {
    handleInput(event) {
      console.log(event);
      this.$emit("input", event.target.value);
    }
  }
};
</script>

<style lang="scss" scoped>
label {
  display: block;
}
</style>

