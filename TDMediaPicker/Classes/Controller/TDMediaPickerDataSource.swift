//
//  TDMediaPickerDatasource.swift
//  Pods
//
//  Created by Abhimanyu on 27/10/17.
//

import Foundation
import Photos

public protocol TDMediaPickerDataSource: class{
    //Max Selection
    func mediaPickerMaxSelections(_ picker: TDMediaPicker)-> Int
    
    //Filter Specific Media Type
    func mediaPickerFilterMediaTpye(_ picker: TDMediaPicker)-> PHAssetMediaType?

    //THEME
    func mediaPickerNavigationBarTheme(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    func mediaPickerVideoThumbOverlay(_ picker: TDMediaPicker)-> TDConfigView
    
    //Permission Screen
    func mediaPickerPermissionScreenConfig(_ picker: TDMediaPicker)-> TDConfigPermissionScreen
    
    //Album List Screen
    func mediaPickerAlbumNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    func mediaPickerFetchResultsForAlbumScreen(_ picker: TDMediaPicker)-> [PHFetchResult<PHAssetCollection>]
    func mediaPickerCollectionTypeForAlbumScreen(_ picker: TDMediaPicker)-> TDMediaPickerConfig.AlbumCollectionType
    func mediaPickerImageSizeForAlbum(_ picker: TDMediaPicker)-> CGSize
    func mediaPicker(_ picker: TDMediaPicker, textFormatForAlbum album: TDAlbum, mediaCount: Int)-> TDConfigText
    func mediaPicker(_ picker: TDMediaPicker, selectedAlbumAtInitialLoad albums: [TDAlbum])-> TDAlbum?
    
    //Media List Screen
    func mediaPickerMediaNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    func mediaPickerMediaListNumberOfColumnInPortrait(_ picker: TDMediaPicker)-> Int
    func mediaPickerMediaListNumberOfColumnInLandscape(_ picker: TDMediaPicker)-> Int
    func mediaPicker(_ picker: TDMediaPicker, countForMedia mediaCount: Int)-> TDConfigView
    
    //Preview Screen
    func mediaPickerPreviewNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar
    func mediaPickerPreviewSelectedThumbnailView(_ picker: TDMediaPicker)-> TDConfigView
    func mediaPickerPreviewThumbnailAddView(_ picker: TDMediaPicker)-> TDConfigView
    func mediaPickerPreviewHideCaptionView(_ picker: TDMediaPicker)-> Bool
    
}

public extension TDMediaPickerDataSource{
    //Max Selection
    func mediaPickerMaxSelections(_ picker: TDMediaPicker)-> Int{
        return TDMediaPickerConfig.defaultMaxSelection
    }
    
    //Filter Specific Media Type
    //FIXME:- NEED TO CHECK ITS IMPLEMENTATION
    func mediaPickerFilterMediaTpye(_ picker: TDMediaPicker)-> PHAssetMediaType?{
        return nil
    }
    
    //THEME
    func mediaPickerNavigationBarTheme(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        return TDMediaPickerConfig.defaultNavigationTheme
    }
    
    //FIXME:- NEED TO ADD ITS XIB in Library
    public func mediaPickerVideoThumbOverlay(_ picker: TDMediaPicker)-> TDConfigView{
        return TDConfigViewStandard(backgroundColor: .white)
    }
    
    //Permission Screen
    func mediaPickerPermissionScreenConfig(_ picker: TDMediaPicker)-> TDConfigPermissionScreen{
        return TDMediaPickerConfig.TDConfigPermissionScreenTheme
    }
    
