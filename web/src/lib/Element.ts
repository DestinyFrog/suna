
export interface ElementPayload {
    atomic_number: number
    oficial_name: string
    atomic_radius?: number
    category: string
    symbol: string
    xpos: number
    ypos: number
    atomic_mass?: number
    layers: number[]
}

class Element {
    public static async getAll() : Promise<ElementPayload[]> {
        const res = await fetch(import.meta.env.VITE_SERVER_URL+"/element")
        return await res.json() as ElementPayload[]
    }
}

export default Element