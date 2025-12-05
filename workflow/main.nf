process sayHello {
    output:
        path "hello.txt"
    script:
        """
        echo 'Hello World!' > hello.txt
        """
}
