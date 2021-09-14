import * as MG from 'metrics-graphics'
import * as d3 from 'd3'

const data = MG.convert.date(gon.upload_file_history, 'date');

MG.data_graphic({
  title: "Upload History Graph",
  data: data,
  interpolate: d3.curveLinear,
  missing_is_zero: true,
  full_width: true,
  height: 200,
  right: 40,
  y_accessor: 'number',
  //x_axis: false,
  target: '#upload_file_history',
  x_extended_ticks: true
});

MG.data_graphic({
  title: "Upload History Graph",
  chart_type: 'missing-data',
  missing_text: 'No Data for this Statistic given yet',
  target: '#missing_upload_file_data',
  full_width: true,
  height: 200
});
