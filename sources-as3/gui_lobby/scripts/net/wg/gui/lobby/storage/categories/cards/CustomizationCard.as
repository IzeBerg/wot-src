package net.wg.gui.lobby.storage.categories.cards
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.storage.categories.cards.configs.CardConfigs;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class CustomizationCard extends BaseCard
   {
       
      
      public var previewButton:SoundButtonEx = null;
      
      public var progressiveLevelIcon:Image = null;
      
      public var rentIcon:MovieClip;
      
      private var _typedData:CustomizationCardVO = null;
      
      private var _progressiveLevelPosition:Point = null;
      
      public function CustomizationCard()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         sellButton.label = STORAGE.BUTTONLABEL_SELL;
         this.previewButton.visible = false;
         this.previewButton.addEventListener(MouseEvent.CLICK,this.onPreviewButtonClick);
         this.previewButton.addEventListener(MouseEvent.ROLL_OVER,this.onPreviewButtonRollOver);
         this.previewButton.addEventListener(MouseEvent.ROLL_OUT,this.onPreviewButtonRollOut);
         this.rentIcon.mouseEnabled = this.rentIcon.mouseChildren = false;
         this.progressiveLevelIcon.mouseEnabled = this.progressiveLevelIcon.mouseChildren = false;
         this.progressiveLevelIcon.addEventListener(Event.CHANGE,this.onProgressionIconLoaded);
      }
      
      override protected function onDispose() : void
      {
         this.previewButton.removeEventListener(MouseEvent.CLICK,this.onPreviewButtonClick);
         this.previewButton.removeEventListener(MouseEvent.ROLL_OVER,this.onPreviewButtonRollOver);
         this.previewButton.removeEventListener(MouseEvent.ROLL_OUT,this.onPreviewButtonRollOut);
         this.previewButton.dispose();
         this.previewButton = null;
         this.progressiveLevelIcon.removeEventListener(Event.CHANGE,this.onProgressionIconLoaded);
         this.progressiveLevelIcon.dispose();
         this.progressiveLevelIcon = null;
         this.rentIcon = null;
         this._typedData = null;
         this._progressiveLevelPosition = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._typedData != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               buttonMode = this._typedData.enabled || this._typedData.previewAvailable;
               this.progressiveLevelIcon.source = this._typedData.progressiveLevelIcon;
               inInventoryIcon.visible = !this._typedData.isRentable;
               this.rentIcon.visible = this._typedData.isRentable;
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.previewButton.x = width >> 1;
               this.rentIcon.x = inInventoryIcon.x;
               this.rentIcon.y = inInventoryIcon.y;
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this._progressiveLevelPosition = CardConfigs.getInstance().progressionLevelPosition.getConfig(_stageWidthBoundary,this._typedData.formfactor);
               this.progressiveLevelIcon.x = this._progressiveLevelPosition.x;
               this.progressiveLevelIcon.y = this._progressiveLevelPosition.y;
            }
         }
      }
      
      override protected function setData(param1:BaseCardVO) : void
      {
         super.setData(param1);
         this._typedData = param1 as CustomizationCardVO;
      }
      
      override protected function getRollOverTweens() : Vector.<Tween>
      {
         var _loc1_:Vector.<Tween> = super.getRollOverTweens();
         if(this.rentIcon.visible)
         {
            _loc1_.push(new Tween(FIRST_ANIMATION_DURATION,this.rentIcon,{"alpha":0},{
               "fastTransform":false,
               "delay":ROLL_OVER_ANIMATION_DELAY
            }));
         }
         _loc1_.push(new Tween(FIRST_ANIMATION_DURATION,this.progressiveLevelIcon,{"alpha":0.1},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         }));
         return _loc1_;
      }
      
      override protected function getRollOutTweens() : Vector.<Tween>
      {
         var _loc1_:Vector.<Tween> = super.getRollOutTweens();
         if(this.rentIcon.visible)
         {
            _loc1_.push(new Tween(FIRST_ANIMATION_DURATION,this.rentIcon,{"alpha":1},{"fastTransform":false}));
         }
         _loc1_.push(new Tween(FIRST_ANIMATION_DURATION,this.progressiveLevelIcon,{"alpha":1},{"fastTransform":false}));
         return _loc1_;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(this._typedData == null)
         {
            return;
         }
         if(App.utils.commons.isRightButton(param1))
         {
            if(this._typedData.contextMenuId)
            {
               dispatchEvent(new CardEvent(CardEvent.SHOW_CONTEXT_MENU,_data));
            }
         }
         else if(this._typedData.enabled)
         {
            dispatchEvent(new CardEvent(CardEvent.SELL,_data));
         }
         else if(this._typedData.previewAvailable)
         {
            dispatchEvent(new CardEvent(CardEvent.PREVIEW,_data));
         }
      }
      
      override protected function onRollOver() : void
      {
         super.onRollOver();
         this.previewButton.visible = this._typedData.previewAvailable;
      }
      
      override protected function onRollOut() : void
      {
         super.onRollOut();
         this.previewButton.visible = false;
      }
      
      private function onPreviewButtonClick(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            param1.stopImmediatePropagation();
            dispatchEvent(new CardEvent(CardEvent.PREVIEW,_data));
         }
      }
      
      private function onPreviewButtonRollOver(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(this._typedData.previewTooltip);
      }
      
      private function onPreviewButtonRollOut(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onProgressionIconLoaded(param1:Event) : void
      {
         invalidateLayout();
      }
      
      override public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         super.setStateSizeBoundaries(param1,param2);
         _imageSizeVO = CardConfigs.getInstance().customizationCardImage.getConfig(_stageWidthBoundary);
         invalidateLayout();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:CustomizationCardVO = param1 as CustomizationCardVO;
         if(this._typedData && this._typedData.isEqual(_loc2_))
         {
            return;
         }
         this.setData(_loc2_);
         invalidateData();
      }
   }
}
