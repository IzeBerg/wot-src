package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleUpgradePanelMeta extends IEventDispatcher
   {
       
      
      function onSelectItemS(param1:int) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_toggleAlertState(param1:Boolean, param2:String) : void;
      
      function as_setVisible(param1:Boolean) : void;
      
      function as_showSelectAnim(param1:int) : void;
      
      function as_showNotificationAnim() : void;
      
      function as_hideNotificationAnim() : void;
   }
}
