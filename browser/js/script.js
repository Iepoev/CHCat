
var config = {
  base_path: 'js/tablefilter/',
  alternate_rows: true,

  col_widths: [
    '200px', '500px', '50px', '50px',
    '100px', '100px', '100px', '100px',
  ],

  col_number_format: [
    null, null, null,'EU',
    null, null, null, null
  ],

  extensions: [{ name: 'sort' }]
};

var tf = new TableFilter('my-table',config);
tf.init();
