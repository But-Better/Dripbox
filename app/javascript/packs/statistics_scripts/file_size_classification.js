import * as MG from "metrics-graphics";

// noinspection JSUnresolvedVariable
const data = gon.file_size_classification;

// noinspection JSUnresolvedFunction
MG.data_graphic(
  {
    title: "Top 5 Files in Terms of Size",
    data: data,
    chart_type: "bar",
    y_axis_position: 'right',
    x_accessor: "size",
    y_accessor: "file",
    y_axis: false,
    height: 300,
    right: 100,
    full_width: true,
    target: "#file_size_classification",
  }
);
