//
//  ViewController.swift
//  WarGameDesigner
//
//  Created by Michael O'Connell on 5/6/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

let MaxRows = 20
let MaxCols = 23
var CellHeight: CGFloat = 60
var CellWidth: CGFloat = CellHeight * 0.866
let Padding: CGFloat = 20

let SelectColor = NSColor.white
let unSelectColor = NSColor.black


class ViewController: NSViewController {

    @IBOutlet weak var BoardView: NSView!
    @IBOutlet weak var SizeLabel: NSTextField!
    @IBOutlet weak var ZoomOutButton: NSButton!
    @IBOutlet weak var ZoomInButton: NSButton!
    @IBOutlet weak var CurrentTerrainView: NSView!

    var mainBoard = GameBoard(initialBoard: [[]])

    var currentTerrain = GameBoardCellTerrain.Grass

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        SizeLabel.stringValue = "Size: \(CellHeight)"

        BoardView.wantsLayer = true

        BoardView.layer?.backgroundColor = NSColor.lightGray.cgColor

        BoardView.layer?.borderWidth = 1
        BoardView.layer?.borderColor = .black

        drawCells()
    }


    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    func drawCells() {
        for y in 0..<MaxRows {
            for x in 0..<MaxCols {
                var newX = Padding + (CGFloat(x) * (CellWidth * 1.0))
                if (y % 2 == 1) {
                    newX = newX + (CellWidth / 2)
                }

                let newY = Padding + (CGFloat(y) * ((CellHeight * 0.7486)))

                mainBoard.rows[y].cells[x].view.frame = NSRect(x: newX, y: newY, width: CellWidth, height: CellHeight)
                mainBoard.rows[y].cells[x].view.tag = (y * 1000) + x

                BoardView.addSubview(mainBoard.rows[y].cells[x].view)

                let tapGesture = NSClickGestureRecognizer()
                tapGesture.target = self
                tapGesture.buttonMask = 0x1   // left button
                tapGesture.numberOfClicksRequired = 1
                tapGesture.action = #selector(self.click(g:))
                mainBoard.rows[y].cells[x].view.addGestureRecognizer(tapGesture)
            }
        }

    }


    @objc func click(g:NSGestureRecognizer) {
        if let v = g.view as? HexView {

            let touchpoint = g.location(in: v)

            if v.insideMask(x: touchpoint.x, y: touchpoint.y) {
                // print("Inside Hexagon : \(v.tag)")

                let y: Int = v.tag / 1000
                let x: Int = v.tag % 1000

                mainBoard.rows[y].cells[x].setTerrain(terrain: currentTerrain)

//                if (mainBoard.rows[y].cells[x].selected) {
//                    mainBoard.rows[y].cells[x].deselectCell()
//                }
//                else {
//                    mainBoard.clearHighlight()
//                    mainBoard.rows[y].cells[x].selectCell()
//                }

            }
            else {
    //                print("Outside Hexagon")
            }

        }
    }


    @IBAction func ZoomOutClick(_ sender: Any) {
        CellHeight = CellHeight * 0.5
        CellWidth = CellHeight * 0.866
        drawCells()
        SizeLabel.stringValue = "Size: \(CellHeight)"
        self.view.needsDisplay = true
    }


    @IBAction func ZoomInClick(_ sender: Any) {
        CellHeight = CellHeight * 2.0
        CellWidth = CellHeight * 0.866
        drawCells()
        SizeLabel.stringValue = "Size: \(CellHeight)"
        self.view.needsDisplay = true
    }


    @IBAction func GrassButtonClick(_ sender: Any) {
        currentTerrain = .Grass
        CurrentTerrainView.layer?.backgroundColor = currentTerrain.toColor().cgColor
    }


    @IBAction func WoodsButtonClick(_ sender: Any) {
        currentTerrain = .Woods
        CurrentTerrainView.layer?.backgroundColor = currentTerrain.toColor().cgColor
    }


    @IBAction func WaterButtonClick(_ sender: Any) {
        currentTerrain = .Water
        CurrentTerrainView.layer?.backgroundColor = currentTerrain.toColor().cgColor
    }


    @IBAction func DesertButtonClick(_ sender: Any) {
        currentTerrain = .Desert
        CurrentTerrainView.layer?.backgroundColor = currentTerrain.toColor().cgColor
    }


    @IBAction func TundraButtonClick(_ sender: Any) {
        currentTerrain = .Tundra
        CurrentTerrainView.layer?.backgroundColor = currentTerrain.toColor().cgColor
    }


    @IBAction func MountainButtonClick(_ sender: Any) {
        currentTerrain = .Mountain
        CurrentTerrainView.layer?.backgroundColor = currentTerrain.toColor().cgColor
    }

}

