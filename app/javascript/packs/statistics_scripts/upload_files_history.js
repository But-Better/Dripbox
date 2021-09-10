MG.data_graphic({
  title: "Downloads",
  description: "This graphic shows a time-series of downloads.",
  data: [{'date':new Date('2014-11-01'),'value':12},
    {'date':new Date('2014-11-02'),'value':18}],
  width: 600,
  height: 250,
  target: '#downloads',
  x_accessor: 'date',
  y_accessor: 'value'
})
