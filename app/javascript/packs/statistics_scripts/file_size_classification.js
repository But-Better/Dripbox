import * as MG from 'metrics-graphics'

const data = gon.file_size_classification;

MG.data_graphic({
  title: 'Top 5 Files in Terms of Size',
  data: data,
  chart_type: 'bar',
  x_accessor: 'size',
  y_accessor: 'file',
  height: 500,
  full_width: true,
  target: '#file_size_classification',
});
