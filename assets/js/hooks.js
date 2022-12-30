import vegaEmbed from "vega-embed";
import StationMap from "./station-map";

let Hooks = {};

Hooks.StationMap = {

  mounted() {
    this.map = new StationMap(this.el, [51.5, -123.5], event => {
      const stationId = event.target.options.stationId;

      this.pushEvent("marker-clicked", stationId, (reply, ref) => {
        console.log(reply.station.id)
      })
    })

    this.pushEvent("get-stations", {}, (reply, ref) => {
      reply.stations.forEach(station => {
        this.map.addMarker(station)
      })
    })

    // approach to adding markers if using a data attribute
    // const incidents = JSON.parse(this.el.dataset.incidents);

    // incidents.forEach(incident => {
    //   this.map.addMarker(incident);
    // })

    

    // this.handleEvent("highlight-marker", station => {
    //   this.map.highlightMarker(station.id);
    // })

    // this.handleEvent("add-marker", incident => {
    //   this.map.addMarker(incident);
    //   this.map.highlightMarker(incident);
    //   this.scrollTo(incident.id)
    // })
  }

}

Hooks.PeakGraph = {

  mounted() {
    // This element is important so we can uniquely identify which element will be loaded
    this.props = { id: this.el.getAttribute("data-id") };
    // Handles the event of creating a graph and loads vegaEmbed targetting our main hook element
    this.handleEvent(`vega_lite:${this.props.id}:init`, ({ spec }) => {
        vegaEmbed(this.el, spec)
            .then((result) => result.view)
            .catch((error) => console.error(error));
      });
  }

}

export default Hooks;