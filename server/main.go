package main

import (
	"fmt"
	"net/http"

	routes "suna/v2/routes"
)

func polo(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "polo")
}

func main() {
	http.HandleFunc("/marco", polo)

	http.HandleFunc("/element", routes.GetAllElements)
	http.HandleFunc("/element/atomic_number", routes.GetOneElementById)
	http.HandleFunc("/element/search", routes.SearchOneElement)

	port := ":8080"
	fmt.Printf("Api running on http://localhost%s", port)
	http.ListenAndServe(port, nil)
}
