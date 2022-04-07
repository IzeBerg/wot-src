package net.wg.gui.lobby.eventProgression.components.metaLevel
{
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.data.MetaLevelVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.constants.InvalidationType;
   
   public class BaseMetaLevel extends UIComponentEx
   {
      
      public static const EXTRA_SMALL:String = "extraSmall";
      
      public static const SMALL:String = "small";
      
      public static const MEDIUM:String = "medium";
      
      public static const LARGE:String = "large";
      
      public static const EXTRA_LARGE:String = "extraLarge";
      
      private static const LABEL_PREFIX:String = "bg";
       
      
      public var levelTF:MetaLevelTextWrapper = null;
      
      public var prestigeLevelTF:MetaLevelTextWrapper = null;
      
      public var bgImage:Image = null;
      
      protected var size:String = null;
      
      protected var frameLabel:String = "";
      
      private var _data:MetaLevelVO = null;
      
      public function BaseMetaLevel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addListeners();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this._data != null && this.size != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               _loc1_ = this._data.bgImageId.toString();
               this.bgImage.source = this.getImageSource(_loc1_);
               this.frameLabel = LABEL_PREFIX + _loc1_;
               this.validateLevel();
               this.validatePrestigeLevel();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.validateLayout();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.removeListeners();
         this.disposeLevel();
         this.disposePrestigeLevel();
         this.bgImage.dispose();
         this.bgImage = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:MetaLevelVO) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      public function setIconSize(param1:String) : void
      {
         if(this.size != param1)
         {
            this.size = param1;
            invalidateData();
         }
      }
      
      protected function addListeners() : void
      {
         this.levelTF.addEventListener(Event.RESIZE,this.onTextWrapperResizeHandler);
         this.prestigeLevelTF.addEventListener(Event.RESIZE,this.onTextWrapperResizeHandler);
         this.bgImage.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      protected function validateLevel() : void
      {
         this.levelTF.gotoAndStop(this.frameLabel);
         this.levelTF.setText(this._data.seasonLevel);
         this.levelTF.setTextSize(this.getSeasonFontSize());
         this.levelTF.y = this.getSeasonOffsetY();
      }
      
      protected function validateLayout() : void
      {
         this.prestigeLevelTF.x = (-this.prestigeLevelTF.width >> 1) + this.getLevelOffsetX();
         this.levelTF.x = (-this.levelTF.width >> 1) + this.getSeasonOffsetX();
      }
      
      protected function validatePrestigeLevel() : void
      {
         this.prestigeLevelTF.gotoAndStop(this.frameLabel);
         this.prestigeLevelTF.setText(this._data.playerLevel);
         this.prestigeLevelTF.setTextSize(this.getLevelFontSize());
         this.prestigeLevelTF.y = this.getLevelOffsetY();
      }
      
      protected function removeListeners() : void
      {
         this.levelTF.removeEventListener(Event.RESIZE,this.onTextWrapperResizeHandler);
         this.bgImage.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.prestigeLevelTF.removeEventListener(Event.RESIZE,this.onTextWrapperResizeHandler);
      }
      
      protected function disposeLevel() : void
      {
         this.levelTF.dispose();
         this.levelTF = null;
      }
      
      protected function disposePrestigeLevel() : void
      {
         this.prestigeLevelTF.dispose();
         this.prestigeLevelTF = null;
      }
      
      protected function getImageSource(param1:String) : String
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getSeasonFontSize() : int
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getSeasonOffsetX() : int
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getSeasonOffsetY() : int
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getLevelFontSize() : int
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getLevelOffsetX() : int
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getLevelOffsetY() : int
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getBackgroundOffsetY() : int
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function onImageChangeHandler(param1:Event) : void
      {
         this.bgImage.x = -this.bgImage.width >> 1;
         this.bgImage.y = (-this.bgImage.height >> 1) + this.getBackgroundOffsetY();
      }
      
      protected function onTextWrapperResizeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
