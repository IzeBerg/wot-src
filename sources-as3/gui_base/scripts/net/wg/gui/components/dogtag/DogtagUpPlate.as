package net.wg.gui.components.dogtag
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class DogtagUpPlate extends UIComponentEx
   {
      
      private static const BLINK_ANIMATE_PLAY:String = "play";
      
      private static const DEFAULT_DOGTAG_FRAME_LABEL:String = "default";
      
      private static const ANIMATED_DOGTAG_FRAME_LABEL:String = "animated";
       
      
      public var playerName:TextField = null;
      
      public var clan:TextField = null;
      
      public var rankShadowMc:MovieClip = null;
      
      public var blink:MovieClip = null;
      
      private var _plate:Image = null;
      
      private var _engraving:Image = null;
      
      private var _imageRepository:ImageRepository;
      
      public function DogtagUpPlate()
      {
         this._imageRepository = ImageRepository.getInstance();
         super();
         this._plate = new Image();
         this._engraving = new Image();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addChild(this._plate);
         addChild(this._engraving);
      }
      
      override protected function onDispose() : void
      {
         this.playerName = null;
         this.clan = null;
         this._engraving.dispose();
         this._engraving = null;
         this.rankShadowMc = null;
         this._plate.dispose();
         this._plate = null;
         this._imageRepository = null;
         super.onDispose();
      }
      
      public function setDogTagInfo(param1:String, param2:String, param3:String, param4:String, param5:Boolean) : void
      {
         this.gotoAndStop(!!param5 ? ANIMATED_DOGTAG_FRAME_LABEL : DEFAULT_DOGTAG_FRAME_LABEL);
         this.playerName.text = param1;
         this.clan.text = param2;
         App.utils.commons.updateTextFieldSize(this.playerName,true,false);
         App.utils.commons.truncateTextFieldText(this.playerName,param1);
         App.utils.commons.updateTextFieldSize(this.playerName,true,false);
         if(this._imageRepository.hasImages)
         {
            this._plate.bitmapData = this._imageRepository.getImageBitmapData(param3);
            this._engraving.bitmapData = this._imageRepository.getImageBitmapData(param4);
         }
         else
         {
            this._plate.source = RES_ICONS.maps_icons_dogtags_small_backgrounds_all_png(param3);
            this._engraving.source = RES_ICONS.maps_icons_dogtags_small_engravings_all_png(param4);
         }
      }
      
      public function animateBlink() : void
      {
         this.blink.gotoAndPlay(BLINK_ANIMATE_PLAY);
      }
   }
}
