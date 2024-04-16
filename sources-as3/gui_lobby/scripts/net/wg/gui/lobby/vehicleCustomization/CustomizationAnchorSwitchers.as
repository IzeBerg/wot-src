package net.wg.gui.lobby.vehicleCustomization
{
   import flash.ui.Keyboard;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemSwitchEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class CustomizationAnchorSwitchers extends UIComponentEx
   {
      
      private static const BTN_H_POS:int = 68;
      
      private static const KEY_UP_DELAY:int = 100;
      
      private static const KEY:String = "key";
       
      
      public var switchRightBtn:ISoundButtonEx = null;
      
      public var switchLeftBtn:ISoundButtonEx = null;
      
      private var _scheduler:IScheduler;
      
      public function CustomizationAnchorSwitchers()
      {
         super();
      }
      
      private static function createInputEvent(param1:String, param2:InputDetails) : InputEvent
      {
         var _loc3_:InputDetails = new InputDetails(KEY,param2.code,param1,NavigationCode.ENTER,0,param2.ctrlKey,param2.altKey,param2.shiftKey);
         return new InputEvent(InputEvent.INPUT,_loc3_);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._scheduler = App.utils.scheduler;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.switchLeftBtn.soundEnabled = this.switchRightBtn.soundEnabled = false;
         focusable = false;
         this.switchRightBtn.focusable = false;
         this.switchLeftBtn.focusable = false;
         addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.switchLeftBtn.handleInput);
         this._scheduler.cancelTask(this.switchRightBtn.handleInput);
         this._scheduler = null;
         removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.switchRightBtn.dispose();
         this.switchRightBtn = null;
         this.switchLeftBtn.dispose();
         this.switchLeftBtn = null;
         super.onDispose();
      }
      
      public function onKeyDownHandler(param1:InputDetails = null) : void
      {
         if(param1.code == Keyboard.LEFT)
         {
            this.keyDownHandler(this.switchLeftBtn,param1);
         }
         else if(param1.code == Keyboard.RIGHT)
         {
            this.keyDownHandler(this.switchRightBtn,param1);
         }
      }
      
      public function setGapOffset(param1:int) : void
      {
         this.switchLeftBtn.x = -BTN_H_POS - param1;
         this.switchRightBtn.x = BTN_H_POS + param1;
      }
      
      public function updateAvailableScroll(param1:Boolean, param2:Boolean) : void
      {
         this.switchLeftBtn.enabled = param1;
         this.switchRightBtn.enabled = param2;
      }
      
      private function keyDownHandler(param1:ISoundButtonEx, param2:InputDetails) : void
      {
         this._scheduler.cancelTask(param1.handleInput);
         this._scheduler.scheduleTask(param1.handleInput,KEY_UP_DELAY,createInputEvent(InputValue.KEY_UP,param2));
         param1.handleInput(createInputEvent(InputValue.KEY_DOWN,param2));
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CustomizationItemSwitchEvent(CustomizationItemSwitchEvent.SELECT_NEXT_ITEM,param1.target == this.switchLeftBtn,true));
      }
   }
}
