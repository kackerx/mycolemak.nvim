package main

import (
	"errors"
	"fmt"
	"testing"
)

func TestFoo(t *testing.T) {
	err := Bar("hello", 1)
	if err != nil {
		return
	}

	for i := 10; i < 11; i++ {
		err := Bar("hello", i)
		if err != nil {
			return
		}
		
	}
}

// Bar Test
func Bar(st string, name int) (err error) {

	if true {
		err = errors.New("kacker")
		if err != nil {
			return err
		}

		fmt.Println("k")
	}

	err = errors.New("kacker")
	if err != nil {
		return err
	}

	err = errors.New("kacker")
	if err != nil {
		panic(err)
	}

	return
}

type ss struct {
	Name string
}


