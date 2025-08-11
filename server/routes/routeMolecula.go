package routes

import (
	"net/http"
)

func GetAllMolecula(w http.ResponseWriter, r *http.Request) {
	/*
		cmd := exec.Command("lua", "suna/suna.lua", "examples/eteno.bin.suna")
		cmd.Dir = "/home/calisto/cat/lua_suna"

		output, err := cmd.CombinedOutput()
		if err != nil {
			log.Printf("%v", err)
		}

		w.Header().Set("Content-Type", "image/svg+xml")
		fmt.Fprintf(w, string(output))
	*/
}

func GetOneMoleculaById(w http.ResponseWriter, r *http.Request) {

}
