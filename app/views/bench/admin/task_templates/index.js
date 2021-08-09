import { createApp } from 'vue'
import App from 'rails_bench_engine_vue/components/index.vue'

const app = createApp(App)
app.config.performance = true
app.mount('#app')
