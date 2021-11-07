package net.wg.gui.events
{
   import flash.events.Event;
   import net.wg.gui.lobby.components.maintenance.data.MaintenanceShellVO;
   
   public class ShellRendererEvent extends Event
   {
      
      public static const USER_COUNT_CHANGED:String = "userCountChanged";
      
      public static const TOTAL_PRICE_CHANGED:String = "totalPriceChanged";
      
      public static const CHANGE_ORDER:String = "changeOrder";
      
      public static const CURRENCY_CHANGED:String = "currencyChanged";
       
      
      public var shell:MaintenanceShellVO = null;
      
      public var shellToReplace:MaintenanceShellVO = null;
      
      public function ShellRendererEvent(param1:String, param2:MaintenanceShellVO = null, param3:MaintenanceShellVO = null)
      {
         super(param1,true,true);
         this.shell = param2;
         this.shellToReplace = param3;
      }
      
      override public function clone() : Event
      {
         return new ShellRendererEvent(type,this.shell,this.shellToReplace);
      }
   }
}
