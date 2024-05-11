package net.wg.gui.notification.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.data.TabsVO;
   
   public class NotificationViewInitVO extends DAAPIDataClass
   {
      
      private static const TABS_FIELD_NAME:String = "tabsData";
       
      
      public var scrollStepFactor:Number = -1;
      
      public var tabsData:TabsVO = null;
      
      public var btnBarSelectedIdx:int = 0;
      
      public function NotificationViewInitVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TABS_FIELD_NAME)
         {
            this.tabsData = new TabsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.tabsData.dispose();
         this.tabsData = null;
         super.onDispose();
      }
   }
}
