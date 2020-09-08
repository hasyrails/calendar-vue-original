<template>
<form @input="submit">
  <h2>Name Info</h2>
  <div class="form-group">
    <label for="userName">User Name</label>
    <input type="text" class="form-control" v-model="userName" placeholder="Enter User Name">
</div>
</form>
</template>

<script>
export default {
  name: 'UserNameForm',
  data(){
    return{
      userName: null
    }
  },
  methods: {
    submit(){
			this.$emit('update',{
				userName: this.userName
			});
		}
  }
}
</script>

<style scoped>

</style>
