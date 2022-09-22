package net.wg.gui.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AwardItemVO extends DAAPIDataClass
   {
       
      
      public var imgSource:String = "";
      
      public var label:String = "";
      
      public var counter:String = "";
      
      public var highlight:String = "";
      
      public var overlay:String = "";
      
      public var scaleImg:Number = 1;
      
      public function AwardItemVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
