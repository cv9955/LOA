function apply_class_to_parent() {
	apex.jQuery("span[parent-class]").each(
		function(){
			apex.jQuery(this).
				parent().attr( 'class', apex.jQuery(this).attr('parent-class'));
        }
	);	
	
    apex.jQuery("div[parent-class]").each(
		function(){
			apex.jQuery(this).
				parent().attr( 'class', apex.jQuery(this).attr('parent-class'));
        }
	);	

	apex.jQuery("a[parent-class]").each(
		function(){
		apex.jQuery(this).
				parent().attr( 'class', apex.jQuery(this).attr('parent-class'));
        }
	)
}