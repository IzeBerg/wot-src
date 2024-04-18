package net.wg.gui.lobby.profile.pages.formations.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.data.managers.impl.ToolTipParams;
   
   public class FormationStatVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var value:String = "";
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public var tooltipParams:IToolTipParams = null;
      
      private const TOOLTIP_PARAMS:String = "tooltipParams";
      
      public function FormationStatVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == this.TOOLTIP_PARAMS)
         {
            this.tooltipParams = new ToolTipParams(param2.header != null ? param2.header : {},param2.body != null ? param2.body : {});
            App.utils.data.cleanupDynamicObject(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.tooltipParams != null)
         {
            this.tooltipParams.dispose();
            this.tooltipParams = null;
         }
         super.onDispose();
      }
   }
}
