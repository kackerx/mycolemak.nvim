package main

import "fmt"

func main() {
    u := User{
        Name: "",
    }
    i := u.get("kk")
    
    
    fmt.Errorf(u)

    panic()
}

// foobar test
func foobar(name string, age int) (a int, err error) {
    fmt.Println("k")
    return 1, nil
}

type Get interface {
    get()
}
type User struct {
    Name string
}

func (*User) get(name string) err {
}
