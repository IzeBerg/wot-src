package net.wg.gui.battle.eventBattle.views.vehicleMarkers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EventVehicleMarkerMessage extends BattleUIComponent
   {
      
      private static const BG_OFFSET:uint = 14;
       
      
      public var messageAllyTF:TextField = null;
      
      public var messageNormalTF:TextField = null;
      
      public var messageBg:Sprite = null;
      
      public function EventVehicleMarkerMessage()
      {
         super();
      }
      
      public function setText(param1:String, param2:Boolean) : void
      {
         this.messageAllyTF.visible = param2;
         this.messageNormalTF.visible = !param2;
         var _loc3_:TextField = !!param2 ? this.messageAllyTF : this.messageNormalTF;
         _loc3_.text = param1;
         this.messageBg.width = Math.ceil(_loc3_.textWidth) + BG_OFFSET;
         this.messageBg.x = -Math.ceil(this.messageBg.width >> 1);
      }
      
      override protected function onDispose() : void
      {
         this.messageNormalTF = null;
         this.messageAllyTF = null;
         this.messageBg = null;
         super.onDispose();
      }
   }
}
