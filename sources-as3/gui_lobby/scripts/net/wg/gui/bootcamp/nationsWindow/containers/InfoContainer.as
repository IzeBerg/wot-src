package net.wg.gui.bootcamp.nationsWindow.containers
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class InfoContainer extends UIComponentEx
   {
       
      
      public var title:TextField = null;
      
      public var historicalTitle:TextField = null;
      
      public var historicReference:TextField = null;
      
      public function InfoContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.historicalTitle.text = VEHICLE_PREVIEW.INFOPANEL_TAB_ELITEFACTSHEET_INFO;
      }
      
      override protected function onDispose() : void
      {
         this.title = null;
         this.historicalTitle = null;
         this.historicReference = null;
         super.onDispose();
      }
      
      public function selectNation(param1:String, param2:String) : void
      {
         this.title.text = param1;
         this.historicReference.text = param2;
      }
   }
}
