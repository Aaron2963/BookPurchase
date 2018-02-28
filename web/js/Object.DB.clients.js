/*------ Connecting Database --------*/
var DB = {
  'DB_name': 'salvezzas_store',

  //dictionary: php file path
  'insert': 'Inserter',
  'delete': 'Deleter',
  'replace': 'Replacer',
  'select': 'Selecter',

  'ajax': function(url, data, callback) {
    $.ajax ({
    'url':   url,
    'method': 'post',
    'dataType': 'json',
    'data': data
    });
    }
};

/*------ Ajax Object ------*/
var clients = {
  //dictionary: common info
  'tName': 'clients',
  'column': {
    "id": "id",
    "k0": "name",
    "k1": "region",
    "k2": "region_num"
    },

  //call ajax
  'insert': function() { DB.ajax(DB.insert, this.insForm); },  //callback function to be written
  'delete': function() { DB.ajax(DB.delete, this.delForm); },  //callback function to be written
  'replace': function() { DB.ajax(DB.replace, this.repForm); },  //callback function to be written
  'select': function() { DB.ajax(DB.select, this.repForm); },  //callback function to be written
  
  //DOM: get input values from each form
  'insForm': function() {
    return {
    "queryType": "insert",
    "table": clients.tName,
    "id": 0,
    "k0": $('#add_name').val(),
    "k1": $('#add_region').val(),
    "k2": $('#add_region_num').val()
    };
    },
  'delForm': function() {
    return {
    "queryType": "delete",
    "table": clients.tName,
    "id": $().val()
    };
    },
  'repForm': function() {
    return {
    "queryType": "replace",
    "table": clients.tName,
    "id": $().val(),
    "k0": $().val(),
    "k1": $().val(),
    "k2": $().val()
    };
    },
  'selForm': function() {
    return {
    "queryType": "select",
    "table": clients.tName,
    "rows": 100,
    "searching": [$().val()]
    };
    }
  
  //DOM: handle reponse of php
};


/*------ Common Event Listener ------*/
var FORM = {
  'form': [],
  'set':   function(formId) {
    this.name = $('#' + formId);
    this.save = $('#' + formId.split('Form')[0] + '_save');
    },
  'save': []
}
