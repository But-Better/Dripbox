const data = [{'date':new Date('2014-11-01'),'value':12},
  {'date':new Date('2014-11-02'),'value':18}]

MG.data_graphic({
  title: "Uploads",
  description: "This graphic shows a time-series of your uploads.",
  width: 600,
  height: 250,
  data: data,
  target: '#chart',
  x_accessor: 'date',
  y_accessor: 'number'
})
