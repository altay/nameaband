function log(msg) {
  if (typeof console != 'undefined') {
    try { console.warn(msg); }
    catch (e) {}
  }
}

var jq = jQuery.noConflict();
var BN = new function() {
  this.set_likes = function(nid_ary) {
    jq.each(nid_ary, function(i, nid) {
      jq("li.name_"+nid).addClass('like');
    })
  }

  this.toggle_like = function(nid) {
    jq.post(
      '/names/toggle_like', 
      {name_id: nid},
      function(r) {
        var name_lis = jq('li.name_'+nid);
        if (r.error) { alert(r.error); }
        else { name_lis.toggleClass('like'); }
        var likes_counts = jq("span.likes_count_"+nid);
        (name_lis.hasClass('like') ? BN.utils.increment_html(likes_counts) : BN.utils.decrement_html(likes_counts));
      }, 
      'json'
    )
  }
}
BN.utils = new function() {
  // give it an elt selector and it'll increment the innerhtml (naturally, this assumes the innerhtml is a number!)
  this.increment_html = function(elt_selector) {
    var elt=jq(elt_selector);
    elt.html(((1*elt.html())+1)+'');
  }
  this.decrement_html = function(elt_selector) {
    var elt=jq(elt_selector);
    elt.html(((1*elt.html())-1)+'');
  }
}
