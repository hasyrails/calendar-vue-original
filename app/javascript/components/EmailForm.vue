<template>
  <form @input="submit">
    <h2>Contact Info</h2>
    <div class="form-group">
      <label for="Email">Email</label>
      <input type="email" class="form-control" v-model="email" placeholder="Enter email">
    </div>					
  </form>
</template>

<script>
export default {
  name: 'EmailForm',
  data(){
    return{
      email: null
    }
  },
  methods: {
		submit(){
			this.$emit('update',{
				email: this.email,
			});
		}
	}
}
</script>

<style scoped>

</style>
