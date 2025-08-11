<script lang="ts">
import type { Component } from "svelte";
import type { Vec2 } from "./util";

let {
    Content,
    contentProps,
    title = ""
}: {
    Content: Component,
    contentProps: Object,
    title: string
} = $props()

let div_app: HTMLDivElement
let drag_position: Vec2 = { x: 0, y: 0 }
let before_drag_position: Vec2 = { x: 0, y: 0 }

function mouseMove(ev:MouseEvent) {
    if (ev.clientX > 0 && ev.clientX < document.body.clientWidth) {
        drag_position.x = before_drag_position.x - ev.clientX
        before_drag_position.x = ev.clientX
        div_app.style.left = `${div_app.offsetLeft - drag_position.x}px`	
    }

    if (ev.clientY > 0 && ev.clientY < document.body.clientHeight) {
        drag_position.y = before_drag_position.y - ev.clientY
        before_drag_position.y = ev.clientY
        div_app.style.top = `${div_app.offsetTop - drag_position.y}px`
    }
}

function mouseDown(ev:MouseEvent) {
    before_drag_position.x = ev.clientX
    before_drag_position.y = ev.clientY

    document.addEventListener('mousemove', mouseMove)
    document.addEventListener('mouseup', _ =>
        document.removeEventListener('mousemove', mouseMove))
}

function close() {
    div_app.remove()
}
</script>

<div class="window" bind:this={div_app}>
    <header class="header" onmousedown={mouseDown}
        role="button" tabindex="0">
        <p class="title">{ title }</p>
        <button class="close-button" aria-label="close" onclick={close}></button>
    </header>

    <main class="content">
        <Content {... contentProps}></Content>
    </main>
</div>

<style scoped>
    .window {
        background-color: rgb(71, 71, 71);
        
        border: 2px solid black;
        border-radius: 5px;

        position: fixed;
        top: 0;
        left: 0;
    }

    .header {
        border-bottom: 2px solid black;

        display: flex;
        flex-direction: row;
        align-items: center;
        padding: 4px;
        justify-content: space-between;
        user-select: none;
    }

    .header .close-button {
        width: 16px;
        height: 16px;
        border-radius: 50%;
        background-color: red;
        border: 2px solid white;
    }

    .header .title {
        color: white;
        font-family: 'Courier New', Courier, monospace;
        font-weight: 700;
        margin-right: 10px;
    }

    .content {
        border: 2px solid black;
        border-radius: 5px;
        margin: 4px;
        min-width: 100px;
        min-height: 100px;
        background-color: aliceblue;
    }
</style>