package net.wg.gui.battle.eventBattle.views.radialMenu.components
{
   import flash.display.Sprite;
   import flash.text.TextFormatAlign;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EventContent extends Sprite implements IDisposable
   {
      
      private static const TITLE_ANGLE_OFFSET:int = 5;
      
      private static const TITLE_OFFSET_RADIUS:int = 143;
      
      private static const MESSAGE_OFFSET:int = -35;
      
      private static const DEG_TO_RAD:Number = 1 / 180 * Math.PI;
      
      private static const HALF_PI:Number = Math.PI / 2;
       
      
      public var commandContainer:CommandContainer = null;
      
      public var chatContainer:ChatContainer = null;
      
      private var _radialState:String = "";
      
      private var _isChat:Boolean = false;
      
      public function EventContent()
      {
         super();
         this.commandContainer.visible = false;
         this.chatContainer.visible = false;
      }
      
      public final function dispose() : void
      {
         this.commandContainer.dispose();
         this.commandContainer = null;
         this.chatContainer.dispose();
         this.chatContainer = null;
      }
      
      public function setTitle(param1:String) : void
      {
         if(this._isChat)
         {
            this.chatContainer.setTitleText(param1,this._radialState);
         }
         else
         {
            this.commandContainer.setTitleText(param1,this._radialState);
         }
      }
      
      public function setKey(param1:String) : void
      {
         this.commandContainer.setKeyText(param1);
      }
      
      public function setRadialState(param1:String) : void
      {
         this._radialState = param1;
      }
      
      public function setChatState(param1:Boolean) : void
      {
         this.commandContainer.visible = !param1;
         this.chatContainer.visible = param1;
         this._isChat = param1;
      }
      
      public function setRotation(param1:Number) : void
      {
         var _loc4_:Number = NaN;
         this.commandContainer.rotation = param1;
         this.chatContainer.rotation = param1;
         var _loc2_:Number = -param1 * DEG_TO_RAD;
         var _loc3_:Number = TITLE_ANGLE_OFFSET * DEG_TO_RAD;
         if(_loc2_ > 0 && _loc2_ < Math.PI)
         {
            _loc4_ = _loc2_ - HALF_PI - _loc3_;
            this.commandContainer.setAlign(TextFormatAlign.LEFT);
         }
         else
         {
            _loc4_ = _loc2_ + HALF_PI + _loc3_;
            this.commandContainer.setAlign(TextFormatAlign.RIGHT);
         }
         this.commandContainer.x = -TITLE_OFFSET_RADIUS * Math.sin(_loc4_) >> 0;
         this.commandContainer.y = -Math.abs(TITLE_OFFSET_RADIUS * Math.cos(_loc4_)) >> 0;
         this.chatContainer.y = MESSAGE_OFFSET * Math.abs(Math.sin(_loc2_)) >> 0;
      }
   }
}
