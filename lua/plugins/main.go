package main

import (
    "fmt"
)

func main() {

	a := []int{1, 2, 3}

	for i := 0; i < len(a); i++ {
		fmt.Println(a[i])
	}

	for i, v := range a {
		fmt.Println(i, v)
	}

	err := foo(1, "a", "b")
	if err != nil {

	}

}

func Max(a, b int) (int, error) {
	if a > b {
		return a, nil
	} else if a < b {
		return b, nil
	}

	return 0, nil
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
