package net.wg.gui.lobby.settings.feedback.ribbons
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.lobby.settings.events.SettingsGroupEvent;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class ControlsGroup extends UIComponent
   {
      
      private static const PREFIX_OPEN:String = "open_";
      
      private static const PREFIX_CLOSE:String = "close_";
      
      private static const STATE_UP:String = "up";
      
      private static const STATE_OVER:String = "over";
       
      
      public var hitMC:Sprite;
      
      public var titleTF:TextField;
      
      public var content:UIComponent;
      
      private var _prefix:String;
      
      private var _state:String;
      
      private var _defaultContentVisibilityState:Boolean = false;
      
      public function ControlsGroup()
      {
         super();
      }
      
      public function getControlByName(param1:String) : IDisplayObject
      {
         return this.content.getChildByName(param1) as IDisplayObject;
      }
      
      public function set title(param1:String) : void
      {
         this.titleTF.text = param1;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         if(initialized)
         {
            this.content.visible = param1;
            this.updateState();
         }
         else
         {
            this._defaultContentVisibilityState = param1;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.content.visible = this._defaultContentVisibilityState;
         this._prefix = !!this._defaultContentVisibilityState ? PREFIX_OPEN : PREFIX_CLOSE;
         this._state = STATE_UP;
         this.hitMC.buttonMode = true;
         this.hitMC.addEventListener(MouseEvent.CLICK,this.clickHandler);
         this.hitMC.addEventListener(MouseEvent.MOUSE_OVER,this.overOutHandler);
         this.hitMC.addEventListener(MouseEvent.MOUSE_OUT,this.overOutHandler);
         this.content.addEventListener(Event.RESIZE,this.resizeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            setSize(actualWidth,!!this.content.visible ? Number(actualHeight) : Number(this.content.y));
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.gotoAndPlay(this._prefix + this._state);
         }
      }
      
      override protected function onDispose() : void
      {
         this.hitMC.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         this.hitMC.removeEventListener(MouseEvent.MOUSE_OVER,this.overOutHandler);
         this.hitMC.removeEventListener(MouseEvent.MOUSE_OUT,this.overOutHandler);
         this.hitMC = null;
         this.titleTF = null;
         this.content.removeEventListener(Event.RESIZE,this.resizeHandler);
         this.content.dispose();
         this.content = null;
         super.onDispose();
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         this.content.visible = !this.content.visible;
         this.updateState();
      }
      
      private function updateState() : void
      {
         this._prefix = !!this.content.visible ? PREFIX_OPEN : PREFIX_CLOSE;
         invalidate(InvalidationType.LAYOUT,InvalidationType.STATE);
         dispatchEvent(new SettingsGroupEvent(SettingsGroupEvent.ON_GROUP_STATE_CHANGE,true));
      }
      
      private function overOutHandler(param1:MouseEvent) : void
      {
         this._state = param1.type == MouseEvent.MOUSE_OVER ? STATE_OVER : STATE_UP;
         invalidateState();
      }
      
      private function resizeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
