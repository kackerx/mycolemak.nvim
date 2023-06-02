package main

import (
	"errors"
	"fmt"
)

const PAY = 1

func main() {
	a := "k"
	fmt.Printf("%s\n", a)
	err := errors.New("test/arst/arst")
	if err != nil {
		return
	}

	for i := 0; i < 11; i++ {
		fmt.Println("kacker")
	}

	foo(1, "2", "kk")
	foo(1, "k", "kk")
	foo(1, "k", "k")

	b := make([]int, 0)
	b = append(b, 1)

	m := make(map[string]string)

	M := make(map[string]any)

	c := []int{1, 2}
	c = append(c, 2)

	fmt.Println(m)
	fmt.Println(M)

	for i := 0; i < 10; i++ {
		fmt.Println("kacker")
	}

}

// foo arst
func foo(a int, b, c string) chan int {
	fmt.Println("kacker")
	fmt.Println(a)
	fmt.Println(b)
	fmt.Println(c)
	fmt.Println("kacker")

	ch := make(chan int)
	go func() {
		for i := 0; i < 10; i++ {
			ch <- i
		}
		defer close(ch)
	}()
	return ch
}

// Bar TEST COMMENT
func Bar(a int, b, c string) error {
	return nil
}

// User arst
type User struct {
	Name string `json:"st" db:"ss"`
	Age  int    `json:"hehe"`
	hehe int
}

// User arst
type use struct {
	Name string `json:"st" db:"ss"`
	Age  int    `json:"hehe"`
	hehe int
}

// get arst
func (*use) get() {
}

func (*use) set() {
}

type IGet interface {
	get()
}

type iSet interface {
	set()
}

// User make a User