    //Album List Screen
    func mediaPickerAlbumNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        var configNavBar = TDConfigNavigationBar()
        configNavBar.backButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Back", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        configNavBar.otherButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Delete", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        var nextButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Next", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        nextButton.disabledTextConfig = TDConfigText.init(text: "Next", textColor: .darkGray, textFont: UIFont.boldSystemFont(ofSize: 18))
        configNavBar.nextButton = nextButton
        configNavBar.screenTitle = TDConfigLabel.init(backgroundColor: nil, textConfig: TDConfigText.init(text: "Albums", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)))
        //configNavBar.navigationBarView = TDConfigViewStandard.init(backgroundColor: .lightGray)
        return configNavBar
    }
    
    func mediaPickerFetchResultsForAlbumScreen(_ picker: TDMediaPicker)-> [PHFetchResult<PHAssetCollection>]{
        let types: [PHAssetCollectionType] = [.smartAlbum, .album]
        return types.map {
            return PHAssetCollection.fetchAssetCollections(with: $0, subtype: .any, options: nil)
        }
    }
    
    func mediaPickerCollectionTypeForAlbumScreen(_ picker: TDMediaPicker)-> TDMediaPickerConfig.AlbumCollectionType{
        return .List
    }
    
    func mediaPickerImageSizeForAlbum(_ picker: TDMediaPicker)-> CGSize{
        return CGSize(width: 90, height: 90)
    }
    
    func mediaPicker(_ picker: TDMediaPicker, textFormatForAlbum album: TDAlbum, mediaCount: Int)-> TDConfigText{
        return TDConfigText.init(text: String(format: "%@\n\n%d",album.collection.localizedTitle!,mediaCount), textColor: .black, textFont: UIFont.systemFont(ofSize: 16))
    }
    
    func mediaPicker(_ picker: TDMediaPicker, selectedAlbumAtInitialLoad albums: [TDAlbum])-> TDAlbum?{
        
        for album in albums{
            if album.collection.localizedTitle == "Camera Roll"{
                return album
            }
        }
        return nil
    }
    
    //Media List Screen
    func mediaPickerMediaNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        var configNavBar = TDConfigNavigationBar()
        configNavBar.backButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Back", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        configNavBar.otherButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Delete", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        var nextButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Next", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        nextButton.disabledTextConfig = TDConfigText.init(text: "Next", textColor: .darkGray, textFont: UIFont.boldSystemFont(ofSize: 18))
        configNavBar.nextButton = nextButton
        configNavBar.screenTitle = TDConfigLabel.init(backgroundColor: nil, textConfig: TDConfigText.init(text: "Albums", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)))
        //configNavBar.navigationBarView = TDConfigViewStandard.init(backgroundColor: .lightGray)
        return configNavBar
    }
    
    func mediaPickerMediaListNumberOfColumnInPortrait(_ picker: TDMediaPicker)-> Int{
        return 5
    }
    
    func mediaPickerMediaListNumberOfColumnInLandscape(_ picker: TDMediaPicker)-> Int{
        return 10
    }
    
    public func mediaPicker(_ picker: TDMediaPicker, countForMedia mediaCount: Int)-> TDConfigView{
        return TDConfigViewStandard(backgroundColor: .white)
    }
    
    //Preview Screen
    func mediaPickerPreviewNavBarConfig(_ picker: TDMediaPicker)-> TDConfigNavigationBar{
        var configNavBar = TDConfigNavigationBar()
        configNavBar.backButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Back", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        configNavBar.otherButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Delete", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        var nextButton = TDConfigButtonText.init(normalColor: .clear, normalTextConfig: TDConfigText.init(text: "Next", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)), cornerRadius: 6.0)
        nextButton.disabledTextConfig = TDConfigText.init(text: "Next", textColor: .darkGray, textFont: UIFont.boldSystemFont(ofSize: 18))
        configNavBar.nextButton = nextButton
        configNavBar.screenTitle = TDConfigLabel.init(backgroundColor: nil, textConfig: TDConfigText.init(text: "Albums", textColor: .white, textFont: UIFont.boldSystemFont(ofSize: 18)))
        //configNavBar.navigationBarView = TDConfigViewStandard.init(backgroundColor: .lightGray)
        return configNavBar
    }
    
    func mediaPickerPreviewSelectedThumbnailView(_ picker: TDMediaPicker)-> TDConfigView{
        return TDConfigViewStandard(backgroundColor: .white)
    }
    
    func mediaPickerPreviewThumbnailAddView(_ picker: TDMediaPicker)-> TDConfigView{
        return TDConfigViewStandard(backgroundColor: .white)
    }
    
    func mediaPickerPreviewHideCaptionView(_ picker: TDMediaPicker)-> Bool{
        return false
    }
}
