# Foreign Function Interface

The Nit Foreign Function Interface (FFI) allows to nest code within a Nit source file.
Current supported languages are C, C++, Java (used maily for android) and Objective C (used mainly for iOS).

Common use cases of the FFI is to optimize a method or wrap existing system or third-party libraries.
The syntax use back-quoted curly-brackets.

~~~nit
fun in_nit do print "In Nit"
fun in_c `{ printf("In C\n"); `}
fun in_cpp in "C++" `{ cout << "In C++" << endl; `}
fun in_java in "Java" `{ System.out.println("In Java"); `}
fun in_objc in "ObjC" `{ NSLog (@"In Objective C\n"); `}

in_nit
in_c
in_cpp
in_java
in_objc
~~~



