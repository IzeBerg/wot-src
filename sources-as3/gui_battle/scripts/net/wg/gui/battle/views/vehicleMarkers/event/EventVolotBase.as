package net.wg.gui.battle.views.vehicleMarkers.event
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class EventVolotBase extends Sprite implements IDisposable
   {
       
      
      public var distanceTF:TextField;
      
      public var messageTF:TextField;
      
      public var hover:Sprite;
      
      public var repliedMe:Sprite;
      
      private var _messageDistanceGap:int;
      
      public function EventVolotBase(param1:String = null)
      {
         super();
         this.hover.visible = false;
         this.repliedMe.visible = false;
         TextFieldEx.setNoTranslate(this.distanceTF,true);
         this._messageDistanceGap = this.distanceTF.y - this.messageTF.y - this.messageTF.height;
         this.messageTF.autoSize = TextFieldAutoSize.CENTER;
         if(param1 != null)
         {
            this.setMessage(param1);
         }
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setDistance(param1:String) : void
      {
         this.distanceTF.text = param1;
      }
      
      public function setHovered(param1:Boolean) : void
      {
         if(this.hover != null)
         {
            this.hover.visible = param1;
         }
      }
      
      public function setRepliedMeVisible(param1:Boolean) : void
      {
         this.repliedMe.visible = param1;
      }
      
      protected function setMessage(param1:String) : void
      {
         this.messageTF.text = param1;
         this.distanceTF.y = this.messageTF.y + this.messageTF.height + this._messageDistanceGap | 0;
      }
      
      protected function onDispose() : void
      {
         this.distanceTF = null;
         this.messageTF = null;
         this.hover = null;
         this.repliedMe = null;
      }
   }
}
