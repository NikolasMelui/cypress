require("../../spec_helper")

electron = require("electron")
dialog   = require("#{root}../lib/gui/handlers/dialog")
Renderer = require("#{root}../lib/gui/handlers/renderer")

describe "gui/dialog", ->
  context ".show", ->
    beforeEach ->
      @showOpenDialog = electron.dialog.showOpenDialog = @sandbox.stub()

    it "calls dialog.showOpenDialog with args", ->
      dialog.show()
      expect(@showOpenDialog).to.be.calledWith({
        properties: ["openDirectory"]
      })

    it "resolves with first path", ->
      @showOpenDialog.yields(["foo", "bar"])

      dialog.show().then (ret) ->
        expect(ret).to.eq("foo")

    it "handles null paths", ->
      @showOpenDialog.yields(null)

      dialog.show().then (ret) ->
        expect(ret).to.eq(undefined)
