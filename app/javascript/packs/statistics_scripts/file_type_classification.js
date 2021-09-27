import * as MG from 'metrics-graphics'

// noinspection JSUnresolvedVariable
const data = gon.number_of_files_per_type;

// noinspection JSUnresolvedFunction
MG.data_graphic(
  {
    title: 'Types of Files',
    data: data,
    chart_type: 'bar',
    y_accessor: 'number',
    x_accessor: 'type',
    height: 200,
    full_width: true,
    target: '#file_type_classification'
  }
);
