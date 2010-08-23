function log(msg) {
  if (typeof console != 'undefined') {
    try { console.warn(msg); }
    catch (e) {}
  }
}

var jq = jQuery.noConflict();
var BN = new function() {
  this.set_opinions = function(nid_ary, opinion_type) {
    jq.each(nid_ary, function(i, nid) {
      jq("li.name_"+nid).addClass(opinion_type);
    })
  }

  this.toggle_opinion = function(nid, opinion_type) { //opinion_type is 'like' or 'dislike'
    if (BN.logged_in) {
      jq.post(
        '/names/toggle_opinion', 
        {name_id: nid, opinion_type: opinion_type},
        function(r) {
          if (r.redirect) {
            window.location='/';
          } else {
            var name_lis = jq('li.name_'+nid);
            var opposite_opinion = (opinion_type=='like' ? 'dislike' : 'like');
            var switching_opinion = name_lis.hasClass(opposite_opinion);
            if (r.error) { alert(r.error); }
            else { name_lis.toggleClass(opinion_type); }
            var opinion_counts = jq("span."+opinion_type+"s_count_"+nid);
            (name_lis.hasClass(opinion_type) ? BN.utils.increment_html(opinion_counts) : BN.utils.decrement_html(opinion_counts));
            if (switching_opinion) {
              name_lis.removeClass(opposite_opinion);
              BN.utils.decrement_html(jq("span."+opposite_opinion+"s_count_"+nid));
            }
          }
        }, 
        'json'
      )
    } else {
      alert("First, you need to log in, buddy. Upper right corner.");
    }
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
