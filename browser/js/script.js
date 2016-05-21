
var config = {
  base_path: 'js/tablefilter/',
  alternate_rows: true,

  col_number_format: [
    null, null, null,'EU',
    null, null, null, null
  ],

  extensions: [{ name: 'sort' }]
};

var tf = new TableFilter('my-table',config);
tf.init();
