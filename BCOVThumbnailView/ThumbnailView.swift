//
//  ThumbnailView.swift
//  CustomControls
//
//  Created by Jenix Gnanadhas on 19/03/20.
//  Copyright © 2020 Brightcove, Inc. All rights reserved.
//

import UIKit
import BrightcovePlayerSDK
import Kingfisher

class ThumbnailView: NSObject {

    var imageView : UIImageView?
    var metaData:Dictionary = [String:Any]()
    var sliderHead:UISlider?
    var videoDuration:Float?
    var imageArray = [String]()
    var playerController:UIViewController?{
        didSet{
            setObserverForSlider()
        }
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        print("Slider value changed")
    }
    
    func setObserverForSlider(){
        //Add Imageview
        imageView = UIImageView(image: nil)
        imageView?.frame = CGRect(x:0, y:0, width: 50, height: 50)
        imageView?.isHidden = true
       
        if let controllerObj = playerController {
            videoDuration = metaData["duration"] as? Float ?? 0.0
            if let imgArray = metaData["imageArray"] as? [String]{
               imageArray = imgArray
            }
            
                //get the slide View
                if let ImgView = imageView{
                     controllerObj.view.addSubview(ImgView)
                }
            
            
            let controlSubViews = controllerObj.view.subviews[0].subviews[0].subviews[0].subviews[2].subviews[1].subviews[0].subviews
            
            for views in controlSubViews {
                print(views)
                if views.subviews.count > 0 {
                    if views.subviews[0].isMember(of: BCOVPUISlider.self) {
                        if let slider = views.subviews[0] as? UISlider{
                            sliderHead = slider
                                           slider.addTarget(self, action: #selector(draggingNow), for: .touchDragInside)
                                                                   slider.addTarget(self, action: #selector(dragDone), for: .touchDragExit)
                                                                   slider.addTarget(self, action: #selector(touchSliderHead), for: .touchUpInside)
                                                                   slider.addTarget(self, action: #selector(draggingOutside), for: .touchDragOutside)
                                                                   slider.addTarget(self, action: #selector(cancellingtouch), for: .touchUpOutside)
                        }
                    }
                }
            }
//            if let slider = bcovSlider as? UISlider {
//                slider.addTarget(self, action: #selector(draggingNow), for: .touchDragInside)
//                                        slider.addTarget(self, action: #selector(dragDone), for: .touchDragExit)
//                                        slider.addTarget(self, action: #selector(touchSliderHead), for: .touchUpInside)
//                                        slider.addTarget(self, action: #selector(draggingOutside), for: .touchDragOutside)
//                                        slider.addTarget(self, action: #selector(cancellingtouch), for: .touchUpOutside)
//            }
        }
    }
    
    @objc func draggingOutside() {
      imageView?.isHidden = true
    }
    
    @objc func cancellingtouch(){
        imageView?.isHidden = true
    }
    
    @objc func draggingNow(){
        let newCurrentTime = CGFloat(sliderHead?.value ?? 0.0) * CGFloat((videoDuration ?? 0.0)/1000)
        //print("The New current time is: \(newCurrentTime)")
        //print("The image is: \(Int(newCurrentTime/30))")
        imageView?.isHidden = false
        
        let url = URL(string: imageArray[Int(newCurrentTime/30)])
        self.imageView?.kf.setImage(with: url)
        let coordinates = getCoOrdinates()
        imageView?.frame.origin.x = coordinates[0]
        imageView?.frame.origin.y = coordinates[1] - 50
    }
    
    @objc func dragDone(){
        imageView?.isHidden = true
    }
    @objc func touchSliderHead(){
    imageView?.isHidden = true
    }
    
    func getCoOrdinates() -> [CGFloat] {
        var coordinatesArray = [CGFloat]()
        if let slider = sliderHead{
            let thumbRect = slider.thumbRect(forBounds: slider.bounds,
                                             trackRect: slider.trackRect(forBounds: slider.bounds),
                                             value: slider.value)

            let convertedThumbRect = slider.convert(thumbRect, to: playerController?.view)
            coordinatesArray = [convertedThumbRect.origin.x,convertedThumbRect.origin.y]
        
        }
        return coordinatesArray

    }
}

extension ThumbnailView: BCOVPlaybackSessionConsumer{
    func didAdvance(to session: BCOVPlaybackSession!) {
        print("Heyyyyy Did Advance")
        videoDuration = session.video.properties["duration"] as? Float ?? 0.0
    }
}
