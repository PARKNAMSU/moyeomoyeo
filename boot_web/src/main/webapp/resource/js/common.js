function postForm(path, keys, values ,method) {
    method = method || 'post';
    var form = document.createElement('form');
    form.setAttribute('method', method);
    form.setAttribute('action', path);
    
    if(typeof keys === 'object'){
    	for(var i =0; i<keys.length; i++){
            var hiddenField = document.createElement('input');
            hiddenField.setAttribute('type', 'hidden');
            hiddenField.setAttribute('name', keys[i]);
            hiddenField.setAttribute('value', values[i]);
            form.appendChild(hiddenField);
    	}
    }else{
        var hiddenField = document.createElement('input');
        hiddenField.setAttribute('type', 'hidden');
        hiddenField.setAttribute('name', keys);
        hiddenField.setAttribute('value', values);
        form.appendChild(hiddenField);
    }
    document.body.appendChild(form);
    form.submit();
}