json.comment    @comment.comment
json.user_id    @comment.user.id
json.user_name  @comment.user.nickname
json.created_at @comment.created_at.strftime("%Y/%m/%d %H:%M")
json.item_id    @comment.item.seller.id