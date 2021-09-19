import * as MG from 'metrics-graphics'

var data = gon.number_of_files_per_type;

MG.data_graphic({
  title: 'Types of Files',
  data: data,
  chart_type: 'bar',
  y_accessor: 'number',
  x_accessor: 'type',
  full_height: true,
  full_width: true,
  target: '#file_type_classification'
});
