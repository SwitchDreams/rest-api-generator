# Introduction

Have you ever did a project that is basically a CRUD (Create, Read, Update, Delete) application?
Did you feel that your work was repetitive and that you could improve it? Yes? This gem is for you!

The main goal of this gem is helping you to create the CRUD part of application with a few lines of code.

## How can we achieve that?

Basically, we will use one of the most important OO principles: inheritance.

We have a class called `RestApiGenerator::
ResourceController` that is responsible to create a CRUD controller for you. You just need to inherit from it and
configure some attributes.

But this controller are not just plain CRUD, it has some features that will help you to create a better API, like:
ordering, filtering, pagination and mainly, a modular error handler.

And that isn`t all, the gem will also create initial tests (with RSPEC) and swagger documentation for you.