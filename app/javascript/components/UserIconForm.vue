<template>
<div>
  <p id="error" v-show="error">{{ error }}</p>
  <label>
    <div v-if="image">
      <img :src="image" alt="Avatar" class="image" style="border-radius:50%;">
    </div>
    <div class="form-group">
    <input
           type="file"
           id="avatar_name"
           accept="image/jpeg, image/png"
           class="form-control-file" 
           @change="onImageChange"
           />
    </div>
  </label>
  <button class="btn btn-info" @click="upload()">アップロード</button>
  <p>{{ message }}</p>
</div>
</template>

<script>
export default{
    name: 'UserIconForm',
    data () {
      return {
        image: '',
        message: '',
        error: ''
      }
    },
    methods: {
      setError (error, text) {
        this.error = (error.response && error.response.data && error.response.data.error) || text
      },
      getBase64 (file) {
        return new Promise((resolve, reject) => {
          const reader = new FileReader()
          reader.readAsDataURL(file)
          reader.onload = () => resolve(reader.result)
          reader.onerror = error => reject(error)
        })
      },
      onImageChange (e) {
        const images = e.target.files || e.dataTransfer.files
        this.getBase64(images[0])
          .then(image => this.image = image)
          .catch(error => this.setError(error, '画像のアップロードに失敗しました。'))
      },
      upload () {
          if (this.image) {
            this.$emit('update',{
			      	image: this.image
			      });
          this.message = 'ユーザーアイコンを登録しました' 
          this.error = ''
        } else {
          this.error = '画像がありません'
        }
      }
    }
} 
</script>
