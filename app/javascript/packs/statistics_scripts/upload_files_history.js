const gon_data = gon.upload_file_history;

const data = [];

for (let i = 0; i < gon_data.size; i++) {
  data[i] = {"date": new Date(gon_data[i]["date"].toString()), "number": gon_data[i]["number"]};
  console.log(data[i])
}


MG.data_graphic({
  title: "Downloads",
  description: "This graphic shows a time-series of downloads.",
  data: data,
  width: 600,
  height: 250,
  target: '#chart',
  x_accessor: 'date',
  y_accessor: 'number'
})

