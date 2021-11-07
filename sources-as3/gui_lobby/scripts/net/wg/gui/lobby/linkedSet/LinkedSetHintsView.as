package net.wg.gui.lobby.linkedSet
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.gui.lobby.linkedSet.components.AnimatedLoaderContainer;
   import net.wg.gui.lobby.linkedSet.components.AnimatedMovieClipContainer;
   import net.wg.gui.lobby.linkedSet.components.LinkedSetAward;
   import net.wg.gui.lobby.linkedSet.data.LinkedSetHintsVO;
   import net.wg.infrastructure.base.meta.ILinkedSetHintsViewMeta;
   import net.wg.infrastructure.base.meta.impl.LinkedSetHintsViewMeta;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class LinkedSetHintsView extends LinkedSetHintsViewMeta implements ILinkedSetHintsViewMeta, IPopOverCaller
   {
      
      private static const ICON_OFFSET:int = 35;
      
      private static const BUTTON_OFFSET:int = 95;
      
      private static const AWARD_OFFSET:int = 80;
      
      private static const LABEL_IN:String = "in";
       
      
      public var titleContainer:AnimatedMovieClipContainer = null;
      
      public var descriptionContainer:AnimatedMovieClipContainer = null;
      
      public var iconContainer:AnimatedLoaderContainer = null;
      
      public var lightContainer:AnimatedMovieClipContainer = null;
      
      public var effectContainer:AnimatedMovieClipContainer = null;
      
      public var backContainer:AnimatedMovieClipContainer = null;
      
      public var btnContinue:IconTextBigButton = null;
      
      public var awardsContainer:AnimatedMovieClipContainer = null;
      
      private var _data:LinkedSetHintsVO = null;
      
      public function LinkedSetHintsView()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnContinue.addEventListener(ButtonEvent.CLICK,this.onBtnContinueClickHandler);
         this.btnContinue.usePreventUpdateTextScale = true;
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.btnContinue);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            closeViewS();
         }
      }
      
      public function getTargetButton() : DisplayObject
      {
         return DisplayObject(this.btnContinue);
      }
      
      public function getHitArea() : DisplayObject
      {
         return DisplayObject(this.btnContinue);
      }
      
      override protected function setData(param1:LinkedSetHintsVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function updateLayout() : void
      {
         this.iconContainer.x = this.lightContainer.x = this.effectContainer.x = this.titleContainer.x = this.descriptionContainer.x = this.awardsContainer.x = width >> 1;
         this.iconContainer.y = this.lightContainer.y = this.effectContainer.y = this.titleContainer.y = this.descriptionContainer.y = this.awardsContainer.y = (height >> 1) + ICON_OFFSET;
         this.btnContinue.x = width - this.btnContinue.width >> 1;
         this.btnContinue.y = height - BUTTON_OFFSET;
         this.backContainer.x = 0;
         this.backContainer.y = 0;
         this.backContainer.width = width;
         this.backContainer.height = height;
      }
      
      override protected function draw() : void
      {
         var _loc1_:LinkedSetAward = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.titleContainer.gotoAndPlay(LABEL_IN);
            this.descriptionContainer.gotoAndPlay(LABEL_IN);
            this.iconContainer.gotoAndPlay(LABEL_IN);
            this.lightContainer.gotoAndPlay(LABEL_IN);
            this.effectContainer.gotoAndPlay(LABEL_IN);
            this.awardsContainer.gotoAndPlay(LABEL_IN);
            this.clearAwards();
            _loc2_ = this._data.awards.length;
            _loc3_ = 0 - _loc2_ * AWARD_OFFSET >> 1;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc1_ = App.utils.classFactory.getComponent(Linkages.LINKED_SET_AWARD_UI,LinkedSetAward);
               _loc1_.x = _loc3_;
               _loc3_ += AWARD_OFFSET;
               _loc1_.setData(this._data.awards[_loc4_]);
               this.awardsContainer.addContent(_loc1_);
               _loc4_++;
            }
            this.titleContainer.text = this._data.title;
            this.descriptionContainer.text = this._data.description;
            this.iconContainer.source = this._data.icon;
            this.lightContainer.frame = this._data.back;
            this.effectContainer.frame = this._data.back;
            this.backContainer.frame = this._data.back;
            this.btnContinue.label = this._data.buttonLabel;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      private function clearAwards() : void
      {
         this.awardsContainer.removeAllContent();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.clearAwards();
         this.btnContinue.removeEventListener(ButtonEvent.CLICK,this.onBtnContinueClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.titleContainer.dispose();
         this.descriptionContainer.dispose();
         this.iconContainer.dispose();
         this.lightContainer.dispose();
         this.effectContainer.dispose();
         this.backContainer.dispose();
         this.titleContainer = null;
         this.descriptionContainer = null;
         this.iconContainer = null;
         this.lightContainer = null;
         this.effectContainer = null;
         this.backContainer = null;
         this.btnContinue.dispose();
         this.btnContinue = null;
         this.awardsContainer.dispose();
         this.awardsContainer = null;
         this._data = null;
         super.onDispose();
      }
      
      private function onBtnContinueClickHandler(param1:ButtonEvent) : void
      {
         closeViewS();
      }
   }
}
