<template>
  <div class="form-container">
  <form @input="submit" class="register-form">
    <h2>メールアドレスを入力してください</h2>
    <div class="form-group">
      <label for="Email">メールアドレス</label>
      <ValidationProvider name="email" rules="required|email">
        <div slot-scope="{ errors }">
          <input type="text" class="form-control form-control-lg" v-model="email" placeholder="Enter Email">
          <p class="error-message">{{ errors[0] }}</p>
        </div>
      </ValidationProvider>
    </div>
  </form>
  </div>
</template>

<script>
import { ValidationProvider } from 'vee-validate';

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
  },
  components:{
    ValidationProvider
  }
}
</script>

<style scoped>
  .form-container{
    /* width: 100%; */
    margin-left:3%;
    margin-right:3%;
    margin-top:3%;
  }

  .register-form{
    text-align: left;
  }

  .form-control{
    width: 50%;
  }

  .error-message{
    color: red;
    font-size:20px;
  }
</style>
