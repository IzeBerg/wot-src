package net.wg.gui.battle.battleRoyale.views.components
{
   import net.wg.gui.battle.components.StatusNotificationsPanel;
   import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
   
   public class BRZoneDamageIconContent extends BattleRoyaleIconContent implements IStatusNotificationCallback
   {
       
      
      private var _callbackTypes:Vector.<String> = null;
      
      public function BRZoneDamageIconContent()
      {
         super();
         animation.stop();
         this._callbackTypes = new <String>[StatusNotificationsPanel.ZONE_DAMAGE_EVENT_TYPE];
      }
      
      override protected function onDispose() : void
      {
         if(this._callbackTypes)
         {
            this._callbackTypes.length = 0;
            this._callbackTypes = null;
         }
      }
      
      public function getCallbackTypes() : Vector.<String>
      {
         return this._callbackTypes;
      }
      
      public function invoke(param1:String) : void
      {
         if(param1 == StatusNotificationsPanel.ZONE_DAMAGE_EVENT_TYPE)
         {
            animation.gotoAndPlay(1);
         }
      }
   }
}
