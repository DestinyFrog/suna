import { mount, type Component } from "svelte";
import Window from "./lib/Window.svelte";

export function invokeWindow(title: string, content: Component<any, any, any>, contentProps = {}) {
    const target = getTarget()

    mount(Window, {
        target,
        props: {
            title,
            Content: content,
            contentProps
        }
    })
}

export function getTarget() {
    return document.getElementById('target')!
}