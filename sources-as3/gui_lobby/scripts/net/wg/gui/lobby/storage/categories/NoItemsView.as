package net.wg.gui.lobby.storage.categories
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
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
       
      
      public var navigateButton:SoundButtonEx;
      
      public var labelTF:TextField;
      
      public var noItemsMc:MovieClip;
      
      public function NoItemsView()
      {
         super();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         if(param2 >= StageSizeBoundaries.HEIGHT_900)
         {
            this.noItemsMc.scaleX = this.noItemsMc.scaleY = NORMAL_SCALE;
         }
         else
         {
            this.noItemsMc.scaleX = this.noItemsMc.scaleY = SMALL_SCALE;
         }
         this.noItemsMc.x = param1 - this.noItemsMc.width >> 1;
         invalidateSize();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         App.stageSizeMgr.register(this);
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
         if(isInvalid(InvalidationType.SIZE))
         {
            this.noItemsMc.x = width - this.noItemsMc.width >> 1;
            this.labelTF.width = width;
            this.labelTF.y = this.noItemsMc.y + this.noItemsMc.height + LABEL_OFFSET;
            this.navigateButton.validateNow();
            this.navigateButton.x = width - this.navigateButton.width >> 1;
            this.navigateButton.y = this.labelTF.y + this.labelTF.height + NAVIGATION_BUTTON_OFFSET | 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.navigateButton.removeEventListener(ButtonEvent.CLICK,this.onNavigationButtonClickHandler);
         this.navigateButton.dispose();
         this.navigateButton = null;
         this.labelTF = null;
         this.noItemsMc = null;
         super.onDispose();
      }
      
      public function setTexts(param1:String, param2:String = null) : void
      {
         this.labelTF.text = param1;
         if(param2)
         {
            this.navigateButton.label = param2;
            this.navigateButton.visible = true;
         }
         else
         {
            this.navigateButton.visible = false;
         }
         invalidateSize();
      }
      
      private function onNavigationButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new Event(Event.CLOSE));
      }
   }
}
