# apotomo-stateful

<em>Statefulness for your Apotomo widgets.</em>


# Introduction

The basic idea of this gem is to make specified instance variables of widgets persist over requests. These variables would have to be defined stateful, first.

    class CommentsWidget < Apotomo::Widget
      stateful_attr :comment_id
    
      def show(id)
        @comment_id = id
        render
      end
    end

A persistance engine would then make this state survive, e.g. automatically place the `comment_id` in a hidden field in the rendered widget view.

In a following state you could simply use this value as if there would have been no request at all.

    class CommentsWidget < Apotomo::Widget
      def delete(evt)
        comment = Comment.find(@user_id)
        # do what you want, but don't forget the omen.
      end
    end

Two persistance engines are planned.

* Session: simply place variables in the session and pass them via cookies or whatever Rails has configured.
* Hidden: use hidden fields or automatically append stateful values to URLs so they are available in the next request.