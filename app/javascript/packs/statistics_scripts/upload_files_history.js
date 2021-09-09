import LineChart from 'metrics-graphics'

alert("something");

const data = [{ year: '1945', sightings: 6 }, { year: '1946', sightings: 8 }];

new LineChart({
  data, // some array of data objects
  width: 600,
  height: 200,
  target: '#chart',
  area: true,
  xAccessor: 'year',
  yAccessor: 'sightings'
})
