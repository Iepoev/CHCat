
var config = {
  base_path: 'js/tablefilter/',
  alternate_rows: true,
  highlight_keywords: true,
  auto_filter: true,
  auto_filter_delay: 500,
  btn_reset: true,
  status_bar: true,
  msg_filter: 'Filtering...',

  col_widths: [
    null, '500px', '50px', '50px',
    null, null, null, null
  ],

  col_number_format: [
    null, null, 'number', 'number',
    'EU', null, null, null
  ],
  extensions: [{ name: 'sort' }]
};

var tf = new TableFilter('my-table',config);
tf.init();
