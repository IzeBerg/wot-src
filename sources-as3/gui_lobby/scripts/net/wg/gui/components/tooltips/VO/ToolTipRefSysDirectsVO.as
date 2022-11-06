package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ToolTipRefSysDirectsVO extends DAAPIDataClass
   {
       
      
      public var infoTitle:String = "";
      
      public var infoDirection:String = "";
      
      public var infoMapName:String = "";
      
      public var infoTotalValue:String = "";
      
      public var infoDescription1:String = "";
      
      public var infoValue1:String = "";
      
      public var infoDescription2:String = "";
      
      public var infoValue2:String = "";
      
      public var infoDescription3:String = "";
      
      public var infoValue3:String = "";
      
      public var infoTotalDescription:String = "";
      
      public var isMapEnabled:Boolean = false;
      
      public var mapTexture:String = "";
      
      public var mapPoints:Array = null;
      
      public function ToolTipRefSysDirectsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.mapPoints = null;
         super.onDispose();
      }
   }
}
