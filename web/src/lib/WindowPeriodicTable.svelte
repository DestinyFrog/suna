<script lang="ts">
    import elements from '../data/elements.json'
    import { invokeWindow } from '../Window';
    import type { Element } from './Element';
    import { capitalize, treatCategory } from './util';
    import WindowElement from './WindowElement.svelte';

    function openElement(element: Element) {
        invokeWindow(capitalize(element.oficial_name), WindowElement, { element })
    }
</script>

<div class="periodic-table">
{#each elements as Element[] as element}
    <button class="element {treatCategory(element.category)}"
        onclick={() => openElement(element)}
        style="grid-column-start: {element.xpos}; grid-row-start: {element.ypos};">
        {element.symbol}
    </button>
{/each}
</div>

<style scoped lang="scss">
@use "sass:map";

.periodic-table {
    display: grid;
    list-style: none;
    margin: 10px;
    gap: 1px;

    .element {
        display: flex;
        align-items: center;
        justify-content: center;
        border: 0;
        
        width: 32px;
        height: 32px;

        color: white;
        font-family: 'Courier New', Courier, monospace;
        font-size: 20px;
        font-weight: 500;
    }
}
</style>