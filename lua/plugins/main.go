package main

import (
    "errors"
    "fmt"
)

func main() {
	err := errors.New("test/arst/arst")
	if err != nil {
		return
	}

}

// foo arst
func foo(a int, b, c string) error {
	fmt.Println(a)

	return nil
}

// User arst
type User struct {
	Name string `json:"st" db:"ss"`
	Age  int    `json:"hehe"`
	hehe int
}
arst

// User arst
type Use struct {
	Name string `json:"st" db:"ss"`
	Age  int    `json:"hehe"`
	hehe int
}

// get arst
func (*Use) get() {
}

func (*Use) set() {
}

type IGet interface {
	get()
}

type ISet interface {
	set()
}
