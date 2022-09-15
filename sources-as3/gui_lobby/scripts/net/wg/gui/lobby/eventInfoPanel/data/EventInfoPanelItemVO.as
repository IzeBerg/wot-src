package net.wg.gui.lobby.eventInfoPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventInfoPanelItemVO extends DAAPIDataClass
   {
       
      
      public var head:String = "";
      
      public var descr:String = "";
      
      public function EventInfoPanelItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.head = null;
         this.descr = null;
         super.onDispose();
      }
   }
}
