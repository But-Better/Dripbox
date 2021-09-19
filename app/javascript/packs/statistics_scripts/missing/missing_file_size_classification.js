import * as MG from "metrics-graphics";

MG.data_graphic({
  title: "Files and their space-usage",
  chart_type: 'missing-data',
  missing_text: 'No Data for this Statistic given yet',
  target: '#missing_file_size_data',
  full_width: true,
  height: 200,
});
