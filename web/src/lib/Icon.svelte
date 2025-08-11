<script lang="ts">
    let { title, icon, onclick }: {
        title: string,
        icon: string,
        onclick: Function
    } = $props()
</script>

<button class="icon" onclick={() => onclick()}>
    <img src={icon} alt={title} />
    <span>{ title }</span>
</button>

<style scoped>
    .icon {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        text-align: center;

        background-color: transparent;
        border: 0;

        width: 100px;
        height: 100px;
        margin: 6px;
        padding: 4px;
        border-radius: 16px;
    }

    .icon:hover {
        background-color: rgba(255, 255, 255, .2);
    }

    .icon img {
        height: 100%;
    }

    .icon span {
        color: white;
        font-size: 13px;
    }
</style>