adam = User.create(name: "Adam", password: "password")

post = Post.create(title: "test", content: "test test", user: adam)

Comment.create(content: "blah", post: post, user: adam)
