var replyLinks = document.querySelectorAll('.reply-link')
replyLinks.forEach(replyLink => {
  replyLink.addEventListener('click', function(e) {
    e.preventDefault()
    comment_id = e.target.parentNode.classList[1]
    document.getElementsByClassName(comment_id)[0].style.display = 'block'
  });
});