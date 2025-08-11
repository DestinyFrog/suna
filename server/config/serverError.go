package config

import (
	"fmt"
	"net/http"
)

func Write(w http.ResponseWriter, err error) {
	w.Header().Set("Content-Type", "text/plain")
	w.WriteHeader(http.StatusInternalServerError)
	fmt.Fprint(w, err.Error())
}
