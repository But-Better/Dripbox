import * as MG from 'metrics-graphics'
import * as d3 from 'd3'

const data = gon.file_size_classification;

for (let i = 0; i < data.length; i++) {
  console.log(data[i])
}

MG.data_graphic({
  title: 'Top 5 Files in Terms of Size',
  data: data,
  chart_type: 'bar',
  y_accessor: 'size',
  x_accessor: 'file',
  height: 200,
  full_width: true,
  target: '#file_size_classification',
})

MG.data_graphic({
  title: "Files and their space-usage",
  chart_type: 'missing-data',
  missing_text: 'No Data for this Statistic given yet',
  target: '#missing_file_size_data',
  full_width: true,
  height: 200,
});
