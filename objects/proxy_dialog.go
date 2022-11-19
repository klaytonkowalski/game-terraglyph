components {
  id: "screen_proxy"
  component: "/monarch/screen_proxy.script"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
  properties {
    id: "screen_id"
    value: "collection_dialog"
    type: PROPERTY_TYPE_HASH
  }
  properties {
    id: "popup"
    value: "true"
    type: PROPERTY_TYPE_BOOLEAN
  }
}
embedded_components {
  id: "collectionproxy"
  type: "collectionproxy"
  data: "collection: \"/collections/dialog.collection\"\n"
  "exclude: false\n"
  ""
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
