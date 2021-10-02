import * as MG from "metrics-graphics";
import * as d3 from "d3";

/* global MG, gon */
// noinspection JSUnresolvedVariable
const data = MG.convert.date(gon.upload_file_history, 'date');

/* eslint object-shorthand: ["error", "always", { "avoidQuotes": true }] */
// noinspection JSUnresolvedFunction
MG.data_graphic({
  title: "Upload History Graph",
  data: data,
  missing_is_zero: true,
  full_width: true,
  y_extended_ticks: true,
  height: 200,
  right: 40,
  y_accessor: "number",
  target: "#upload_file_history",
  x_extended_ticks: true
});
