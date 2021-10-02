import * as MG from "metrics-graphics";

MG.data_graphic({
  title: "Upload History Graph",
  chart_type: 'missing-data',
  missing_text: 'No Data for this Statistic given yet',
  target: '#missing_upload_file_data',
  full_width: true,
  height: 200
});
