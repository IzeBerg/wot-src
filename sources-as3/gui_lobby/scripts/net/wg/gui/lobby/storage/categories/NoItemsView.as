package net.wg.gui.lobby.storage.categories
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class NoItemsView extends UIComponentEx implements IStageSizeDependComponent
   {
      
      private static const NORMAL_SCALE:int = 1;
      
      private static const SMALL_SCALE:Number = 0.75;
      
      private static const LABEL_OFFSET:int = 35;
      
      private static const NAVIGATION_BUTTON_OFFSET:int = 15;
      
      private static const ERROR_IMAGE_NOT_LOADED:String = "[NoItemsView] onNoItemsImageIoerrorHandler | Image not loaded: ";
       
      
      public var navigateButton:SoundButtonEx;
      
      public var labelTF:TextField;
      
      public var noItemsImage:UILoaderAlt;
      
      private var _stageSizeBondariesH:int = -1;
      
      private var _noItemsImageLoaded:Boolean = false;
      
      private var _nextVisibleWhileViewNotReady:Boolean = false;
      
      private var _needSetNextVisible:Boolean = false;
      
      private var _layoutReady:Boolean = false;
      
      public function NoItemsView()
      {
         super();
      }
      
      override public function invalidateSize() : void
      {
         this._layoutReady = false;
         super.invalidateSize();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         App.stageSizeMgr.register(this);
         this.noItemsImage.addEventListener(UILoaderEvent.COMPLETE,this.onNoItemsImageCompleteHandler);
         this.noItemsImage.addEventListener(UILoaderEvent.IOERROR,this.onNoItemsImageIoerrorHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.labelTF.multiline = true;
         this.labelTF.autoSize = TextFieldAutoSize.CENTER;
         this.navigateButton.autoSize = TextFieldAutoSize.LEFT;
         this.navigateButton.addEventListener(ButtonEvent.CLICK,this.onNavigationButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE) && this._noItemsImageLoaded && this._stageSizeBondariesH != Values.DEFAULT_INT)
         {
            if(this._stageSizeBondariesH >= StageSizeBoundaries.HEIGHT_900)
            {
               this.noItemsImage.scaleX = this.noItemsImage.scaleY = NORMAL_SCALE;
            }
            else
            {
               this.noItemsImage.scaleX = this.noItemsImage.scaleY = SMALL_SCALE;
            }
            this.noItemsImage.x = width - this.noItemsImage.width >> 1;
            this.labelTF.width = width;
            this.labelTF.y = this.noItemsImage.y + this.noItemsImage.height + LABEL_OFFSET;
            this.navigateButton.x = width - this.navigateButton.width >> 1;
            this.navigateButton.y = this.labelTF.y + this.labelTF.height + NAVIGATION_BUTTON_OFFSET | 0;
            this._layoutReady = true;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.navigateButton.removeEventListener(ButtonEvent.CLICK,this.onNavigationButtonClickHandler);
         this.noItemsImage.removeEventListener(UILoaderEvent.IOERROR,this.onNoItemsImageIoerrorHandler);
         this.noItemsImage.removeEventListener(UILoaderEvent.COMPLETE,this.onNoItemsImageCompleteHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.navigateButton.dispose();
         this.navigateButton = null;
         this.labelTF = null;
         this.noItemsImage.dispose();
         this.noItemsImage = null;
         super.onDispose();
      }
      
      public function isLayoutReady() : Boolean
      {
         return this._layoutReady;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._stageSizeBondariesH = param2;
         this.invalidateSize();
      }
      
      public function setTexts(param1:String, param2:String = null) : void
      {
         this.labelTF.text = param1;
         if(param2)
         {
            this.navigateButton.label = param2;
            this.navigateButton.validateNow();
            this.navigateButton.visible = true;
         }
         else
         {
            this.navigateButton.visible = false;
         }
         this.invalidateSize();
      }
      
      public function updateVisibility() : void
      {
         if(this._layoutReady)
         {
            if(this._needSetNextVisible)
            {
               this.visible = this._nextVisibleWhileViewNotReady;
               this._needSetNextVisible = false;
            }
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(!param1 || this._layoutReady)
         {
            super.visible = param1;
         }
         else
         {
            this._needSetNextVisible = true;
            this._nextVisibleWhileViewNotReady = param1;
         }
      }
      
      private function onNoItemsImageIoerrorHandler(param1:UILoaderEvent) : void
      {
         this._noItemsImageLoaded = true;
         this.invalidateSize();
      }
      
      private function onNoItemsImageCompleteHandler(param1:UILoaderEvent) : void
      {
         this._noItemsImageLoaded = true;
         this.invalidateSize();
      }
      
      private function onNavigationButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new Event(Event.CLOSE));
      }
   }
}
