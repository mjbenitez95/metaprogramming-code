# metaprogramming-code
Code samples and exercises from 'Metaprogramming Ruby 2'. The book is presented as events over the course of a week of a junior developer pairing with a senior developer.

# tuesday
Tuesday's section deals with a computer class that contains lots of duplication. The developers removed that in two different ways: first by using dynamic methods and dynamic dispatch, and second by using ghost methods. 

Each approach has its tradeoffs. Defining dynamic methods at runtime is neat and generally safe, but untenable for use cases that can call for potentially infinite unique classes. Meanwhile, ghost methods allow for high flexibility, but behave with certain quirks since they are not actually methods, but rather redefining how method calls are intercepted. 

The takeaway is to use Dynamic Methods if you can and Ghost Methods if you have to.
