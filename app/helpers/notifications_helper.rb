module NotificationsHelper

  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    #コメントの内容を通知に表示する
    @review = nil
    @visitor_review = notification.review_id
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'like'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: micropost_path(notification.micropost_id)) + 'を保存しました'
    when 'review' then
      #コメントの内容と投稿のタイトルを取得　      
      @review = Review.find_by(id: @visitor_review)
      @review_content = @review.content
      @micropost_title = @review.micropost.title
      tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@micropost_title}", href: micropost_path(notification.micropost_id)) + 'にコメントしました'
    end
  end
end
